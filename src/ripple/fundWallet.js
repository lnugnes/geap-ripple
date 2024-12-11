const fetch = require("node-fetch"); // Biblioteca para requisições HTTP
const xrpl = require("xrpl"); // Biblioteca para validações de endereços

const buildResponse = (statusCode, body) => ({
  statusCode,
  body: JSON.stringify(body),
});

// Faucet: Financiar uma carteira no Ripple Testnet
exports.fundWallet = async (event) => {
  const { address } = event.queryStringParameters || {};

  if (!address) {
    return buildResponse(400, { message: "Address parameter is required" });
  }

  // Validação do endereço
  if (!xrpl.isValidClassicAddress(address)) {
    return buildResponse(400, { message: "Invalid Ripple address" });
  }

  try {
    const response = await fetch(
      "https://faucet.altnet.rippletest.net/accounts",
      {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({ destination: address }),
      }
    );

    if (!response.ok) {
      throw new Error(`Faucet request failed with status: ${response.status}`);
    }

    const result = await response.json();
    return buildResponse(200, {
      message: "Wallet funded successfully",
      faucetResponse: result,
    });
  } catch (error) {
    console.error("Error funding wallet with Faucet:", error);
    return buildResponse(500, {
      message: "Failed to fund wallet",
      error: error.message,
    });
  }
};
