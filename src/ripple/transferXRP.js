const xrpl = require("xrpl");

const buildResponse = (statusCode, body) => ({
  statusCode,
  body: JSON.stringify(body),
});

// Transferir XRP
exports.transferXRP = async (event) => {
  const { to, amount, secret } = JSON.parse(event.body);

  try {
    const client = new xrpl.Client("wss://s.altnet.rippletest.net:51233");
    await client.connect();

    const wallet = xrpl.Wallet.fromSeed(secret);
    const transaction = {
      TransactionType: "Payment",
      Account: wallet.address,
      Destination: to,
      Amount: (amount * 1_000_000).toString(), // Converter para drops
    };

    const prepared = await client.autofill(transaction);
    const signed = wallet.sign(prepared);
    const result = await client.submitAndWait(signed.tx_blob);
    await client.disconnect();

    return buildResponse(200, { result });
  } catch (error) {
    console.error("Error transferring XRP:", error);
    return buildResponse(500, { message: "Failed to transfer XRP" });
  }
};
