# AWS Cloud Watch Logs Example Instructions

This example shows you how to create a AWS Cloud Watch log group and log stream. The example posts a log event, and then the log group is deleted.

The sample code requires log keys. The instructions below will guide you how to set up the keys. These keys will need to be entered into the example code.

Please ensure your AWS keys have AWS Cloud Watch logs access.

## Setting up AIM Policy

1. Select `Services` link (on the top left of the page) and them type `IAM` in the search line
1. Select `IAM Manage User Access and Encryption Keys` item
1. Select `Policies` item from the menu on the left
1. Press `Create Policy` button
1. Press `Select` for `Policy Generator`
1. On the `Edit Permissions` page do the following
    1. Set `Effect` to `Allow`
    1. Set `AWS Service` to `Amazon CloudWatch Logs`
    1. Set `Actions` to `All Actions`
    1. Leave `Amazon Resource Name (ARN)` blank
    1. Press `Add Statement`
    1. Press `Next Step`
1. Give your policy a name, for example, `allow-CloudWatch-Logs` and type in into the `Policy Name` field
1. Press `Create Policy`

## Setting up the AIM User

1. Select `Services` link (on the top left of the page) and them type `IAM` in the search line
1. Select the `IAM Manage User Access and Encryption Keys` item
1. Select `Users` item from the menu on the left
1. Press `Add user`
1. Choose a user name, for example `user-calling-sns`
1. Check `Programmatic access` but not anything else
1. Press `Next: Permissions` button
1. Press `Attach existing policies directly` icon
1. Check `allow-CloudWatch-Logs` from the list of policies
1. Press `Next: Review`
1. Press `Create user`
1. Copy down your `Access key ID` and `Secret access key`

## Setting up Agent Code

Copy the example agent [code](sample.agent.nut) into your code editor.

In the example code find the configuration parameters, and enter your AWS keys and your AWS region.

Parameter                               | Description
--------------------------------------- | -----------
AWS_CLOUD_WATCH_LOGS_ACCESS_KEY_ID      | IAM Access Key ID
AWS_CLOUD_WATCH_LOGS_SECRET_ACCESS_KEY  | IAM Secret Access Key
AWS_CLOUD_WATCH_LOGS_REGION             | AWS region

Run the example code.

It will create a log group, create a log stream, put a log event in the AWS console, and then delete the log group.
To view the log, comment out the delete section of the code. You will be able to see the logs in the AWS console CloudWatch -> Log Groups. Add the deletion section of the code and run again to remove the log group.
