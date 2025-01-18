// Copyright (c) 2024, WSO2 LLC. (http://www.wso2.com).
//
// WSO2 LLC. licenses this file to you under the Apache License,
// Version 2.0 (the "License"); you may not use this file except
// in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing,
// software distributed under the License is distributed on an
// "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
// KIND, either express or implied.  See the License for the
// specific language governing permissions and limitations
// under the License.

import ballerina/http;
import ballerina/io;
import ballerina/oauth2;
import ballerinax/hubspot.crm.obj.schemas as schemas;

// Configurable variables for OAuth2 authentication to connect with the HubSpot API
configurable string clientId = ?;
configurable string clientSecret = ?;
configurable string refreshToken = ?;
const string objId = "test123";

// Entry point of the program
public function main() returns error? {

    // OAuth2 configuration for authentication with HubSpot API using the refresh token
    schemas:OAuth2RefreshTokenGrantConfig authConfig = {
        clientId: clientId,
        clientSecret: clientSecret,
        refreshToken: refreshToken,
        credentialBearer: oauth2:POST_BODY_BEARER
    };

    // HTTP client configuration for communicating with HubSpot API
    schemas:ConnectionConfig clientConfig = {
        auth: authConfig
    };

    // Initializing the HubSpot CRM Client with the configuration
    final schemas:Client hubSpotClient = check new schemas:Client(clientConfig);

    schemas:ObjectSchema productSearchResponse = check hubSpotClient->/[objId].get();

    // Define the schema for "Product" with its properties and labels
    schemas:ObjectTypeDefinitionPatch productSchemaPayload = {
        name: "product",
        labels: {
            singular: "Product",
            plural: "Products"
        },
        primaryDisplayProperty: "product_name",
        requiredProperties: ["product_name", "product_id"],
        properties: [
            {"name": "product_id", "label": "Product ID", "type": "string", "fieldType": "text"},
            {"name": "product_name", "label": "Product Name", "type": "string", "fieldType": "text"},
            {"name": "price", "label": "Price", "type": "number", "fieldType": "number"},
            {"name": "availability", "label": "Availability", "type": "bool", "fieldType": "checkbox"}
        ],
        associatedObjects: []
    };

    // Creating the "Product" schema in HubSpot
    schemas:ObjectTypeDefinition productSchemaResponse = check hubSpotClient->/[objId].patch(productSchemaPayload);
    io:print(productSchemaResponse.name );

}
