# AWSCloudWatchLogs

You can use [Amazon CloudWatch Logs](https://docs.aws.amazon.com/AmazonCloudWatchLogs/latest/APIReference/Welcome.html) to monitor, store, and access your log files from Amazon Elastic Compute Cloud (Amazon EC2) instances, AWS CloudTrail, and other sources. You can then retrieve the associated log data from CloudWatch Logs. This class can be used to perform Cloud Watch log actions via an Electric Imp.

**Note: The AWSCloudWatchLogs library uses [AWSRequestV4](https://github.com/electricimp/AWSRequestV4/) for all requests. Therefor the AWSRequestV4 must also be included in your agent code.**

**To add this library copy and paste the following lines to the top of your agent code:**

```
#require "AWSRequestV4.class.nut:1.0.2"
#require "AWSCloudWatchLogs.lib.nut:1.0.0"
```

## Class Usage

### constructor(region, accessKeyId, secretAccessKey)
All parameters are strings. Access keys can be generated with IAM.

Parameter              | Type           | Description
---------------------- | -------------- | -----------
**region**             | String         | AWS region
**accessKeyId**        | String         | AWS access key id
**secretAccessKey**    | String         | AWS secret access key id

### Example

```squirrel
#require "AWSRequestV4.class.nut:1.0.2"
#require "AWSCloudWatchLogs.lib.nut:1.0.0"

const AWS_CLOUDWATCH_LOGS_ACCESS_KEY_ID = "YOUR_KEY_ID_HERE";
const AWS_CLOUDWATCH_LOGS_SECRET_ACCESS_KEY = "YOUR_KEY_HERE";
const AWS_CLOUDWATCH_LOGS_REGION = "YOUR_REGION_HERE";

logs <- AWSCloudWatchLogs(AWS_CLOUDWATCH_LOGS_REGION, AWS_CLOUDWATCH_LOGS_ACCESS_KEY_ID, AWS_CLOUDWATCH_LOGS_SECRET_ACCESS_KEY);
```

## Class Methods

### action(actionType, actionParams, callback)

This method performs a specified action (eg. create log group) with the required parameters (actionParams) for the specified action type.

| Parameter      | Type     | Description |
| -------------- | -------- | ----------- |
| *actionType*   | Constant | The type of the Amazon CloudWatch Logs action that you want to perform (see ‘Action Types’, below) |
| *actionParams* | Table    | Table of action-specific parameters (see ‘Action Parameters’, below) |
| *callback*     | Function | Callback function that takes one parameter: a [Callback Response Table](#callback-response-table) |

#### Action Types

| Action Type                                                                                     | Description                                       |
| ----------------------------------------------------------------------------------------------- | ------------------------------------------------- |
| [*AWS_CLOUDWATCH_LOGS_ACTION_CREATE_LOG_GROUP*](#aws_cloudwatch_logs_action_create_log_group)   | Creates a log group with the specified name.      |
| [*AWS_CLOUDWATCH_LOGS_ACTION_CREATE_LOG_STREAM*](#aws_cloudwatch_logs_action_create_log_stream) | Creates a log stream for the specified log group. |
| [*AWS_CLOUDWATCH_LOGS_ACTION_DELETE_LOG_GROUP*](#aws_cloudwatch_logs_action_delete_log_group)   | Deletes a log group with the specified name.      |
| [*AWS_CLOUDWATCH_LOGS_ACTION_DELETE_LOG_STREAM*](#aws_cloudwatch_logs_action_delete_log_stream) | Deletes the specified log stream and permanently deletes all the archived log events associated with the log stream. |
| [*AWS_CLOUDWATCH_LOGS_ACTION_PUT_LOG_EVENTS*](#aws_cloudwatch_logs_action_put_log_events)       | Uploads a batch of log events to the specified log stream. |

#### Action Parameters

Specific actions of the types listed above are configured by passing information into *action()*’s *actionParams* parameter a

#### AWS_CLOUDWATCH_LOGS_ACTION_CREATE_LOG_GROUP

Creates a log group with the specified name. For more detail please see: [AWS Docs](http://docs.aws.amazon.com/AmazonCloudWatchLogs/latest/APIReference/API_CreateLogGroup.html)

| Parameter    | Type   | Required | Default | Description                                 |
| ------------ | ------ | -------- | ------- | ------------------------------------------- |
| logGroupName | String | Yes      | N/A     | The name of the log group you are creating. |
| tags         | Table  | No       | `null`  | The key-value pairs to use for the tags.    |

##### Example

```squirrel
const HTTP_RESPONSE_SUCCESS = 200;
groupParams <- {
    "logGroupName": "testLogGroup",
    "tags": { "Environment": "test" }
};

logs.action(AWS_CLOUDWATCH_LOGS_ACTION_CREATE_LOG_GROUP, groupParams, function (res) {
    if (res.statuscode == HTTP_RESPONSE_SUCCESS) {
        server.log("Created a log group successfully");
    } else {
        server.log("Failed to create log group. error: " + http.jsondecode(res.body).message);
    }
});
```

#### AWS_CLOUDWATCH_LOGS_ACTION_CREATE_LOG_STREAM

Creates a log stream for the specified log group. For more detail please see: [AWS Docs](http://docs.aws.amazon.com/AmazonCloudWatchLogs/latest/APIReference/API_CreateLogStream.html)

| Parameter     | Type   | Required | Description |
| ------------- | ------ | -------- | ----------- |
| logGroupName  | String | Yes      | The name of the existing log group. |
| logStreamName | String | Yes      | The name of the log stream you are creating. |

##### Example

```squirrel
params <- {
    "logGroupName": "testLogGroup",
    "logStreamName": "testLogStream"
};

logs.action(AWS_CLOUDWATCH_LOGS_ACTION_CREATE_LOG_STREAM, params, function (res) {
    if (res.statuscode == HTTP_RESPONSE_SUCCESS) {
        server.log("Created a log stream successfully");
    } else {
        server.log("Failed to create log stream. error: " + http.jsondecode(res.body).message);
    }
});
```

#### AWS_CLOUDWATCH_LOGS_ACTION_DELETE_LOG_GROUP

Deletes a log group with the specified name. For more detail please see: [AWS Docs](http://docs.aws.amazon.com/AmazonCloudWatchLogs/latest/APIReference/API_DeleteLogGroup.html)

| Parameter    | Type   | Required | Description |
| ------------ | ------ | -------- | ----------- |
| logGroupName | String | Yes      | The name of the log group you want to delete. |

##### Example

```squirrel
deleteParams <- {
    "logGroupName": "testLogGroup"
};

logs.action(AWS_CLOUDWATCH_LOGS_ACTION_DELETE_LOG_GROUP, deleteParams, function (res) {
    if (res.statuscode == HTTP_RESPONSE_SUCCESS) {
        server.log("Deleted log group successfully");
    } else {
        server.log("Failed to delete log group. error: " + http.jsondecode(res.body).message);
    }
});
```


#### AWS_CLOUDWATCH_LOGS_ACTION_DELETE_LOG_STREAM

Deletes the specified log stream and permanently deletes all the archived log events associated with the log stream. For more detail please see: [AWS Docs](http://docs.aws.amazon.com/AmazonCloudWatchLogs/latest/APIReference/API_DeleteLogStream.html)

| Parameter     | Type   | Required | Description |
| ------------- | ------ | -------- | ----------- |
| logGroupName  | String | Yes      | The name of the log group. |
| logStreamName | String | Yes      | The name of the log stream you are deleting from the log group. |

##### Example

```squirrel
params <- {
    "logGroupName": "testLogGroup",
    "logStreamName": "testLogStream"
};

logs.action(AWS_CLOUDWATCH_LOGS_ACTION_DELETE_LOG_STREAM, deleteParams, function (res) {
    if (res.statuscode == HTTP_RESPONSE_SUCCESS) {
        server.log("Deleted log stream successfully");
    } else {
        server.log("Failed to delete log stream. error: " + http.jsondecode(res.body).message);
    }
});
```

#### AWS_CLOUDWATCH_LOGS_ACTION_PUT_LOG_EVENTS

Uploads a batch of log events to the specified log stream. For more detail please see: [AWS Docs](http://docs.aws.amazon.com/AmazonCloudWatchLogs/latest/APIReference/API_PutLogEvents.html)

| Parameter     | Type            | Required | Default | Description                                 |
| ------------- | --------------- | -------- | ------- | ------------------------------------------- |
| logEvents     | Array of Tables | Yes      | N/A     | An array of log event tables. Each event table must contain the keys "message" and "timestamp". The "message" value must be of type `String` and should contain the log message. The "timestamp" value must be of type `String` and should formatted as milliseconds since Unix Epoch (milliseconds passed Jan 1, 1970 00:00:00 UTC). |
| logGroupName  | String          | Yes      | N/A     | The name of the log group. |
| logStreamName | String          | Yes      | N/A     | The name of the log stream. |
| sequenceToken | No              | No       | `null`  | The sequence token. |

##### Example

```squirrel
d       <- date();
msecStr <- format("%06d", d.usec).slice(0,3);
t       <- format("%d%s", time(), msecStr);

putLogParams <- {
    "logGroupName": "testLogGroup",
    "logStreamName": "testLogStream",
    "logEvents": [{
        "message": "log",
        "timestamp": t
    }]
};

logs.action(AWS_CLOUDWATCH_LOGS_ACTION_PUT_LOG_EVENTS, putLogParams, function(res) {
    if (res.statuscode) {
        server.log("successfully put a log in a stream");
    } else {
        server.log("failed to put a log in a stream");
    }
});
```

#### Callback Response Table

The response table general to all functions contains the following keys:

| Key          | Type    | Description |
| ------------ | ------- | ----------- |
| *body*       | String  | Cloud Watch Logs response in a function specific structure that is json encoded. |
| *statuscode* | Integer | http status code. |
| *headers*    | Table   | see headers. |

##### Headers

The *headers* table, contains the following keys:

| Key              | Type   | Description |
| ---------------- | ------ | ----------- |
| x-amzn-requestid | String | Amazon request id. |
| connection       | String | Connection status. |
| date             | String | The date and time at which response was sent. |
| content-length   | String | the length of the content. |


## License

The AWSCloudWatchLogs library is licensed under the [MIT License](LICENSE).
