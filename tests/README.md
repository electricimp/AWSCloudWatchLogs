# Test Instructions

The instructions will show you how to set up the tests for AWS CloudWatch Logs.

As the sample code includes the private key verbatim in the source, it should be treated carefully, and not checked into version control!

## Configure the API keys for CloudWatch Logs

At the top of the .test.nut files there are three constants that need to be configured.

Parameter                    | Description
---------------------------- | -----------
AWS_CLOUD_WATCH_LOGS_REGION            | AWS region (e.g. "us-west-2")
AWS_CLOUD_WATCH_LOGS_ACCESS_KEY_ID     | IAM Access Key ID
AWS_CLOUD_WATCH_LOGS_SECRET_ACCESS_KEY | IAM Secret Access Key

## Imptest
Please ensure that the `.imptest` agent file includes both AWSRequestV4 library and the AWSCloudWatchLogs class.
From the `tests` directory, run `imptest test`

# License

The AWSCloudWatchLogs library is licensed under the [MIT License](../LICENSE).
