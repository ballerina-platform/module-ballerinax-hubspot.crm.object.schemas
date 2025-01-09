import ballerina/http;
import ballerina/io;

// import ballerina/log;

const string CLIENT_ID = "bf7aa889-a677-4a76-93a6-c6b9fc896ff3";
const string CLIENT_SECRET = "5b1ce2fe-0634-4055-ab9c-3bffe7efa00c";
const string REDIRECT_URI = "http://localhost:9090/callback";
const string SCOPE = "crm.objects.custom.read%20crm.objects.custom.write%20oauth";
const string TOKEN_URL = "https://api.hubapi.com/oauth/v1/token";


string? accessToken = null;

// Define OAuth2Config record to hold details
type OAuth2Config record {
    string clientId;
    string clientSecret;
    string redirectUri;
    string code;
};

// HTTP service to catch the OAuth code
service / on new http:Listener(9090) {

    resource function get init () returns http:TemporaryRedirect {
        string authUrl = string `https://app.hubspot.com/oauth/authorize?client_id=${CLIENT_ID}&scope=${SCOPE}&redirect_uri=${REDIRECT_URI}`;

        return {
            headers: {
                "Location": authUrl
            }
        };
    }


    resource function get callback (http:Caller caller, http:Request req) returns error? {
        // Extract the "code" query parameter from the URL
        string? code = req.getQueryParamValue("code");

        if code is string {
            // Log the received code
            io:println("Authorization code is received: " + code);

            // Exchange the authorization code for an access token
            OAuth2Config oauth2Config = {
                clientId: CLIENT_ID,
                clientSecret: CLIENT_SECRET,
                redirectUri: REDIRECT_URI,
                code: code
            };

            // Get the access token by exchanging the authorization code
            accessToken = check getAccessToken(oauth2Config);

            // Respond with the access token or any other message
            check caller->respond("Access granted successfully.");
        } else {
            // Respond with an error message if no code is found
            check caller->respond("Authorization code not is found.");
        }
    }


    resource function get test/token (http:Caller caller, http:Request req) returns error? {

            if(accessToken is string) {
                check caller->respond(accessToken);
            }else{
                check caller->respond("Authentication is not completed");
            }

    }
}

// Function to get the access token by exchanging the authorization code
function getAccessToken(OAuth2Config oauth2Config) returns string|error {
    http:Client tokenClient = check new (TOKEN_URL);

    // Prepare the payload for the token exchange request
    string payload = "grant_type=authorization_code" + "&client_id=" + oauth2Config.clientId + "&client_secret=" + oauth2Config.clientSecret + "&redirect_uri=" + oauth2Config.redirectUri + "&code=" + oauth2Config.code;

    // Send the token request
    json|error response = tokenClient->post("", payload, {
        "Content-Type": "application/x-www-form-urlencoded"
    });


    if response is error {
        return error("Cannot recive the code");
    }

    json|error access_token = response.access_token;

    if access_token is string {
        return access_token;

    } else {
        return error("Failed to get access token");
    }
}

public function main() returns error? {

    io:println("Server is listening on port : 9090");
}
