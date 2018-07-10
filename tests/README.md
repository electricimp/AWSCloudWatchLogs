# Test Instructions

Testing requires AWS access keys. For instructions on how to create keys, please see the [Read Me file included in the example folder](../example/README.md).

**Note** Once you have added keys to the test code it should be treated carefully and **not checked into version control**.

## Configure The API Keys For CloudWatch Logs ##

At the top of the `.test.nut` files there are three constants which need to be configured:

Parameter | Description
--- | ---
*AWS_CLOUD_WATCH_LOGS_REGION* | AWS region (eg. `"us-west-2"`)
*AWS_CLOUD_WATCH_LOGS_ACCESS_KEY_ID* | IAM Access Key ID
*AWS_CLOUD_WATCH_LOGS_SECRET_ACCESS_KEY* | IAM Secret Access Key

## Imptest ##

Please ensure that the `.impt.test` agent file includes both the AWSRequestV4 and the AWSCloudWatchLogs libraries.
From the `tests` directory, log into your account and then enter `impt test run` into the command line.

## License ##

The AWSCloudWatchLogs library is licensed under the [MIT License](../LICENSE).
