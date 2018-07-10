# AWS CloudWatch Logs Example #

This example shows you how to create an AWS CloudWatch log group and log stream, post a log event, and delete a log group.

The sample code requires AWS keys. The instructions below will guide you how to set up the keys. These keys will need to be entered into the example code. You will also need to select a region in order to view the logs.

## Log Into AWS ##

1. Log into the [AWS Console](https://aws.amazon.com/console/).
1. On the **Console Home** page, select and make note of your region, eg. US West (N. California) is `us-west-1`.

## Set Up An AIM Policy ##

1. Select the **Services** link (on the top left of the page) and them type `IAM` in the search field.
1. Select **IAM Manage User Access and Encryption Keys**.
1. Select **Policies** from the menu on the left.
1. Click the **Create Policy** button.
1. On the **Create Policy** page do the following:
    1. Click **Service** or **Choose a service**, then locate and select **CloudWatch Logs**.
    1. Click **Actions** under **Manual Actions**, then Check **All CloudWatch Logs Actions** &mdash; this will trigger two warnings.
    1. Click **Resources** and select **All resources**.
    1. Click **Review policy**.
    1. Give your policy a name &dmash; for example, `allow-CloudWatch-Logs`.
    1. Click **Create Policy**.

## Set Up An AIM User ##

1. Select the **Services** link (on the top left of the page) and them type `IAM` in the search field.
1. Select **IAM Manage User Access and Encryption Keys**.
1. Select **Users** from the menu on the left.
1. Click **Add user**.
1. Choose and enter a username &mdash; for example `user-calling-cloudWatchLogs`.
1. Check **Programmatic access** but nothing else.
1. Click **Next: Permissions**.
1. Click the **Attach existing policies directly** icon.
1. Check **allow-CloudWatch-Logs** from the list of policies.
1. Click **Next: Review**.
1. Click **Create user**
1. Copy down your **Access key ID** and **Secret access key**.

## Set Up The Agent Code ##

Copy the example agent [code](sample.agent.nut) into impCentral’s code editor.

In the example code, find the configuration parameters, and enter your AWS keys and your AWS region.

Parameter | Description
--- | ---
*AWS_CLOUD_WATCH_LOGS_ACCESS_KEY_ID* | IAM Access Key ID
*AWS_CLOUD_WATCH_LOGS_SECRET_ACCESS_KEY* | IAM Secret Access Key
*AWS_CLOUD_WATCH_LOGS_REGION* | AWS region

After entering your credentials, run the example code. The example code will create a log group, create a log stream, and put a log event in the AWS console. If the log group exists, the example will delete the group then create the log group, stream and event again.

## View Logs In The AWS Console ##

To view logs in AWS:

1. Select the **Services** link (on the top left of the page) and them type `CloudWatch` in the search field.
1. Select the **CloudWatch** item.
1. Make sure your region is the same one that you entered in the code.
1. Select **Logs** from the sidebar.

If you have run the code you will see `testLogGroup` and you can click on it to see `testLogStream`. If you click on `testLogStream`, you can see the log event.
