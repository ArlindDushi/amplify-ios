#  AWSCognitoAuthPlugin Integration tests

The following steps demonstrate how to setup the integration tests for auth plugin. 

## CLI setup

The integration test require auth configured with AWS Cognito User Pool and AWS Cognito Identity Pool. 

```
amplify add auth

 Do you want to use the default authentication and security configuration? 
    Manual configuration
 Select the authentication/authorization services that you want to use: 
    User Sign-Up, Sign-In, connected with AWS IAM controls (Enables ...)
 Please provide a friendly name for your resource that will be used to label this category in the project: 
    <amplifyintegtest>
 Please enter a name for your identity pool. 
    <amplifyintegtestCIDP>
 Allow unauthenticated logins? (Provides scoped down permissions that you can control via AWS IAM) 
    Yes
 Do you want to enable 3rd party authentication providers in your identity pool? 
    No
 Please provide a name for your user pool: 
    <amplifyintegCUP>

 How do you want users to be able to sign in? 
    Username
 Do you want to add User Pool Groups? 
    No
 Do you want to add an admin queries API? 
    Yes
? Do you want to restrict access to the admin queries API to a specific Group 
    No
 Multifactor authentication (MFA) user login options: 
    OFF
 
 Email based user registration/forgot password: 
    Enabled (Requires per-user email entry at registration)
 Please specify an email verification subject: 
    Your verification code
 Please specify an email verification message: 
    Your verification code is {####}
 Do you want to override the default password policy for this User Pool? 
    No
 
 What attributes are required for signing up? 
    NA
 Specify the app's refresh token expiration period (in days): 
    30
 Do you want to specify the user attributes this app can read and write? 
    No
 Do you want to enable any of the following capabilities?
    NA
 Do you want to use an OAuth flow? 
    No
? Do you want to configure Lambda Triggers for Cognito? 
    Yes
? Which triggers do you want to enable for Cognito 
    Pre Sign-up
? What functionality do you want to use for Pre Sign-up 
    Create your own module
Succesfully added the Lambda function locally
? Do you want to edit your custom function now? Yes
Please edit the file in your editor: 

"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.handler = async (event) => {
    event.response.autoConfirmUser = true;
    return event;
};

? Press enter to continue
Successfully added resource amplifyintegtest locally

amplify push
```
This will create a amplifyconfiguration.json file in your local, drag that into the folder path AWSCognitoAuthPluginIntegrationTests/Configuration and give `AWSCognitoAuthPluginIntegrationTests` as the target.
