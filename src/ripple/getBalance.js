const xrpl = require("xrpl");

// Função para consultar saldo
exports.getBalance = async (event) => {
  const { address } = event.queryStringParameters || {};

  if (!address) {
    return {
      statusCode: 400,
      body: JSON.stringify({ message: "Address parameter is required" }),
    };
  }

  try {
    // Conecta ao XRPL Testnet
    const client = new xrpl.Client("wss://s.altnet.rippletest.net:51233");
    await client.connect();

    try {
      // Obtém informações da conta
      const balance = await client.getXrpBalance(address);
      await client.disconnect();

      // Verifica se a conta está ativada
      if (parseFloat(balance) < 10) {
        return {
          statusCode: 200,
          body: JSON.stringify({
            address,
            balance,
            activated: false,
            message: "Wallet is not activated. Minimum 10 XRP required.",
          }),
        };
      }

      return {
        statusCode: 200,
        body: JSON.stringify({
          address,
          balance,
          activated: true,
        }),
      };
    } catch (error) {
      // Tratar erro 'Account not found'
      if (error.data?.error === "actNotFound") {
        return {
          statusCode: 404,
          body: JSON.stringify({
            address,
            activated: false,
            message:
              "Wallet not found or not activated. Minimum 10 XRP required.",
          }),
        };
      }

      throw error; // Repassar outros erros
    }
  } catch (error) {
    console.error("Error fetching Ripple balance:", error);
    return {
      statusCode: 500,
      body: JSON.stringify({ message: "Failed to fetch Ripple balance" }),
    };
  }
};
