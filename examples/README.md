# Examples

The `hubspot.crm.object.schemas` connector provides practical examples illustrating usage in various scenarios. Explore these [examples](https://github.com/ballerina-platform/module-ballerinax-hubspot.crm.object.schemas/tree/main/examples), covering real world use cases.

1. [Product and Category schemas](https://github.com/ballerina-platform/module-ballerinax-hubspot.crm.object.schemas/tree/main/examples/product-update) - Integrate hubspot.crm.object.schemas API to create and update a schema for a product.

2. [Book and Author schemas](https://github.com/ballerina-platform/module-ballerinax-hubspot.crm.object.schemas/tree/main/examples/book-author) - Integrate hubspot.crm.object.schemas API to create schema for a book and author association.


## Prerequisites

1. Generate Credentials to authenticate the connector as described in the [Setup Guide](https://github.com/ballerina-platform/module-ballerinax-hubspot.crm.object.schemas/tree/main/README.md).

2. For each example, create a `Config.toml` file the related configuration. Here's an example of how your `Config.toml` file should look:

    ```toml
    clientId = "<Client ID>"
    clientSecret = "<Client Secret>"
    refreshToken = "<Refresh Token>"
    ```

## Running an Example

Execute the following commands to build an example from the source:

* To build an example:

    ```bash
    bal build
    ```

* To run an example:

    ```bash
    bal run
    ```