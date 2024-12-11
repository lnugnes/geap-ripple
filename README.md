# GEAP Tokenization Platform - README

## Overview

The **GEAP Tokenization Platform** leverages the **XRPL SDK** to enable secure, transparent, and efficient tokenization of carbon offset assets. This platform is designed to provide scalability and compliance, utilizing the XRPL’s robust architecture for issuing, transferring, and managing tokenized assets.

## System Design

### Architecture Diagram

```
  +----------------+         +----------------+         +----------------+
  | User Interface | <-----> | API Gateway    | <-----> | XRPL Blockchain|
  | (Web/Mobile)   |         | (Backend)      |         | (Ledger)       |
  +----------------+         +----------------+         +----------------+
         |
         v
  +----------------+
  | Database       |
  | (PostgreSQL)   |
  +----------------+
```

### Narrative

1. **User Interface (UI)**: A responsive web/mobile interface that allows users to interact with the platform, manage accounts, and tokenize assets.
2. **API Gateway**: The backend logic implemented in Node.js that bridges the UI with XRPL SDK operations. Handles business logic, validation, and interaction with the XRPL.
3. **XRPL Blockchain**: The core layer where all tokenization and asset transactions are recorded securely and transparently.
4. **Database**: PostgreSQL stores metadata related to users, assets, and transactions for enhanced functionality and reporting.

## Quick Start Guide

### Prerequisites

- **Node.js** (v16+)
- **PostgreSQL** (v12+)
- **XRPL SDK** (v2.0)
- Docker (Optional for containerized setup)

### Setup Instructions

1. Clone the repository:

   ```bash
   git clone https://github.com/GEAP-Earth/tokenization-platform.git
   cd tokenization-platform
   ```

2. Install dependencies:

   ```bash
   npm install
   ```

3. Configure environment variables:
   Create a `.env` file with the following keys:

   ```env
   DATABASE_URL=postgresql://user:password@localhost:5432/geap
   XRPL_NETWORK=wss://s.altnet.rippletest.net:51233
   PORT=3000
   ```

4. Start the application:

   ```bash
   npm run start
   ```

5. Access the platform at `http://localhost:3000`.

### Docker Setup (Optional)

```bash
docker-compose up --build
```

## Code Repository Organization

```
/tokenization-platform
├── src
│   ├── controllers       # API handlers for user and token routes
│   ├── models            # Database schemas and models
│   ├── services          # Core business logic (XRPL integration, validation, etc.)
│   ├── utils             # Utility functions (encryption, logging, etc.)
│   └── config            # Environment and configuration setup
├── tests                 # Unit and integration tests
├── public                # Frontend assets
├── docker-compose.yml    # Docker configuration
└── package.json          # Node.js dependencies
```

## Libraries and Dependencies

- **XRPL SDK**: Core library for interacting with the XRP Ledger. [XRPL SDK Documentation](https://xrpl.org)
- **Express.js**: Backend framework for building APIs.
- **Sequelize**: ORM for database management.
- **dotenv**: For managing environment variables.
- **PostgreSQL**: Database for metadata storage.

If any code is forked or heavily influenced by existing repositories, it is explicitly documented in the respective file headers.

## XRPL Integration

The platform integrates with the XRPL SDK in the following areas:

1. **Asset Tokenization**: XRPL’s token creation APIs are used to issue new tokens for carbon offset credits.
2. **Transactions**: Uses XRPL’s `Payment` transaction type to transfer tokens securely between accounts.
3. **Ledger Interactions**: Queries the XRPL ledger for transaction history, account balances, and token metadata.

Integration points are located in the `src/services/xrplService.js` file, which handles all interactions with the XRPL.

## Acknowledgments

This project is built on open-source technologies and leverages the XRPL’s capabilities to enable sustainable solutions in carbon offset trading. Contributions are welcome!
