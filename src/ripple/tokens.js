const xrpl = require("xrpl");

const buildResponse = (statusCode, body) => ({
  statusCode,
  body: JSON.stringify(body),
});

//-----------------------------------------------------------------
// Criar um novo token fungível
//-----------------------------------------------------------------

exports.createToken = async (event) => {
  const {
    issuerSecret,
    clientAddress,
    clientSecret,
    currencyCode,
    totalSupply,
  } = JSON.parse(event.body);

  if (!issuerSecret || !clientAddress || !currencyCode || !totalSupply) {
    return {
      statusCode: 400,
      body: JSON.stringify({
        message:
          "issuerSecret, clientAddress, currencyCode, and totalSupply parameters are required",
      }),
    };
  }

  let client;

  try {
    client = new xrpl.Client("wss://s.altnet.rippletest.net:51233");
    await client.connect();
    console.log("Connected to Ripple Testnet.");

    const issuerWallet = xrpl.Wallet.fromSeed(issuerSecret);
    const clientWallet = xrpl.Wallet.fromSeed(clientSecret);

    // Configurar TrustLine do emissor para o cliente
    console.log("Preparing TrustSet transaction...");
    const clientTrustSetTx = {
      TransactionType: "TrustSet",
      Account: clientWallet.address,
      LimitAmount: {
        currency: currencyCode,
        issuer: issuerWallet.address,
        value: totalSupply.toString(),
      },
    };

    const preparedClientTrustSet = await client.autofill(clientTrustSetTx);
    const signedClientTrustSet = clientWallet.sign(preparedClientTrustSet);
    console.log("Submitting TrustSet transaction...");
    const clientTrustSetResult = await client.submitAndWait(
      signedClientTrustSet.tx_blob
    );

    if (clientTrustSetResult.result.meta.TransactionResult !== "tesSUCCESS") {
      throw new Error(
        `TrustSet failed: ${clientTrustSetResult.result.meta.TransactionResult}`
      );
    }
    console.log("TrustLine configured successfully.");

    // Emitir tokens (pagamento do emissor para o cliente)
    console.log("Preparing mint transaction...");
    const mintTransaction = {
      TransactionType: "Payment",
      Account: issuerWallet.address,
      Destination: clientWallet.address,
      Amount: {
        currency: currencyCode,
        issuer: issuerWallet.address,
        value: totalSupply.toString(),
      },
    };

    const preparedMintTx = await client.autofill(mintTransaction);
    const signedMintTx = issuerWallet.sign(preparedMintTx);

    console.log("Submitting mint transaction...");
    const mintResult = await client.submitAndWait(signedMintTx.tx_blob);

    console.log("Mint result:", JSON.stringify(mintResult, null, 2));

    if (mintResult.result.meta.TransactionResult !== "tesSUCCESS") {
      throw new Error(
        `Minting failed: ${mintResult.result.meta.TransactionResult}`
      );
    }

    console.log("Tokens minted successfully.");

    await client.disconnect();

    return {
      statusCode: 200,
      body: JSON.stringify({
        message: "Token created and minted successfully",
        transactionHash: mintResult.result.tx_json.hash,
        token: {
          issuer: issuerWallet.address,
          client: clientWallet.address,
          currencyCode,
          totalSupply,
        },
      }),
    };
  } catch (error) {
    console.error("Error in createToken:", error);
    return {
      statusCode: 500,
      body: JSON.stringify({
        message: "Failed to create token",
        error: error.message,
      }),
    };
  } finally {
    if (client && client.isConnected()) {
      await client.disconnect();
    }
  }
};

//-----------------------------------------------------------------
// Buscar detalhes de um token fungível
//-----------------------------------------------------------------

exports.getTokenDetails = async (event) => {
  const { issuer, client, currencyCode } = event.queryStringParameters || {};

  if (!issuer || !client || !currencyCode) {
    return {
      statusCode: 400,
      body: JSON.stringify({
        message: "issuer, client, and currencyCode parameters are required",
      }),
    };
  }

  try {
    // Conectar ao Ripple Testnet
    const clientRipple = new xrpl.Client("wss://s.altnet.rippletest.net:51233");
    await clientRipple.connect();
    console.log("Connected to Ripple Testnet.");

    // Consultar TrustLines associadas ao cliente
    const accountLines = await clientRipple.request({
      command: "account_lines",
      account: client,
    });

    // Procurar detalhes do token
    const tokenDetails = accountLines.result.lines.find(
      (line) => line.currency === currencyCode && line.account === issuer
    );

    await clientRipple.disconnect();

    if (!tokenDetails) {
      return {
        statusCode: 404,
        body: JSON.stringify({ message: "Token not found" }),
      };
    }

    return {
      statusCode: 200,
      body: JSON.stringify({ token: tokenDetails }),
    };
  } catch (error) {
    console.error("Error fetching token details:", error);
    return {
      statusCode: 500,
      body: JSON.stringify({
        message: "Failed to fetch token details",
        error: error.message,
      }),
    };
  }
};

//-----------------------------------------------------------------
// Transfer Token - Esta função transfere tokens entre contas que possuem TrustLines configuradas.
//-----------------------------------------------------------------

exports.transferToken = async (event) => {
  const { senderSecret, recipient, amount, currencyCode } = JSON.parse(
    event.body
  );

  if (!senderSecret || !recipient || !amount || !currencyCode) {
    return {
      statusCode: 400,
      body: JSON.stringify({
        message:
          "senderSecret, recipient, amount, and currencyCode parameters are required",
      }),
    };
  }

  let client;

  try {
    client = new xrpl.Client("wss://s.altnet.rippletest.net:51233");
    await client.connect();

    const senderWallet = xrpl.Wallet.fromSeed(senderSecret);

    const transferTransaction = {
      TransactionType: "Payment",
      Account: senderWallet.address,
      Destination: recipient,
      Amount: {
        currency: currencyCode,
        issuer: senderWallet.address,
        value: amount.toString(),
      },
    };

    const preparedTx = await client.autofill(transferTransaction);
    const signedTx = senderWallet.sign(preparedTx);
    const result = await client.submitAndWait(signedTx.tx_blob);

    await client.disconnect();

    return {
      statusCode: 200,
      body: JSON.stringify({
        message: "Tokens transferred successfully",
        transactionHash: result.result.hash,
        details: {
          sender: senderWallet.address,
          recipient,
          currencyCode,
          amount,
        },
      }),
    };
  } catch (error) {
    console.error("Error in transferToken:", error);
    return {
      statusCode: 500,
      body: JSON.stringify({
        message: "Failed to transfer tokens",
        error: error.message,
      }),
    };
  } finally {
    if (client && client.isConnected()) {
      await client.disconnect();
    }
  }
};
