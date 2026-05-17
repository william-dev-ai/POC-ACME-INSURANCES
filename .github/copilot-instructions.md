# Copilot Instructions for POC-ACME-INSURANCES

## Context Exclusions
Copilot should never read or suggest content from:
- `backend/.env` - contains API keys and secrets
- `backend/.env.example` - contains sensitive configuration examples
- `database/` - contains raw financial data

## Coding Guidelines
- Always use Dutch for variable names related to financial data
- Never hardcode API keys or credentials
- Always add error handling to API endpoints