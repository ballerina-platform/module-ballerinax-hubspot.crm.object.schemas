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

import ballerina/oauth2;
import ballerinax/hubspot.crm.obj.schemas as schemas;
import ballerina/io;

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
        auth: authConfig
    };

    // Initializing the HubSpot CRM Client with the configuration
    final schemas:Client hubSpotClient = check new schemas:Client(clientConfig);

    // Define the schema for "Author" with its properties and labels
    schemas:ObjectSchemaEgg authorSchemaPayload = {
        name: "author",
        labels: {
            singular: "Author",
            plural: "Authors"
        },
        primaryDisplayProperty: "author_name",
        requiredProperties: ["author_name", "author_id"],
        properties: [
            {name: "author_id", label: "Author ID", "type": "string", fieldType: "text"},
            {name: "author_name", label: "Author Name", "type": "string", fieldType: "text"},
            {name: "location", label: "Location", "type": "string", fieldType: "text"}
        ],
        associatedObjects: []
    };

    // Creating the "Author" schema in HubSpot
    schemas:ObjectSchema authorSchemaResponse = check hubSpotClient->/.post(authorSchemaPayload);

    // Define the schema for "Book" with its properties and labels
    schemas:ObjectSchemaEgg bookSchemaPayload = {
        name: "book",
        labels: {
            singular: "Book",
            plural: "Books"
        },
        primaryDisplayProperty: "book_name",
        requiredProperties: ["book_name", "published_date"],
        properties: [
            {name: "book_name", label: "Book Name", "type": "string", fieldType: "text"},
            {name: "published_date", label: "Published Date", 'type: "datetime", fieldType: "date"}
        ],
        associatedObjects: []
    };

    // Creating the "Book" schema in HubSpot
    schemas:ObjectSchema bookSchemaResponse = check hubSpotClient->/.post(bookSchemaPayload);

    // Retrieve the object type IDs for both schemas
    string? bookSchemaId = bookSchemaResponse.objectTypeId;
    string? authorSchemaId = authorSchemaResponse.objectTypeId;

    // Check if the schema creation was successful
    if bookSchemaId is () || authorSchemaId is () {
        return error("Failed to create schemas!");
    }

    // Define the association between "Book" and "Author"
    schemas:AssociationDefinitionEgg payload = {
        fromObjectTypeId: bookSchemaId,
        name: "book_to_author",
        toObjectTypeId: authorSchemaId
    };

    // Create the association in HubSpot
    schemas:AssociationDefinition response = check hubSpotClient->/book/associations.post(payload);
    io:print(response.name );
}