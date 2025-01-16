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
import ballerina/log;

listener http:Listener httpListener = new (3000);

http:Service mockService = service object {

    resource function post token() returns json {
        return {
            "access_token": "newAccessToken123456789",
            "expires_in": 3600,
            "refresh_token": "newRefreshToken987654321",
            "token_type": "Bearer"
        };
    }

    resource function get .() returns json {
        return {
            "results": [
                {
                    "associations": [
                        {
                            "createdAt": "2025-01-10T06:20:44.626Z",
                            "fromObjectTypeId": "2-123456",
                            "name": "my_object_to_contact",
                            "id": "105",
                            "toObjectTypeId": "0-1",
                            "updatedAt": "2025-01-10T06:20:44.627Z"
                        }
                    ],
                    "secondaryDisplayProperties": ["string"],
                    "createdByUserId": 0,
                    "objectTypeId": "string",
                    "description": "string",
                    "updatedByUserId": 0,
                    "fullyQualifiedName": "p7878787_my_object",
                    "labels": {
                        "plural": "My objects",
                        "singular": "My object"
                    },
                    "archived": true,
                    "createdAt": "2025-01-10T06:20:44.627Z",
                    "requiredProperties": ["my_object_property"],
                    "searchableProperties": ["my_object_property"],
                    "primaryDisplayProperty": "my_object_property",
                    "name": "my_object",
                    "id": "123456",
                    "properties": [
                        {
                            "hidden": true,
                            "displayOrder": 2,
                            "description": "string",
                            "showCurrencySymbol": true,
                            "type": "enumeration",
                            "hubspotDefined": true,
                            "createdAt": "2025-01-10T06:20:44.627Z",
                            "archived": true,
                            "options": [
                                {
                                    "hidden": false,
                                    "displayOrder": 1,
                                    "description": "Choice number one",
                                    "label": "Option A",
                                    "value": "A"
                                }
                            ],
                            "hasUniqueValue": false,
                            "calculated": true,
                            "externalOptions": true,
                            "updatedAt": "2025-01-10T06:20:44.627Z",
                            "createdUserId": "string",
                            "modificationMetadata": {
                                "readOnlyOptions": true,
                                "readOnlyValue": true,
                                "readOnlyDefinition": true,
                                "archivable": true
                            },
                            "sensitiveDataCategories": ["string"],
                            "label": "My object property",
                            "formField": true,
                            "dataSensitivity": "non_sensitive",
                            "archivedAt": "2025-01-10T06:20:44.627Z",
                            "groupName": "my_object_information",
                            "referencedObjectType": "string",
                            "name": "my_object_property",
                            "calculationFormula": "string",
                            "fieldType": "select",
                            "updatedUserId": "string"
                        }
                    ],
                    "updatedAt": "2025-01-10T06:20:44.627Z"
                }
            ]
        };
    }

    resource function get [string testId]() returns json {
        return {
            "associations": [
                {
                    "createdAt": "2025-01-10T06:20:44.631Z",
                    "fromObjectTypeId": "2-123456",
                    "name": "my_object_to_contact",
                    "id": "105",
                    "toObjectTypeId": "0-1",
                    "updatedAt": "2025-01-10T06:20:44.631Z"
                }
            ],
            "secondaryDisplayProperties": ["string"],
            "createdByUserId": 0,
            "objectTypeId": "string",
            "description": "string",
            "updatedByUserId": 0,
            "fullyQualifiedName": "p7878787_my_object",
            "labels": {
                "plural": "My objects",
                "singular": "My object"
            },
            "archived": true,
            "createdAt": "2025-01-10T06:20:44.631Z",
            "requiredProperties": ["my_object_property"],
            "searchableProperties": ["my_object_property"],
            "primaryDisplayProperty": "my_object_property",
            "name": "my_object",
            "id": "123456",
            "properties": [
                {
                    "hidden": true,
                    "displayOrder": 2,
                    "description": "string",
                    "showCurrencySymbol": true,
                    "type": "enumeration",
                    "hubspotDefined": true,
                    "createdAt": "2025-01-10T06:20:44.631Z",
                    "archived": true,
                    "options": [
                        {
                            "hidden": false,
                            "displayOrder": 1,
                            "description": "Choice number one",
                            "label": "Option A",
                            "value": "A"
                        }
                    ],
                    "hasUniqueValue": false,
                    "calculated": true,
                    "externalOptions": true,
                    "updatedAt": "2025-01-10T06:20:44.631Z",
                    "createdUserId": "string",
                    "modificationMetadata": {
                        "readOnlyOptions": true,
                        "readOnlyValue": true,
                        "readOnlyDefinition": true,
                        "archivable": true
                    },
                    "sensitiveDataCategories": ["string"],
                    "label": "My object property",
                    "formField": true,
                    "dataSensitivity": "non_sensitive",
                    "archivedAt": "2025-01-10T06:20:44.631Z",
                    "groupName": "my_object_information",
                    "referencedObjectType": "string",
                    "name": "my_object_property",
                    "calculationFormula": "string",
                    "fieldType": "select",
                    "updatedUserId": "string"
                }
            ],
            "updatedAt": "2025-01-10T06:20:44.631Z"
        };
    }

    resource function post .() returns json {
        return {
            "associations": [
                {
                    "createdAt": "2025-01-10T06:20:44.635Z",
                    "fromObjectTypeId": "2-123456",
                    "name": "my_object_to_contact",
                    "id": "105",
                    "toObjectTypeId": "0-1",
                    "updatedAt": "2025-01-10T06:20:44.635Z"
                }
            ],
            "secondaryDisplayProperties": [
                "string"
            ],
            "createdByUserId": 0,
            "objectTypeId": "string",
            "description": "string",
            "updatedByUserId": 0,
            "fullyQualifiedName": "p7878787_my_object\"",
            "labels": {
                "plural": "My objects",
                "singular": "My object"
            },
            "archived": true,
            "createdAt": "2025-01-10T06:20:44.635Z",
            "requiredProperties": [
                "my_object_property"
            ],
            "searchableProperties": [
                "my_object_property"
            ],
            "primaryDisplayProperty": "my_object_property",
            "name": "my_object",
            "id": "123456",
            "properties": [
                {
                    "hidden": true,
                    "displayOrder": 2,
                    "description": "string",
                    "showCurrencySymbol": true,
                    "type": "enumeration",
                    "hubspotDefined": true,
                    "createdAt": "2025-01-10T06:20:44.635Z",
                    "archived": true,
                    "options": [
                        {
                            "hidden": false,
                            "displayOrder": 1,
                            "description": "Choice number one",
                            "label": "Option A",
                            "value": "A"
                        }
                    ],
                    "hasUniqueValue": false,
                    "calculated": true,
                    "externalOptions": true,
                    "updatedAt": "2025-01-10T06:20:44.635Z",
                    "createdUserId": "string",
                    "modificationMetadata": {
                        "readOnlyOptions": true,
                        "readOnlyValue": true,
                        "readOnlyDefinition": true,
                        "archivable": true
                    },
                    "sensitiveDataCategories": [
                        "string"
                    ],
                    "label": "My object property",
                    "formField": true,
                    "dataSensitivity": "non_sensitive",
                    "archivedAt": "2025-01-10T06:20:44.635Z",
                    "groupName": "my_object_information",
                    "referencedObjectType": "string",
                    "name": "my_object_property",
                    "calculationFormula": "string",
                    "fieldType": "select",
                    "updatedUserId": "string"
                }
            ],
            "updatedAt": "2025-01-10T06:20:44.635Z"
        };
    }

    resource function delete [string objId]() returns http:NoContent {
        return http:NO_CONTENT;
    }

    resource function patch [string objId]() returns json {
        return {
            "secondaryDisplayProperties": [
                "string"
            ],
            "objectTypeId": "string",
            "description": "string",
            "fullyQualifiedName": "string",
            "labels": {
                "plural": "My objects",
                "singular": "My object"
            },
            "archived": true,
            "createdAt": "2025-01-10T06:20:44.641Z",
            "requiredProperties": [
                "my_object_property"
            ],
            "searchableProperties": [
                "my_object_property"
            ],
            "portalId": 12345678,
            "primaryDisplayProperty": "my_object_property",
            "name": "my_object",
            "id": "123456",
            "updatedAt": "2025-01-10T06:20:44.641Z"
        };
    }

    resource function post [string objId]/associations() returns json {
        return {
            "createdAt": "2025-01-10T06:20:44.638Z",
            "fromObjectTypeId": "2-123456",
            "name": "my_object_to_contact",
            "id": "105",
            "toObjectTypeId": "0-1",
            "updatedAt": "2025-01-10T06:20:44.638Z"
        };
    }

    resource function delete [string objId]/associations/[string assId]() returns http:NoContent {
        return http:NO_CONTENT;
    }

};

function init() returns error? {
    // if isLiveServer {
    //     log:printInfo("Skiping mock server initialization as the tests are running on live server");
    //     return;
    // }
    io:("Initiating mock server");
    check httpListener.attach(mockService, "/");
    check httpListener.'start();
}
