// Copyright (c) 2025, WSO2 LLC. (http://www.wso2.com).
//
// WSO2 LLC. licenses this file to you under the Apache License,
// Version 2.0 (the "License"); you may not use this file except
// in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing,
// software distributed under the License is distributed on an
// "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
// KIND, either express or implied.  See the License for the
// specific language governing permissions and limitations
// under the License.

import ballerina/http;

# Standard error response object returned when an API request fails.
public type StandardError record {
    # Optional sub-category providing further error classification detail.
    record {} subCategory?;
    # Key-value map of contextual metadata related to the error.
    record {|string[]...;|} context;
    # Map of relevant links associated with the error response.
    record {|string...;|} links;
    # Unique identifier for this specific error instance.
    string id?;
    # High-level category classifying the type of error.
    string category;
    # Human-readable description of the error.
    string message;
    # List of detailed error entries associated with this error.
    ErrorDetail[] errors;
    # HTTP status code or status label for the error response.
    string status;
};

# Paginated collection response containing a list of associated object IDs.
public type CollectionResponseAssociatedId record {
    # Pagination cursors for navigating forward and backward through result sets.
    Paging paging?;
    # Array of associated IDs returned in the current page.
    AssociatedId[] results;
};

# Defines the association target object and relationship types for a contact.
public type PublicAssociationsForObject record {
    # List of association type specifications defining the relationship.
    AssociationSpec[] types?;
    # Represents a reference to a public object by its unique identifier.
    PublicObjectId to?;
};

# Batch operation response containing results and processing status for multiple contacts.
public type BatchResponseSimplePublicObject record {
    # Timestamp indicating when the batch operation completed.
    string completedAt;
    # Timestamp indicating when the batch operation was requested.
    string requestedAt?;
    # Timestamp indicating when the batch operation began processing.
    string startedAt;
    # Map of supplementary links related to the batch response.
    record {|string...;|} links?;
    # Array of contact objects returned by the batch operation.
    SimplePublicObject[] results;
    # Current processing status of the batch operation.
    "PENDING"|"PROCESSING"|"CANCELED"|"COMPLETE" status;
};

# A logical grouping of filters applied together when searching contacts.
public type FilterGroup record {
    # Array of filter conditions applied within this group.
    Filter[] filters;
};

# Detailed information about a specific error encountered during a request.
public type ErrorDetail record {
    # A specific category that contains more specific detail about the error
    string subCategory?;
    # The status code associated with the error detail
    string code?;
    # The name of the field or parameter in which the error was found
    string 'in?;
    # Context about the error condition
    record {|string[]...;|} context?;
    # A human readable message describing the error along with remediation steps where appropriate
    string message;
};

# Pagination object providing a cursor for forward navigation through results.
public type ForwardPaging record {
    # Pagination cursor object providing a token and optional link to retrieve the next page of results.
    NextPage next?;
};

# An object representing a unique identifier for a public contact record.
public type SimplePublicObjectId record {
    # The unique identifier of the contact record.
    string id;
};

# Batch upsert response containing results, errors, and processing metadata for contact records.
public type BatchResponseSimplePublicUpsertObjectWithErrors record {
    # Timestamp indicating when the batch operation completed.
    string completedAt;
    # Total number of errors encountered during the batch operation.
    int:Signed32 numErrors?;
    # Timestamp indicating when the batch operation was requested.
    string requestedAt?;
    # Timestamp indicating when the batch operation began processing.
    string startedAt;
    # Map of relevant hyperlinks associated with the batch response.
    record {|string...;|} links?;
    # Array of upserted contact objects returned by the batch operation.
    SimplePublicUpsertObject[] results;
    # Array of errors encountered for individual records in the batch.
    StandardError[] errors?;
    # Current processing status of the batch upsert operation.
    "PENDING"|"PROCESSING"|"CANCELED"|"COMPLETE" status;
};

# Input schema for reading a batch of contacts by their unique IDs with specified properties.
public type BatchReadInputSimplePublicObjectId record {
    # List of properties for which historical values should be included.
    string[] propertiesWithHistory;
    # The property name used as the unique identifier for batch lookup.
    string idProperty?;
    # List of contact object IDs to retrieve in the batch request.
    SimplePublicObjectId[] inputs;
    # List of property names to include in the response for each contact.
    string[] properties;
};

# Response object representing the outcome of a batch upsert operation, including status, timing, and resulting contact records.
public type BatchResponseSimplePublicUpsertObject record {
    # Timestamp indicating when the batch operation completed.
    string completedAt;
    # Timestamp indicating when the batch operation was requested.
    string requestedAt?;
    # Timestamp indicating when the batch operation began processing.
    string startedAt;
    # Map of related resource links associated with the batch response.
    record {|string...;|} links?;
    # List of upserted contact objects returned from the batch operation.
    SimplePublicUpsertObject[] results;
    # Current processing status of the batch operation: PENDING, PROCESSING, CANCELED, or COMPLETE.
    "PENDING"|"PROCESSING"|"CANCELED"|"COMPLETE" status;
};

# Represents the Queries record for the operation: get-/crm/v3/objects/contacts_getPage
public type GetCrmV3ObjectsContactsGetPageQueries record {
    # A comma separated list of object types to retrieve associated IDs for. If any of the specified associations do not exist, they will be ignored
    string[] associations?;
    # Whether to return only results that have been archived
    boolean archived = false;
    # A comma separated list of the properties to be returned along with their history of previous values. If any of the specified properties are not present on the requested object(s), they will be ignored. Usage of this parameter will reduce the maximum number of objects that can be read by a single request
    string[] propertiesWithHistory?;
    # The maximum number of results to display per page
    int:Signed32 'limit = 10;
    # The paging cursor token of the last successfully read resource will be returned as the `paging.next.after` JSON property of a paged response containing more results
    string after?;
    # A comma separated list of the properties to be returned in the response. If any of the specified properties are not present on the requested object(s), they will be ignored
    string[] properties?;
};

# Represents a property value paired with its source metadata and the timestamp of the last update.
public type ValueWithTimestamp record {
    # Identifier of the source that set or updated the property value.
    string sourceId?;
    # Type of source that originated the property value change.
    string sourceType;
    # Human-readable label describing the source of the property value.
    string sourceLabel?;
    # ID of the user who last updated the property value.
    int:Signed32 updatedByUserId?;
    # The property value associated with the given timestamp and source.
    string value;
    # Timestamp indicating when the property value was last updated.
    string timestamp;
};

# Input schema for a batch operation specifying a list of contact object IDs to process.
public type BatchInputSimplePublicObjectId record {
    # List of contact object IDs to include in the batch operation.
    SimplePublicObjectId[] inputs;
};

# OAuth2 Refresh Token Grant Configs
public type OAuth2RefreshTokenGrantConfig record {|
    *http:OAuth2RefreshTokenGrantConfig;
    # Refresh URL
    string refreshUrl = "https://api.hubapi.com/oauth/v1/token";
|};

# Input schema for a batch upsert operation containing a list of contacts to create or update.
public type BatchInputSimplePublicObjectBatchInputUpsert record {
    # Array of contact upsert input objects to process in batch.
    SimplePublicObjectBatchInputUpsert[] inputs;
};

# A paginated collection of contacts with a total count and forward paging cursor.
public type CollectionResponseWithTotalSimplePublicObjectForwardPaging record {
    # Total number of contacts matching the request.
    int:Signed32 total;
    # Pagination object providing a cursor for forward navigation through results.
    ForwardPaging paging?;
    # Array of contact objects returned in the current page.
    SimplePublicObject[] results;
};

# Represents a contact record with its properties, timestamps, and archival status.
public type SimplePublicObject record {
    # Timestamp when the contact record was created.
    string createdAt;
    # Indicates whether the contact has been archived.
    boolean archived?;
    # Timestamp when the contact record was archived.
    string archivedAt?;
    # Map of property names to their historical values with timestamps.
    record {|ValueWithTimestamp[]...;|} propertiesWithHistory?;
    # Unique identifier for the contact record.
    string id;
    # Map of contact property names to their current values.
    record {|string?...;|} properties;
    # Timestamp when the contact record was last updated.
    string updatedAt;
};

# Provides a set of configurations for controlling the behaviours when communicating with a remote HTTP endpoint.
@display {label: "Connection Config"}
public type ConnectionConfig record {|
    # Provides Auth configurations needed when communicating with a remote HTTP endpoint.
    http:BearerTokenConfig|OAuth2RefreshTokenGrantConfig|ApiKeysConfig auth;
    # The HTTP version understood by the client
    http:HttpVersion httpVersion = http:HTTP_2_0;
    # Configurations related to HTTP/1.x protocol
    http:ClientHttp1Settings http1Settings = {};
    # Configurations related to HTTP/2 protocol
    http:ClientHttp2Settings http2Settings = {};
    # The maximum time to wait (in seconds) for a response before closing the connection
    decimal timeout = 30;
    # The choice of setting `forwarded`/`x-forwarded` header
    string forwarded = "disable";
    # Configurations associated with Redirection
    http:FollowRedirects followRedirects?;
    # Configurations associated with request pooling
    http:PoolConfiguration poolConfig?;
    # HTTP caching related configurations
    http:CacheConfig cache = {};
    # Specifies the way of handling compression (`accept-encoding`) header
    http:Compression compression = http:COMPRESSION_AUTO;
    # Configurations associated with the behaviour of the Circuit Breaker
    http:CircuitBreakerConfig circuitBreaker?;
    # Configurations associated with retrying
    http:RetryConfig retryConfig?;
    # Configurations associated with cookies
    http:CookieConfig cookieConfig?;
    # Configurations associated with inbound response size limits
    http:ResponseLimitConfigs responseLimits = {};
    # SSL/TLS-related options
    http:ClientSecureSocket secureSocket?;
    # Proxy server related options
    http:ProxyConfig proxy?;
    # Provides settings related to client socket configuration
    http:ClientSocketConfig socketConfig = {};
    # Enables the inbound payload validation functionality which provided by the constraint package. Enabled by default
    boolean validation = true;
    # Enables relaxed data binding on the client side. When enabled, `nil` values are treated as optional, 
    # and absent fields are handled as `nilable` types. Enabled by default.
    boolean laxDataBinding = true;
|};

# Represents a reference to a public object by its unique identifier.
public type PublicObjectId record {
    # Unique identifier of the referenced object.
    string id?;
};

# Pagination cursors for navigating forward and backward through result sets.
public type Paging record {
    # Pagination cursor object providing a token and optional link to retrieve the next page of results.
    NextPage next?;
    # Pagination cursor object referencing the previous page of results
    PreviousPage prev?;
};

# Request payload for searching contacts with filters, sorting, and pagination.
public type PublicObjectSearchRequest record {
    # Full-text search query string to match against contact records.
    string query?;
    # Maximum number of results to return per page.
    int:Signed32 'limit?;
    # Cursor token for retrieving the next page of results.
    string after?;
    # List of property names to sort results by.
    string[] sorts?;
    # List of contact properties to include in the response.
    string[] properties?;
    # Groups of filters used to narrow search results.
    FilterGroup[] filterGroups?;
};

# Input payload for upserting a single contact in a batch operation, including its ID and properties.
public type SimplePublicObjectBatchInputUpsert record {
    # The property name used as the unique identifier for the upsert.
    string idProperty?;
    # Trace ID for tracking the write operation.
    string objectWriteTraceId?;
    # The unique identifier of the contact to upsert.
    string id;
    # Key-value map of contact property names and their values.
    record {|string...;|} properties;
};

# Batch operation response containing contact results, processing status, timestamps, and any errors encountered.
public type BatchResponseSimplePublicObjectWithErrors record {
    # Timestamp indicating when the batch operation completed.
    string completedAt;
    # Total number of errors encountered during the batch operation.
    int:Signed32 numErrors?;
    # Timestamp indicating when the batch operation was requested.
    string requestedAt?;
    # Timestamp indicating when the batch operation began processing.
    string startedAt;
    # Map of relevant link names to associated URLs.
    record {|string...;|} links?;
    # List of successfully processed contact objects from the batch.
    SimplePublicObject[] results;
    # List of errors encountered for individual records in the batch.
    StandardError[] errors?;
    # Current processing status of the batch operation.
    "PENDING"|"PROCESSING"|"CANCELED"|"COMPLETE" status;
};

# Input schema for GDPR-compliant permanent deletion of a contact record.
public type PublicGdprDeleteInput record {
    # The property name used to identify the contact for deletion.
    string idProperty?;
    # The unique identifier of the contact to permanently delete.
    string objectId;
};

# Input schema for creating or updating a contact with key-value property pairs.
public type SimplePublicObjectInput record {
    # Trace identifier for tracking and auditing the write operation.
    string objectWriteTraceId?;
    # Map of contact property names to their string values to be written.
    record {|string...;|} properties;
};

# Represents the Queries record for the operation: post-/crm/v3/objects/contacts/batch/read_read
public type PostCrmV3ObjectsContactsBatchReadReadQueries record {
    # Whether to return only results that have been archived
    boolean archived = false;
};

# Paginated collection of contact objects including their associated records.
public type CollectionResponseSimplePublicObjectWithAssociationsForwardPaging record {
    # Pagination object providing a cursor for forward navigation through results.
    ForwardPaging paging?;
    # Array of contact objects returned in the current page of results.
    SimplePublicObjectWithAssociations[] results;
};

# Input schema specifying the two contact records to merge into one.
public type PublicMergeInput record {
    # The ID of the secondary contact to be merged into the primary record.
    string objectIdToMerge;
    # The ID of the primary contact that will be retained after the merge.
    string primaryObjectId;
};

# Defines the category and type of an association between CRM objects.
public type AssociationSpec record {
    # The category defining who created the association type.
    "HUBSPOT_DEFINED"|"USER_DEFINED"|"INTEGRATOR_DEFINED" associationCategory?;
    # Numeric identifier for the specific association type.
    int:Signed32 associationTypeId?;
};

# A contact record including its properties, metadata, and associated CRM objects.
public type SimplePublicObjectWithAssociations record {
    # Map of associated CRM object collections keyed by association type.
    record {|CollectionResponseAssociatedId...;|} associations?;
    # Timestamp indicating when the contact record was created.
    string createdAt;
    # Indicates whether the contact record has been archived.
    boolean archived?;
    # Timestamp indicating when the contact record was archived.
    string archivedAt?;
    # Map of property names to their historical values with timestamps
    record {|ValueWithTimestamp[]...;|} propertiesWithHistory?;
    # Unique identifier of the contact object
    string id;
    # Map of contact property names to their current values
    record {|string?...;|} properties;
    # Timestamp of the most recent update to the contact
    string updatedAt;
};

# Defines a filter condition used to query contacts by property value using a specified comparison operator
public type Filter record {
    # Upper bound value for range-based filter operators such as BETWEEN
    string highValue?;
    # The contact property name to evaluate in the filter condition
    string propertyName;
    # List of values used with multi-value operators such as IN or NOT_IN
    string[] values?;
    # Single value to compare against the specified contact property
    string value?;
    # null
    "EQ"|"NEQ"|"LT"|"LTE"|"GT"|"GTE"|"BETWEEN"|"IN"|"NOT_IN"|"HAS_PROPERTY"|"NOT_HAS_PROPERTY"|"CONTAINS_TOKEN"|"NOT_CONTAINS_TOKEN" operator;
};

# Pagination cursor object referencing the previous page of results
public type PreviousPage record {
    # Cursor token representing the start of the previous page
    string before;
    # URL link to retrieve the previous page of results
    string link?;
};

# Wrapper object containing a list of contact creation inputs for batch processing
public type BatchInputSimplePublicObjectInputForCreate record {
    # Array of contact creation input objects to process in the batch operation
    SimplePublicObjectInputForCreate[] inputs;
};

# Wrapper object containing a list of contact update inputs for batch processing
public type BatchInputSimplePublicObjectBatchInput record {
    # Array of contact update input objects to process in the batch operation
    SimplePublicObjectBatchInput[] inputs;
};

# Represents a contact record returned from an upsert operation, indicating whether the record was newly created
public type SimplePublicUpsertObject record {
    # Timestamp indicating when the contact record was originally created
    string createdAt;
    # Indicates whether the contact record is currently archived
    boolean archived?;
    # Timestamp indicating when the contact record was archived
    string archivedAt?;
    # Indicates whether the contact record was newly created by the upsert operation.
    boolean 'new;
    # Map of property names to their historical values with timestamps.
    record {|ValueWithTimestamp[]...;|} propertiesWithHistory?;
    # The unique identifier of the upserted contact record.
    string id;
    # Map of property names to their current values for the contact.
    record {|string...;|} properties;
    # Timestamp indicating when the contact record was last updated.
    string updatedAt;
};

# Represents the Queries record for the operation: get-/crm/v3/objects/contacts/{contactId}_getById
public type GetCrmV3ObjectsContactsContactIdGetByIdQueries record {
    # A comma separated list of object types to retrieve associated IDs for. If any of the specified associations do not exist, they will be ignored
    string[] associations?;
    # Whether to return only results that have been archived
    boolean archived = false;
    # A comma separated list of the properties to be returned along with their history of previous values. If any of the specified properties are not present on the requested object(s), they will be ignored
    string[] propertiesWithHistory?;
    # A comma separated list of the properties to be returned in the response. If any of the specified properties are not present on the requested object(s), they will be ignored
    string[] properties?;
};

# Input payload for updating an existing contact in a batch operation, identified by a unique ID and containing key-value property data.
public type SimplePublicObjectBatchInput record {
    # The name of a unique property used to identify the contact instead of the default ID.
    string idProperty?;
    # Trace identifier for tracking and debugging the write operation.
    string objectWriteTraceId?;
    # The unique identifier of the contact record to update.
    string id;
    # Map of property names to their updated values for the contact.
    record {|string...;|} properties;
};

# Pagination cursor object providing a token and optional link to retrieve the next page of results.
public type NextPage record {
    # A ready-to-use relative URL for fetching the next page of results.
    string link?;
    # Cursor token used as the 'after' parameter to retrieve the next page of results.
    string after;
};

# Represents a reference to an associated object, defined by its unique ID and association type.
public type AssociatedId record {
    # The unique identifier of the associated object.
    string id;
    # The type of association between the contact and the related object.
    string 'type;
};

# Provides API key configurations needed when communicating with a remote HTTP endpoint.
public type ApiKeysConfig record {|
    string privateAppLegacy;
    string privateApp;
|};

# Input payload for creating a new contact, including property values and optional associations to other objects.
public type SimplePublicObjectInputForCreate record {
    # List of associations linking the new contact to other CRM objects.
    PublicAssociationsForObject[] associations?;
    # Trace identifier for tracking and debugging the write operation.
    string objectWriteTraceId?;
    # Map of property names to their values for the new contact record.
    record {|string...;|} properties;
};
