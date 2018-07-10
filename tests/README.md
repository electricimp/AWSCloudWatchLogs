# Test Instructions #

## Configure The API Keys For CloudWatch Logs ##

Testing requires AWS access keys. For instructions on how to create keys, please see the [README file included in the example folder](../example/README.md).

Once keys are created you can store them as environment variables named: *CLOUD_WATCH_LOGS_ACCESS_KEY_ID*, *CLOUD_WATCH_LOGS_SECRET_ACCESS_KEY*, and *CLOUD_WATCH_LOGS_REGION*, or you can copy and paste them into the test code. Please note if you have added keys to the test code it should be treated carefully and **not checked into version control**.

## Imptest ##

Please ensure that the `.impt.test` agent file includes the AWSCloudWatchLogs.agent.lib.nut file and that the test code includes the AWSRequestV4 library.
From the `AWSCloudWatchLogs` directory, log into your account and then enter `impt test run` into the command line.

## License ##

The AWSCloudWatchLogs library is licensed under the [MIT License](../LICENSE).


