const xrpl = require("xrpl");

// Função para criar uma carteira
exports.createWallet = async (event) => {
  if (event.httpMethod === "OPTIONS") {
    return {
      statusCode: 200,
      headers: {
        "Access-Control-Allow-Origin": "*",
        "Access-Control-Allow-Methods": "GET, POST, OPTIONS",
        "Access-Control-Allow-Headers": "Content-Type, x-api-key",
      },
      body: "",
    };
  }
  try {
    const wallet = xrpl.Wallet.generate();
    return {
      statusCode: 200,
      headers: {
        "Access-Control-Allow-Origin": "*",
        "Access-Control-Allow-Methods": "GET, POST, OPTIONS",
        "Access-Control-Allow-Headers": "Content-Type, x-api-key",
      },
      body: JSON.stringify({
        address: wallet.address,
        secret: wallet.seed,
      }),
    };
  } catch (error) {
    console.error("Error creating Ripple wallet:", error);
    return {
      statusCode: 500,
      body: JSON.stringify({ message: "Failed to create Ripple wallet" }),
    };
  }
};
