# Ballerina HubSpot CRM Object Schemas connector

This use case demonstrates how the `hubspot.crm.object.schemas` API can be utilized to create and update a schema for a product. First a schema is created to represent a product. Then the Update endpoint is used to update the existing schema with new properties.

## Prerequisites

### 1. Setup the Hubspot developer account

Refer to the [Setup guide](https://github.com/ballerina-platform/module-ballerinax-hubspot.crm.object.schemas/tree/main/examples/README.md#setup-guide) to obtain necessary credentials (client Id, client secret, Refresh tokens).

### 2. Configuration

Create a `Config.toml` file in the example's root directory and, provide your Hubspot account related configurations as follows:

```toml
clientId = "<Client ID>"
clientSecret = "<Client Secret>"
refreshToken = "<Access Token>"
```

## Run the example

Execute the following command to run the example:

```bash
bal run
```