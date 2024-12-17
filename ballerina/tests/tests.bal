import ballerina/test;
import ballerina/http;
import ballerina/io;
import ballerina/runtime;
import ballerina/log;

// Global Client instance
Client client = new();
ConnectionConfig config = {httpVersion: "HTTP_1_1", timeout: 60}; // Mock config

// Initialize the client once before all tests
@test:BeforeAll
isolated function beforeAllTests() returns error? {
    error? initResult = client.init(config, "https://api.hubapi.com");
    test:assertTrue(initResult is ());
}

@test:Config {
    groups: ["live_tests", "mock_tests"]
}

isolated function testGetSchemas() returns error? {
    // Mock API response for GET request
    string objectType = "custom_object_type";
    string resourcePath = "/crm-object-schemas/v3/schemas/${objectType}";
    mockListener->get(resourcePath, () => {
        http:Response response = new;
        response.setJsonPayload({ "status": "success", "data": [] });
        return response;
    });

    // Testing the GET request
    var response = client.get("/crm-object-schemas/v3/schemas/" + objectType);
    test:assertTrue(response is http:Response);
    http:Response actualResponse = <http:Response>response;
    json payload = check actualResponse.getJsonPayload();
    test:assertEquals(payload.status.toString(), "success");
}

@test:Config {
    groups: ["live_tests", "mock_tests"]
}

isolated function testCreateSchema() returns error? {
    // Mock API response for POST request
    string resourcePath = "/crm-object-schemas/v3/schemas";
    mockListener->post(resourcePath, () => {
        http:Response response = new;
        response.setJsonPayload({ "status": "created", "id": "12345" });
        return response;
    });

    // Testing POST request for creating schema
    ObjectSchemaEgg payload = new; // Mock payload
    var response = client.post(resourcePath, payload);
    test:assertTrue(response is http:Response);
    http:Response actualResponse = <http:Response>response;
    json payloadResponse = check actualResponse.getJsonPayload();
    test:assertEquals(payloadResponse.status.toString(), "created");
    test:assertEquals(payloadResponse.id.toString(), "12345");
}

@test:Config {
    groups: ["live_tests", "mock_tests"]
}

isolated function testDeleteSchema() returns error? {
    // Mock API response for DELETE request
    string objectType = "custom_object_type";
    string resourcePath = "/crm-object-schemas/v3/schemas/${objectType}";
    mockListener->delete(resourcePath, () => {
        http:Response response = new;
        response.setJsonPayload({ "status": "deleted" });
        return response;
    });

    // Testing DELETE request for schema
    var response = client.delete(resourcePath);
    test:assertTrue(response is http:Response);
    http:Response actualResponse = <http:Response>response;
    json payloadResponse = check actualResponse.getJsonPayload();
    test:assertEquals(payloadResponse.status.toString(), "deleted");
}

@test:Config {
    groups: ["live_tests", "mock_tests"]
}

isolated function testPatchSchema() returns error? {
    // Mock API response for PATCH request
    string objectType = "custom_object_type";
    string resourcePath = "/crm-object-schemas/v3/schemas/${objectType}";
    mockListener->patch(resourcePath, () => {
        http:Response response = new;
        response.setJsonPayload({ "status": "updated" });
        return response;
    });

    // Testing PATCH request for schema update
    ObjectTypeDefinitionPatch payload = new; // Mock payload
    var response = client.patch(resourcePath, payload);
    test:assertTrue(response is http:Response);
    http:Response actualResponse = <http:Response>response;
    json payloadResponse = check actualResponse.getJsonPayload();
    test:assertEquals(payloadResponse.status.toString(), "updated");
}

