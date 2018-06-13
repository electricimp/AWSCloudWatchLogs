# AWS Cloud Watch Logs Example Instructions

This example shows you how to create a AWS Cloud Watch log group and log stream, post a log event, and delete a log group.

The sample code requires AWS keys. The instructions below will guide you how to set up the keys. These keys will need to be entered into the example code. You will also need to select a region in order to view the logs.

## Log into AWS

1. Log into [AWS Console](https://aws.amazon.com/console/)
1. On the Console Home select and make note of your region, ie US West (N. California) is `us-west-1`.

## Setting up AIM Policy

1. Select `Services` link (on the top left of the page) and them type `IAM` in the search line
1. Select `IAM Manage User Access and Encryption Keys` item
1. Select `Policies` item from the menu on the left
1. Press `Create Policy` button
1. On the `Create Policy` page do the following
    1. Click `Service` or `Choose a service` locate and select `CloudWatch Logs`
    1. Click `Actions` under `Manual Actions` Check `All CloudWatch Logs Actions` (this will create 2 warnings)
    1. Click `Resources` and select `All resources`
    1. Press `Review policy`
    1. Give your policy a name, for example, `allow-CloudWatch-Logs`
    1. Press `Create Policy`

## Setting up the AIM User

1. Select `Services` link (on the top left of the page) and them type `IAM` in the search line
1. Select the `IAM Manage User Access and Encryption Keys` item
1. Select `Users` item from the menu on the left
1. Press `Add user`
1. Choose a user name, for example `user-calling-cloudWatchLogs`
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

After entering your credentials, run the example code.
The example code will create a log group, create a log stream, put a log event in the AWS console. If the log group exists the example will delete the group then create log group, stream and event again.

## View Logs in AWS Console

To view logs in AWS

1. Select `Services` link (on the top left of the page) and them type `CloudWatch` in the search line
1. Select the `CloudWatch` item
1. Make sure your region is the same one that you entered in the code
1. Select `Logs` from the sidebar

If you have run the code you will see `testLogGroup`, you can click on it to see `testLogStream`, and if you click on `testLogStream` you can see the log event.
