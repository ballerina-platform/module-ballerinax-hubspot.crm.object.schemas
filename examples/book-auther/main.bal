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
        httpVersion: http:HTTP_2_0,
        timeout: 60,
        auth: authConfig
    };

    // Initializing the HubSpot CRM Client with the configuration
    final schemas:Client hubSpotClient = check new Client(clientConfig);

    // Define the schema for "Author" with its properties and labels
    schemas:ObjectSchemaEgg autherSchemaPayload = {
        name: "auther",
        labels: {
            singular: "Author",
            plural: "Authors"
        },
        primaryDisplayProperty: "auther_name",
        requiredProperties: ["auther_name", "auther_id"],
        properties: [
            {"name": "auther_id", "label": "Author ID", "type": "string", "fieldType": "text"},
            {"name": "auther_name", "label": "Author Name", "type": "string", "fieldType": "text"},
            {"name": "location", "label": "Location", "type": "string", "fieldType": "text"}
        ],
        associatedObjects: []
    };

    // Creating the "Author" schema in HubSpot
    schemas:ObjectSchema autherSchemaResponse = check hubSpotClient->/.post(autherSchemaPayload);

    // Define the schema for "Book" with its properties and labels
    schemas:ObjectSchemaEgg bookSchemaPayload = {
        name: "book",
        labels: {
            singular: "Book",
            plural: "Books"
        },
        primaryDisplayProperty: "book_name",
        requiredProperties: ["book_name", "book_date"],
        properties: [
            {"name": "book_name", "label": "Book Name", "type": "string", "fieldType": "text"},
            {"name": "published_date", "label": "Published Date", "type": "datetime", "fieldType": "date"}
        ],
        associatedObjects: []
    };

    // Creating the "Book" schema in HubSpot
    schemas:ObjectSchema bookSchemaResponse = check hubSpotClient->/.post(bookSchemaPayload);

    // Retrieve the object type IDs for both schemas
    string? bookSchemaId = bookSchemaResponse.objectTypeId;
    string? autherSchemaId = autherSchemaResponse.objectTypeId;

    // Check if the schema creation was successful
    if bookSchemaId is null || autherSchemaId is null {
        return error("Failed to create schemas!");
    }

    // Define the association between "Book" and "Author"
    schemas:AssociationDefinitionEgg payload = {
        "fromObjectTypeId": bookSchemaId,
        "name": "book_to_auther",
        "toObjectTypeId": autherSchemaId
    };

    // Create the association in HubSpot
    schemas:AssociationDefinition response = check hubSpotClient->/book/associations.post(payload);
}

