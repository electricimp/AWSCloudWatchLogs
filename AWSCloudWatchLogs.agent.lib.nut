// MIT License
//
// Copyright 2018 Electric Imp
//
// SPDX-License-Identifier: MIT
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be
// included in all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
// EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
// MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO
// EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES
// OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
// ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
// OTHER DEALINGS IN THE SOFTWARE.

const AWS_CLOUDWATCH_LOGS_ACTION_CREATE_LOG_STREAM = "CreateLogStream";
const AWS_CLOUDWATCH_LOGS_ACTION_CREATE_LOG_GROUP  = "CreateLogGroup";
const AWS_CLOUDWATCH_LOGS_ACTION_DELETE_LOG_GROUP  = "DeleteLogGroup";
const AWS_CLOUDWATCH_LOGS_ACTION_DELETE_LOG_STREAM = "DeleteLogStream";
const AWS_CLOUDWATCH_LOGS_ACTION_PUT_LOG_EVENTS    = "PutLogEvents";

const AWS_CLOUDWATCH_LOGS_TARGET_PREFIX            = "Logs_20140328";
const AWS_CLOUDWATCH_LOGS_CONTENT_TYPE             = "application/x-amz-json-1.1";
const AWS_CLOUDWATCH_LOGS_SERVICE                  = "logs";

class AWSCloudWatchLogs {

    static VERSION = "1.0.0";

    _awsRequest = null;

    // --------------------------------------------------------------------------
    // @param {string} region
    // @param {string} accessKeyId
    // @param {string} secretAccessKey
    // --------------------------------------------------------------------------
    constructor(region, accessKeyId, secretAccessKey) {
        if ("AWSRequestV4" in getroottable()) {
            _awsRequest = AWSRequestV4(AWS_CLOUDWATCH_LOGS_SERVICE, region, accessKeyId, secretAccessKey);
        } else {
            throw ("This class requires AWSRequestV4 - please make sure it is loaded.");
        }
    }

    // --------------------------------------------------------------------------
    // @param {string} action constant
    // @param {table} params
    // @param {function} cb
    // --------------------------------------------------------------------------
    function action(actionType, params, cb) {
        local headers = {
            "X-Amz-Target": format("%s.%s", AWS_CLOUDWATCH_LOGS_TARGET_PREFIX, actionType),
            "Content-Type": AWS_CLOUDWATCH_LOGS_CONTENT_TYPE
        };

        local body = null;
        local error = "An error occurred while encodeing parameters.";

        if (actionType == AWS_CLOUDWATCH_LOGS_ACTION_PUT_LOG_EVENTS) {
            try {
                local ep = format("{\"logGroupName\":\"%s\",\"logStreamName\":\"%s\",\"logEvents\":[", params.logGroupName, params.logStreamName);
                foreach (idx, log in params.logEvents) {
                    ep += format("{\"message\":\"%s\",\"timestamp\":%s}%s",
                                 log.message,
                                 log.timestamp.tostring(),
                                 (idx != (params.logEvents.len() - 1)) ? "," : "]}");
                }
                body = ep;
            } catch(e) {
                error += " " + e;
            }
        } else {
            body = http.jsonencode(params);
        }

        if (body != null) {
            _awsRequest.post("/", headers, body, cb);
        } else {
            cb({"error" : error});
        }
    }

}
