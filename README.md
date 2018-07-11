# AWSCloudWatchLogs #

You can use [AWS CloudWatch Logs](https://docs.aws.amazon.com/AmazonCloudWatchLogs/latest/APIReference/Welcome.html) to monitor and store your log files from Amazon Elastic Compute Cloud (EC2) instances, AWS CloudTrail, and other sources. You can then retrieve the associated log data from CloudWatch Logs. This class can be used to perform CloudWatch log actions via an Electric Imp.

**Note** The AWSCloudWatchLogs library uses [AWSRequestV4](https://github.com/electricimp/AWSRequestV4/) for all requests. Therefor the AWSRequestV4 library must also be included in your agent code.

**To add this library copy and paste the following lines to the top of your agent code:**

```squirrel
#require "AWSRequestV4.class.nut:1.0.2"
#require "AWSCloudWatchLogs.lib.nut:1.0.0"
```

## Class Usage ##

### Constructor: AWSCloudWatchLogs(*region, accessKeyId, secretAccessKe*) ###

#### Parameters ####

| Parameter | Type | Required | Description |
| --- | --- | --- | --- |
| *region* | String | Yes | AWS region |
| *accessKeyId* | String | Yes | AWS access key ID |
| *secretAccessKey* | String | Yes | AWS secret access key |

#### Example ####

```squirrel
#require "AWSRequestV4.class.nut:1.0.2"
#require "AWSCloudWatchLogs.lib.nut:1.0.0"

const AWS_CLOUDWATCH_LOGS_ACCESS_KEY_ID = "YOUR_KEY_ID";
const AWS_CLOUDWATCH_LOGS_SECRET_ACCESS_KEY = "YOUR_KEY";
const AWS_CLOUDWATCH_LOGS_REGION = "YOUR_REGION";

logs <- AWSCloudWatchLogs(AWS_CLOUDWATCH_LOGS_REGION, AWS_CLOUDWATCH_LOGS_ACCESS_KEY_ID, AWS_CLOUDWATCH_LOGS_SECRET_ACCESS_KEY);
```

## Class Methods ##

### action(*actionType, actionParams, callback*) ###

This method performs a specified action (eg. create a log group) with any required parameters (*actionParams*) for the specified [action type](#action-types).

#### Parameters ####

| Parameter | Type | Description |
| --- | --- | --- |
| *actionType* | Constant | The type of the CloudWatch logging action that you wish to perform (see [‘Action Types’](action-types), below) |
| *actionParams* | Table | A table of action-specific parameters |
| *callback* | Function | A callback function that takes one parameter: a [Callback Response Table](#callback-response-table) |

#### Callback Response Table ####

The response table general to all functions. If an error was encountered while encoding the parameters the response table will contain only the *error* key, otherwise the response table will contain the *body*, *statuscode* and *headers* keys.

| Key | Type | Description |
| --- | --- | --- |
| *error* | String | A string describing the error encountered |
| *body* | String | The JSON-encoded CloudWatch response in a function-specific structure |
| *statuscode* | Integer | The HTTP status code |
| *headers* | Table | See [‘Headers’](#headers), below |

#### Headers ####

The *headers* table, contains the following keys:

| Key | Type | Description |
| --- | --- | --- |
| *x-amzn-requestid* | String | The AWS request ID |
| *connection* | String | The connection status |
| *date* | String | The date and time at which the response was sent |
| *content-length* | String | The length of the content in bytes |

#### Action Types ####

| Action Type | Description |
| --- | --- |
| [*AWS_CLOUDWATCH_LOGS_ACTION_CREATE_LOG_GROUP*](#aws_cloudwatch_logs_action_create_log_group) | Creates a log group with the specified name |
| [*AWS_CLOUDWATCH_LOGS_ACTION_CREATE_LOG_STREAM*](#aws_cloudwatch_logs_action_create_log_stream) | Creates a log stream for the specified log group |
| [*AWS_CLOUDWATCH_LOGS_ACTION_DELETE_LOG_GROUP*](#aws_cloudwatch_logs_action_delete_log_group) | Deletes a log group with the specified name |
| [*AWS_CLOUDWATCH_LOGS_ACTION_DELETE_LOG_STREAM*](#aws_cloudwatch_logs_action_delete_log_stream) | Deletes the specified log stream and all the archived log events associated with it |
| [*AWS_CLOUDWATCH_LOGS_ACTION_PUT_LOG_EVENTS*](#aws_cloudwatch_logs_action_put_log_events) | Uploads a batch of log events to a specified log stream |

Specific actions of the types listed above are configured by passing information into *action()*’s *actionParams* parameter as a table with action type-specific keys.

### AWS_CLOUDWATCH_LOGS_ACTION_CREATE_LOG_GROUP ###

This action creates a log group with the specified name. For more details please see the [AWS documentation](http://docs.aws.amazon.com/AmazonCloudWatchLogs/latest/APIReference/API_CreateLogGroup.html).

#### Action Parameters ####

| Parameter | Type | Required | Description |
| --- | --- | --- | --- |
| *logGroupName* | String | Yes | The name of the log group you are creating |
| *tags* | Table | No | The key-value pairs to use for the tags. Default: `null` |

#### Example ####

```squirrel
const HTTP_RESPONSE_SUCCESS = 200;
local groupParams = { "logGroupName": "testLogGroup",
                      "tags": { "Environment": "test" } };

logs.action(AWS_CLOUDWATCH_LOGS_ACTION_CREATE_LOG_GROUP, groupParams, function(response) {
    if ("error" in response) {
        server.error(response.error);
        return;
    }

    if (response.statuscode == HTTP_RESPONSE_SUCCESS) {
        server.log("Created a log group successfully");
    } else {
        server.log("Failed to create log group. error: " + http.jsondecode(response.body).message);
    }
});
```

### AWS_CLOUDWATCH_LOGS_ACTION_CREATE_LOG_STREAM ###

This action creates a log stream for the specified log group. For more details please see the [AWS documentation](http://docs.aws.amazon.com/AmazonCloudWatchLogs/latest/APIReference/API_CreateLogStream.html).

#### Action Parameters ####

| Parameter | Type | Required | Description |
| --- | --- | --- | --- |
| *logGroupName* | String | Yes | The name of the existing log group |
| *logStreamName* | String | Yes | The name of the log stream you are creating |

#### Example ####

```squirrel
local params = { "logGroupName": "testLogGroup",
                 "logStreamName": "testLogStream" };

logs.action(AWS_CLOUDWATCH_LOGS_ACTION_CREATE_LOG_STREAM, params, function(response) {
    if ("error" in response) {
        server.error(response.error);
        return;
    }

    if (response.statuscode == HTTP_RESPONSE_SUCCESS) {
        server.log("Created a log stream successfully");
    } else {
        server.log("Failed to create log stream. error: " + http.jsondecode(response.body).message);
    }
});
```

### AWS_CLOUDWATCH_LOGS_ACTION_DELETE_LOG_GROUP ###

This action deletes a log group with the specified name. For more details please see the [AWS documentation](http://docs.aws.amazon.com/AmazonCloudWatchLogs/latest/APIReference/API_DeleteLogGroup.html).

#### Action Parameters ####

| Parameter | Type | Required | Description |
| --- | --- | --- | --- |
| *logGroupName* | String | Yes | The name of the log group you want to delete |

#### Example ####

```squirrel
local deleteParams = { "logGroupName": "testLogGroup" };

logs.action(AWS_CLOUDWATCH_LOGS_ACTION_DELETE_LOG_GROUP, deleteParams, function(response) {
    if ("error" in response) {
        server.error(response.error);
        return;
    }

    if (response.statuscode == HTTP_RESPONSE_SUCCESS) {
        server.log("Deleted log group successfully");
    } else {
        server.log("Failed to delete log group. error: " + http.jsondecode(response.body).message);
    }
});
```

### AWS_CLOUDWATCH_LOGS_ACTION_DELETE_LOG_STREAM ###

This action deletes the specified log stream and permanently deletes all of the archived log events that have been associated with the log stream. For more details please see the [AWS documentation](http://docs.aws.amazon.com/AmazonCloudWatchLogs/latest/APIReference/API_DeleteLogStream.html).

#### Action Parameters ####

| Parameter | Type | Required | Description |
| --- | --- | --- | --- |
| *logGroupName* | String | Yes | The name of the log group |
| *logStreamName* | String | Yes | The name of the log stream you are deleting from the log group |

#### Example ####

```squirrel
local params = { "logGroupName": "testLogGroup",
                 "logStreamName": "testLogStream" };

logs.action(AWS_CLOUDWATCH_LOGS_ACTION_DELETE_LOG_STREAM, deleteParams, function(response) {
    if ("error" in response) {
        server.error(response.error);
        return;
    }

    if (response.statuscode == HTTP_RESPONSE_SUCCESS) {
        server.log("Deleted log stream successfully");
    } else {
        server.log("Failed to delete log stream. error: " + http.jsondecode(response.body).message);
    }
});
```

### AWS_CLOUDWATCH_LOGS_ACTION_PUT_LOG_EVENTS ###

This action uploads a batch of log events to the specified log stream. For more details please see the [AWS documentation](http://docs.aws.amazon.com/AmazonCloudWatchLogs/latest/APIReference/API_PutLogEvents.html).

#### Action Parameters ####

| Parameter | Type | Required | Description |
| --- | --- | --- | --- |
| *logEvents* | Array of tables | Yes | An array of log event tables. Each event table must contain the keys *message* and *timestamp*. The values of both keys must be strings. The value of *message* is the log message. The value of *timestamp* should be formatted as milliseconds since the Unix Epoch (milliseconds counted since Jan 1, 1970 00:00:00 UTC) |
| *logGroupName* | String | Yes | The name of the log group |
| *logStreamName* | String | Yes | The name of the log stream |
| *sequenceToken* | String | No |  The sequence token. Default: `null` |

#### Example ####

```squirrel
local now = date();
local ms = format("%06d", now.usec).slice(0,3);
local ts = format("%d%s", time(), ms);

local putLogParams = { "logGroupName": "testLogGroup",
                       "logStreamName": "testLogStream",
                       "logEvents": [{ "message": "log",
                                       "timestamp": ts }] };

logs.action(AWS_CLOUDWATCH_LOGS_ACTION_PUT_LOG_EVENTS, putLogParams, function(response) {
    if ("error" in response) {
        server.error(response.error);
        return;
    }

    if (response.statuscode == HTTP_RESPONSE_SUCCESS) {
        server.log("successfully put a log in a stream");
    } else {
        server.log("failed to put a log in a stream");
    }
});
```

## License ##

The AWSCloudWatchLogs library is licensed under the [MIT License](LICENSE).
