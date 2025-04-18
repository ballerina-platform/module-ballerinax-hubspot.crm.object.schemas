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
import ballerina/test;

configurable boolean isLive = false;
configurable string clientId = "testClientId";
configurable string clientSecret = "testClientSecret";
configurable string refreshToken = "testRefreshToken";

string serviceUrl = isLive ? "https://api.hubapi.com/crm-object-schemas/v3/schemas" : "http://127.0.0.1:3000";

OAuth2RefreshTokenGrantConfig auth = {
    clientId,
    clientSecret,
    refreshToken,
    credentialBearer: oauth2:POST_BODY_BEARER,
    refreshUrl: isLive ? "https://api.hubapi.com/oauth/v1/token" : "http://127.0.0.1:3000/token"
};

// Global Client configuration for HTTP communication
ConnectionConfig config = {
    httpVersion: http:HTTP_2_0,
    timeout: 60,
    auth: auth
};

listener http:Listener httpListener = new (3000);

// HubSpot CRM Client for interacting with HubSpot's Object Schemas API
final Client hpClient;

function init() returns error? {
    if isLive {
        io:println("Skipping mock server initialization as the tests are running on live server");

    } else {
        io:println("Initiating mock server");
        check httpListener.attach(mockService, "/");
        check httpListener.'start();
    }

    hpClient = check new Client(config, serviceUrl);
}

@test:Config {
    groups: ["live_tests", "mock_tests"]
}
@test:BeforeGroups
function beforeGroups1() {
    io:println("I'm the before groups function!");
}

// Test: Get Schema - Fetches a list of object schemas
@test:Config {
    groups: ["live_tests", "mock_tests"]
}
isolated function testGetSchemas() returns error? {
    // Make GET request to fetch schemas
    CollectionResponseObjectSchemaNoPaging response = check hpClient->/.get();
    test:assertNotEquals(response.results, ());
}

// Test: Create Schema - Creates a new schema
@test:Config {
    groups: ["live_tests", "mock_tests"]
}
isolated function testCreateSchema() returns error? {
    // Define the payload for creating a new object schema
    ObjectSchemaEgg payload = {
        secondaryDisplayProperties: ["string"],
        requiredProperties: ["my_object_property"],
        searchableProperties: ["string"],
        primaryDisplayProperty: "my_object_property",
        name: "my_object",
        description: "string",
        associatedObjects: ["CONTACT"],
        properties: [],
        labels: {
            plural: "My objects",
            singular: "My object"
        }
    };

    // Make POST request to create the schema
    ObjectSchema response = check hpClient->/.post(payload);
    test:assertNotEquals(response.associations, ());
}

// Test: Delete Schema - Deletes a specific schema by its ID
@test:Config {
    groups: ["live_tests", "mock_tests"]
}
isolated function testDeleteSchema() returns error? {
    // Define the object schema ID to delete
    string objId = "testid";

    // Make DELETE request to delete the schema
    error? response = check hpClient->/[objId].delete();
    test:assertEquals(response, ());
}

// Test: Update Schema - Updates an existing schema by ID
@test:Config {
    groups: ["live_tests", "mock_tests"]
}

isolated function testPatchSchema() returns error? {
    // Define the payload for updating an object schema
    ObjectTypeDefinitionPatch payload = {
        secondaryDisplayProperties: ["string"],
        requiredProperties: ["my_object_property"],
        searchableProperties: ["string"],
        primaryDisplayProperty: "my_object_property",
        description: "string",
        labels: {
            plural: "My objects",
            singular: "My object"
        }
    };

    // Define the object schema ID to patch
    string objId = "testid2";

    // Make PATCH request to update the schema
    ObjectTypeDefinition response = check hpClient->/[objId].patch(payload);
    test:assertNotEquals(response.updatedAt, ());
}

// Test: Create Schema - Creates a new assosiation
@test:Config {
    groups: ["live_tests", "mock_tests"]
}
isolated function testCreateAssosiation() returns error? {

    // Define the object schema ID to patch
    string objId = "testid2";

    // Define the payload for creating a new object schema
    AssociationDefinitionEgg payload = {
        fromObjectTypeId: "2-123456",
        name: "my_object_to_contact",
        toObjectTypeId: "contact"
    };

    // Make POST request to create the schema
    AssociationDefinition response = check hpClient->/[objId]/associations.post(payload);
    test:assertNotEquals(response.id, ());
}

// Test: Delete assosiation - Deletes a specific assosiation by its ID
@test:Config {
    groups: ["live_tests", "mock_tests"]
}
isolated function testDeleteAssosiation() returns error? {
    // Define the object schema ID to delete
    string objId = "testid";
    string assId = "testid";

    // Make DELETE request to delete the schema
    error? response = check hpClient->/[objId]/associations/[assId].delete();
    test:assertEquals(response, ());
}
