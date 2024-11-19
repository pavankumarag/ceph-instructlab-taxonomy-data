# Bucket Operations

## PUT Bucket

Creates a new bucket. To create a bucket, you must have a user ID and a
valid AWS Access Key ID to authenticate requests. You may not create
buckets as an anonymous user.

### Constraints

In general, bucket names should follow domain name constraints.

-   Bucket names must be unique.
-   Bucket names cannot be formatted as IP address.
-   Bucket names can be between 3 and 63 characters long.
-   Bucket names must not contain uppercase characters or underscores.
-   Bucket names must start with a lowercase letter or number.
-   Bucket names must be a series of one or more labels. Adjacent labels
    are separated by a single period (.). Bucket names can contain
    lowercase letters, numbers, and hyphens. Each label must start and
    end with a lowercase letter or a number.

:::: note
::: title
Note
:::

The above constraints are relaxed if the option
\'rgw_relaxed_s3_bucket_names\' is set to true except that the bucket
names must still be unique, cannot be formatted as IP address and can
contain letters, numbers, periods, dashes and underscores for up to 255
characters long.
::::

### Syntax

    PUT /{bucket} HTTP/1.1
    Host: cname.domain.com
    x-amz-acl: public-read-write

    Authorization: AWS {access-key}:{hash-of-header-and-secret}

### Parameters

  -------------------------------------------------------------------------------------------------------------
  Name                                 Description   Valid Values                                    Required
  ------------------------------------ ------------- ---------------------- ------------------------ ----------
  `x-amz-acl`                          Canned ACLs.  `private`,                                      No
                                                     `public-read`,                                  
                                                     `public-read-write`,                            
                                                     `authenticated-read`                            

  `x-amz-bucket-object-lock-enabled`                 Enable object lock on                           No
                                                     bucket. \| `true`,                              
                                                     `false`                                         
  -------------------------------------------------------------------------------------------------------------

### Request Entities

  -----------------------------------------------------------------------------------
  Name                          Type        Description
  ----------------------------- ----------- -----------------------------------------
  `CreateBucketConfiguration`   Container   A container for the bucket configuration.

  `LocationConstraint`          String      A zonegroup api name, with optional
                                            `s3_bucket_placement`{.interpreted-text
                                            role="ref"}
  -----------------------------------------------------------------------------------

### HTTP Response

If the bucket name is unique, within constraints and unused, the
operation will succeed. If a bucket with the same name already exists
and the user is the bucket owner, the operation will succeed. If the
bucket name is already in use, the operation will fail.

  ---------------------------------------------------------------------------
  HTTP Status Status Code           Description
  ----------- --------------------- -----------------------------------------
  `409`       BucketAlreadyExists   Bucket already exists under different
                                    user\'s ownership.

  ---------------------------------------------------------------------------

## DELETE Bucket

Deletes a bucket. You can reuse bucket names following a successful
bucket removal.

### Syntax

    DELETE /{bucket} HTTP/1.1
    Host: cname.domain.com

    Authorization: AWS {access-key}:{hash-of-header-and-secret}

### HTTP Response

  --------------------------------------------------
  HTTP Status     Status Code     Description
  --------------- --------------- ------------------
  `204`           No Content      Bucket removed.

  --------------------------------------------------

## GET Bucket

Returns a list of bucket objects.

### Syntax

    GET /{bucket}?max-keys=25 HTTP/1.1
    Host: cname.domain.com

### Parameters

  ----------------------------------------------------------------------------------
  Name                Type      Description
  ------------------- --------- ----------------------------------------------------
  `prefix`            String    Only returns objects that contain the specified
                                prefix.

  `delimiter`         String    The delimiter between the prefix and the rest of the
                                object name.

  `marker`            String    A beginning index for the list of objects returned.

  `max-keys`          Integer   The maximum number of keys to return. Default is
                                1000.

  `allow-unordered`   Boolean   Non-standard extension. Allows results to be
                                returned unordered. Cannot be used with delimiter.
  ----------------------------------------------------------------------------------

### HTTP Response

  ----------------------------------------------------
  HTTP Status     Status Code     Description
  --------------- --------------- --------------------
  `200`           OK              Buckets retrieved

  ----------------------------------------------------

### Bucket Response Entities

`GET /{bucket}` returns a container for buckets with the following
fields.

  ---------------------------------------------------------------------------------
  Name                 Type        Description
  -------------------- ----------- ------------------------------------------------
  `ListBucketResult`   Entity      The container for the list of objects.

  `Name`               String      The name of the bucket whose contents will be
                                   returned.

  `Prefix`             String      A prefix for the object keys.

  `Marker`             String      A beginning index for the list of objects
                                   returned.

  `MaxKeys`            Integer     The maximum number of keys returned.

  `Delimiter`          String      If set, objects with the same prefix will appear
                                   in the `CommonPrefixes` list.

  `IsTruncated`        Boolean     If `true`, only a subset of the bucket\'s
                                   contents were returned.

  `CommonPrefixes`     Container   If multiple objects contain the same prefix,
                                   they will appear in this list.
  ---------------------------------------------------------------------------------

### Object Response Entities

The `ListBucketResult` contains objects, where each object is within a
`Contents` container.

  ----------------------------------------------------------------------
  Name                  Type       Description
  --------------------- ---------- -------------------------------------
  `Contents`            Object     A container for the object.

  `Key`                 String     The object\'s key.

  `LastModified`        Date       The object\'s last-modified
                                   date/time.

  `ETag`                String     An MD-5 hash of the object. (entity
                                   tag)

  `Size`                Integer    The object\'s size.

  `StorageClass`        String     Should always return `STANDARD`.

  `Type`                String     `Appendable` or `Normal`.
  ----------------------------------------------------------------------

## Get Bucket Location

Retrieves the bucket\'s region. The user needs to be the bucket owner to
call this. A bucket can be constrained to a region by providing
`LocationConstraint` during a PUT request.

### Syntax

Add the `location` subresource to bucket resource as shown below

    GET /{bucket}?location HTTP/1.1
    Host: cname.domain.com

    Authorization: AWS {access-key}:{hash-of-header-and-secret}

### Response Entities

  -----------------------------------------------------------------------
  Name                   Type       Description
  ---------------------- ---------- -------------------------------------
  `LocationConstraint`   String     The region where bucket resides,
                                    empty string for default region

  -----------------------------------------------------------------------

## Get Bucket ACL

Retrieves the bucket access control list. The user needs to be the
bucket owner or to have been granted `READ_ACP` permission on the
bucket.

### Syntax

Add the `acl` subresource to the bucket request as shown below.

    GET /{bucket}?acl HTTP/1.1
    Host: cname.domain.com

    Authorization: AWS {access-key}:{hash-of-header-and-secret}

### Response Entities

  ------------------------------------------------------------------------------------
  Name                    Type        Description
  ----------------------- ----------- ------------------------------------------------
  `AccessControlPolicy`   Container   A container for the response.

  `AccessControlList`     Container   A container for the ACL information.

  `Owner`                 Container   A container for the bucket owner\'s `ID` and
                                      `DisplayName`.

  `ID`                    String      The bucket owner\'s ID.

  `DisplayName`           String      The bucket owner\'s display name.

  `Grant`                 Container   A container for `Grantee` and `Permission`.

  `Grantee`               Container   A container for the `DisplayName` and `ID` of
                                      the user receiving a grant of permission.

  `Permission`            String      The permission given to the `Grantee` bucket.
  ------------------------------------------------------------------------------------

## PUT Bucket ACL

Sets an access control to an existing bucket. The user needs to be the
bucket owner or to have been granted `WRITE_ACP` permission on the
bucket.

### Syntax

Add the `acl` subresource to the bucket request as shown below.

    PUT /{bucket}?acl HTTP/1.1

### Request Entities

  ------------------------------------------------------------------------------------
  Name                    Type        Description
  ----------------------- ----------- ------------------------------------------------
  `AccessControlPolicy`   Container   A container for the request.

  `AccessControlList`     Container   A container for the ACL information.

  `Owner`                 Container   A container for the bucket owner\'s `ID` and
                                      `DisplayName`.

  `ID`                    String      The bucket owner\'s ID.

  `DisplayName`           String      The bucket owner\'s display name.

  `Grant`                 Container   A container for `Grantee` and `Permission`.

  `Grantee`               Container   A container for the `DisplayName` and `ID` of
                                      the user receiving a grant of permission.

  `Permission`            String      The permission given to the `Grantee` bucket.
  ------------------------------------------------------------------------------------

## List Bucket Multipart Uploads

`GET /?uploads` returns a list of the current in-progress multipart
uploads\--i.e., the application initiates a multipart upload, but the
service hasn\'t completed all the uploads yet.

### Syntax

    GET /{bucket}?uploads HTTP/1.1

### Parameters

You may specify parameters for `GET /{bucket}?uploads`, but none of them
are required.

  --------------------------------------------------------------------------------
  Name                 Type      Description
  -------------------- --------- -------------------------------------------------
  `prefix`             String    Returns in-progress uploads whose keys contains
                                 the specified prefix.

  `delimiter`          String    The delimiter between the prefix and the rest of
                                 the object name.

  `key-marker`         String    The beginning marker for the list of uploads.

  `max-keys`           Integer   The maximum number of in-progress uploads. The
                                 default is 1000.

  `max-uploads`        Integer   The maximum number of multipart uploads. The
                                 range from 1-1000. The default is 1000.

  `upload-id-marker`   String    Ignored if `key-marker` is not specified.
                                 Specifies the `ID` of first upload to list in
                                 lexicographical order at or following the `ID`.
  --------------------------------------------------------------------------------

### Response Entities

  ------------------------------------------------------------------------------------------------
  Name                                  Type        Description
  ------------------------------------- ----------- ----------------------------------------------
  `ListMultipartUploadsResult`          Container   A container for the results.

  `ListMultipartUploadsResult.Prefix`   String      The prefix specified by the `prefix` request
                                                    parameter (if any).

  `Bucket`                              String      The bucket that will receive the bucket
                                                    contents.

  `KeyMarker`                           String      The key marker specified by the `key-marker`
                                                    request parameter (if any).

  `UploadIdMarker`                      String      The marker specified by the `upload-id-marker`
                                                    request parameter (if any).

  `NextKeyMarker`                       String      The key marker to use in a subsequent request
                                                    if `IsTruncated` is `true`.

  `NextUploadIdMarker`                  String      The upload ID marker to use in a subsequent
                                                    request if `IsTruncated` is `true`.

  `MaxUploads`                          Integer     The max uploads specified by the `max-uploads`
                                                    request parameter.

  `Delimiter`                           String      If set, objects with the same prefix will
                                                    appear in the `CommonPrefixes` list.

  `IsTruncated`                         Boolean     If `true`, only a subset of the bucket\'s
                                                    upload contents were returned.

  `Upload`                              Container   A container for `Key`, `UploadId`,
                                                    `InitiatorOwner`, `StorageClass`, and
                                                    `Initiated` elements.

  `Key`                                 String      The key of the object once the multipart
                                                    upload is complete.

  `UploadId`                            String      The `ID` that identifies the multipart upload.

  `Initiator`                           Container   Contains the `ID` and `DisplayName` of the
                                                    user who initiated the upload.

  `DisplayName`                         String      The initiator\'s display name.

  `ID`                                  String      The initiator\'s ID.

  `Owner`                               Container   A container for the `ID` and `DisplayName` of
                                                    the user who owns the uploaded object.

  `StorageClass`                        String      The method used to store the resulting object.
                                                    `STANDARD` or `REDUCED_REDUNDANCY`

  `Initiated`                           Date        The date and time the user initiated the
                                                    upload.

  `CommonPrefixes`                      Container   If multiple objects contain the same prefix,
                                                    they will appear in this list.

  `CommonPrefixes.Prefix`               String      The substring of the key after the prefix as
                                                    defined by the `prefix` request parameter.
  ------------------------------------------------------------------------------------------------

## ENABLE/SUSPEND BUCKET VERSIONING

`PUT /?versioning` This subresource set the versioning state of an
existing bucket. To set the versioning state, you must be the bucket
owner.

You can set the versioning state with one of the following values:

-   Enabled : Enables versioning for the objects in the bucket, All
    objects added to the bucket receive a unique version ID.
-   Suspended : Disables versioning for the objects in the bucket, All
    objects added to the bucket receive the version ID null.

If the versioning state has never been set on a bucket, it has no
versioning state; a GET versioning request does not return a versioning
state value.

### Syntax

    PUT  /{bucket}?versioning  HTTP/1.1

### REQUEST ENTITIES

  -------------------------------------------------------------------------------------
  Name                        Type        Description
  --------------------------- ----------- ---------------------------------------------
  `VersioningConfiguration`   Container   A container for the request.

  `Status`                    String      Sets the versioning state of the bucket.
                                          Valid Values: Suspended/Enabled
  -------------------------------------------------------------------------------------

## PUT BUCKET OBJECT LOCK

Places an Object Lock configuration on the specified bucket. The rule
specified in the Object Lock configuration will be applied by default to
every new object placed in the specified bucket.

### Syntax

    PUT /{bucket}?object-lock HTTP/1.1

### Request Entities

+-------------+-----+------------------------------------------+----+
| Name        | T   | Description                              | Re |
|             | ype |                                          | qu |
|             |     |                                          | ir |
|             |     |                                          | ed |
+=============+=====+==========================================+====+
| `Ob         | Con | A container for the request.             | >  |
| jectLockCon | tai |                                          |  Y |
| figuration` | ner |                                          | es |
+-------------+-----+------------------------------------------+----+
| `ObjectL    | Str | Indicates whether this bucket has an     | >  |
| ockEnabled` | ing | Object Lock configuration enabled.       |  Y |
|             |     |                                          | es |
+-------------+-----+------------------------------------------+----+
| `Rule`      | Con | The Object Lock rule in place for the    | >  |
|             | tai | specified bucket.                        | No |
|             | ner |                                          |    |
+-------------+-----+------------------------------------------+----+
| `Defaul     | Con | The default retention period applied to  | >  |
| tRetention` | tai | new objects placed in the specified      | No |
|             | ner | bucket.                                  |    |
+-------------+-----+------------------------------------------+----+
| `Mode`      | Str | The default Object Lock retention mode.  | >  |
|             | ing | Valid Values: GOVERNANCE/COMPLIANCE      |  Y |
|             |     |                                          | es |
+-------------+-----+------------------------------------------+----+
| `Days`      | I   | The number of days specified for the     | >  |
|             | nte | default retention period.                | No |
|             | ger |                                          |    |
+-------------+-----+------------------------------------------+----+
| `Years`     | I   | The number of years specified for the    | >  |
|             | nte | default retention period.                | No |
|             | ger |                                          |    |
+-------------+-----+------------------------------------------+----+

### HTTP Response

If the bucket object lock is not enabled when creating the bucket, the
operation will fail.

  --------------------------------------------------------------------------
  HTTP Status Status Code          Description
  ----------- -------------------- -----------------------------------------
  `400`       MalformedXML         The XML is not well-formed

  `409`       InvalidBucketState   The bucket object lock is not enabled
  --------------------------------------------------------------------------

## GET BUCKET OBJECT LOCK

Gets the Object Lock configuration for a bucket. The rule specified in
the Object Lock configuration will be applied by default to every new
object placed in the specified bucket.

### Syntax

    GET /{bucket}?object-lock HTTP/1.1

### Response Entities

+-------------+-----+------------------------------------------+----+
| Name        | T   | Description                              | Re |
|             | ype |                                          | qu |
|             |     |                                          | ir |
|             |     |                                          | ed |
+=============+=====+==========================================+====+
| `Ob         | Con | A container for the request.             | >  |
| jectLockCon | tai |                                          |  Y |
| figuration` | ner |                                          | es |
+-------------+-----+------------------------------------------+----+
| `ObjectL    | Str | Indicates whether this bucket has an     | >  |
| ockEnabled` | ing | Object Lock configuration enabled.       |  Y |
|             |     |                                          | es |
+-------------+-----+------------------------------------------+----+
| `Rule`      | Con | The Object Lock rule in place for the    | >  |
|             | tai | specified bucket.                        | No |
|             | ner |                                          |    |
+-------------+-----+------------------------------------------+----+
| `Defaul     | Con | The default retention period applied to  | >  |
| tRetention` | tai | new objects placed in the specified      | No |
|             | ner | bucket.                                  |    |
+-------------+-----+------------------------------------------+----+
| `Mode`      | Str | The default Object Lock retention mode.  | >  |
|             | ing | Valid Values: GOVERNANCE/COMPLIANCE      |  Y |
|             |     |                                          | es |
+-------------+-----+------------------------------------------+----+
| `Days`      | I   | The number of days specified for the     | >  |
|             | nte | default retention period.                | No |
|             | ger |                                          |    |
+-------------+-----+------------------------------------------+----+
| `Years`     | I   | The number of years specified for the    | >  |
|             | nte | default retention period.                | No |
|             | ger |                                          |    |
+-------------+-----+------------------------------------------+----+

## Create Notification

Create a publisher for a specific bucket into a topic.

### Syntax

    PUT /{bucket}?notification HTTP/1.1

### Request Entities

Parameters are XML encoded in the body of the request, in the following
format:

    <NotificationConfiguration xmlns="http://s3.amazonaws.com/doc/2006-03-01/">
        <TopicConfiguration>
            <Id></Id>
            <Topic></Topic>
            <Event></Event>
            <Filter>
                <S3Key>
                    <FilterRule>
                        <Name></Name>
                        <Value></Value>
                    </FilterRule>
                 </S3Key>
                 <S3Metadata>
                     <FilterRule>
                         <Name></Name>
                         <Value></Value>
                     </FilterRule>
                 </S3Metadata>
                 <S3Tags>
                     <FilterRule>
                         <Name></Name>
                         <Value></Value>
                     </FilterRule>
                 </S3Tags>
             </Filter>
        </TopicConfiguration>
    </NotificationConfiguration>

+---------------+-----+------------------------------------------+----+
| Name          | T   | Description                              | Re |
|               | ype |                                          | qu |
|               |     |                                          | ir |
|               |     |                                          | ed |
+===============+=====+==========================================+====+
| `             | Con | Holding list of `TopicConfiguration`     | Y  |
| NotificationC | tai | entities                                 | es |
| onfiguration` | ner |                                          |    |
+---------------+-----+------------------------------------------+----+
| `TopicC       | Con | Holding `Id`, `Topic` and list of        | Y  |
| onfiguration` | tai | `Event` entities                         | es |
|               | ner |                                          |    |
+---------------+-----+------------------------------------------+----+
| `Id`          | Str | Name of the notification                 | Y  |
|               | ing |                                          | es |
+---------------+-----+------------------------------------------+----+
| `Topic`       | Str | Topic ARN. Topic must be created         | Y  |
|               | ing | beforehand                               | es |
+---------------+-----+------------------------------------------+----+
| `Event`       | Str | List of supported events see: [S3        | No |
|               | ing | Notification                             |    |
|               |     | Compatibilit                             |    |
|               |     | y](../../s3-notification-compatibility). |    |
|               |     | Multiple `Event` entities can be used.   |    |
|               |     | If omitted, all \"Created\" and          |    |
|               |     | \"Removed\" events are handled.          |    |
|               |     | \"Lifecycle\" and \"Synced\" event types |    |
|               |     | must be specified explicitly.            |    |
+---------------+-----+------------------------------------------+----+
| `Filter`      | Con | Holding `S3Key`, `S3Metadata` and        | No |
|               | tai | `S3Tags` entities                        |    |
|               | ner |                                          |    |
+---------------+-----+------------------------------------------+----+
| `S3Key`       | Con | Holding a list of `FilterRule` entities, | No |
|               | tai | for filtering based on object key. At    |    |
|               | ner | most, 3 entities may be in the list,     |    |
|               |     | with `Name` be `prefix`, `suffix` or     |    |
|               |     | `regex`. All filter rules in the list    |    |
|               |     | must match for the filter to match.      |    |
+---------------+-----+------------------------------------------+----+
| `S3Metadata`  | Con | Holding a list of `FilterRule` entities, | No |
|               | tai | for filtering based on object metadata.  |    |
|               | ner | All filter rules in the list must match  |    |
|               |     | the metadata defined on the object.      |    |
|               |     | However, the object still match if it    |    |
|               |     | has other metadata entries not listed in |    |
|               |     | the filter.                              |    |
+---------------+-----+------------------------------------------+----+
| `S3Tags`      | Con | Holding a list of `FilterRule` entities, | No |
|               | tai | for filtering based on object tags. All  |    |
|               | ner | filter rules in the list must match the  |    |
|               |     | tags defined on the object. However, the |    |
|               |     | object still match it it has other tags  |    |
|               |     | not listed in the filter.                |    |
+---------------+-----+------------------------------------------+----+
| `S3Ke         | Con | Holding `Name` and `Value` entities.     | Y  |
| y.FilterRule` | tai | `Name` would be: `prefix`, `suffix` or   | es |
|               | ner | `regex`. The `Value` would hold the key  |    |
|               |     | prefix, key suffix or a regular          |    |
|               |     | expression for matching the key,         |    |
|               |     | accordingly.                             |    |
+---------------+-----+------------------------------------------+----+
| `S3Metadat    | Con | Holding `Name` and `Value` entities.     | Y  |
| a.FilterRule` | tai | `Name` would be the name of the metadata | es |
|               | ner | attribute (e.g. `x-amz-meta-xxx`). The   |    |
|               |     | `Value` would be the expected value for  |    |
|               |     | this attribute.                          |    |
+---------------+-----+------------------------------------------+----+
| `S3Tag        | Con | Holding `Name` and `Value` entities.     | >  |
| s.FilterRule` | tai | `Name` would be the tag key, and `Value` |  Y |
|               | ner | would be the tag value.                  | es |
+---------------+-----+------------------------------------------+----+

### HTTP Response

  -----------------------------------------------------------------------
  HTTP Status Status Code       Description
  ----------- ----------------- -----------------------------------------
  `400`       MalformedXML      The XML is not well-formed

  `400`       InvalidArgument   Missing Id; Missing/Invalid Topic ARN;
                                Invalid Event

  `404`       NoSuchBucket      The bucket does not exist

  `404`       NoSuchKey         The topic does not exist
  -----------------------------------------------------------------------

## Delete Notification

Delete a specific, or all, notifications from a bucket.

:::: note
::: title
Note
:::

-   Notification deletion is an extension to the S3 notification API
-   When the bucket is deleted, any notification defined on it is also
    deleted
-   Deleting an unknown notification (e.g. double delete) is not
    considered an error
::::

### Syntax

    DELETE /{bucket}?notification[=<notification-id>] HTTP/1.1

### Parameters

  ------------------------------------------------------------------------------
  Name                Type     Description
  ------------------- -------- -------------------------------------------------
  `notification-id`   String   Name of the notification. If not provided, all
                               notifications on the bucket are deleted

  ------------------------------------------------------------------------------

### HTTP Response

  -----------------------------------------------------------------------
  HTTP Status Status Code       Description
  ----------- ----------------- -----------------------------------------
  `404`       NoSuchBucket      The bucket does not exist

  -----------------------------------------------------------------------

## Get/List Notification

Get a specific notification, or list all notifications configured on a
bucket.

### Syntax

    GET /{bucket}?notification[=<notification-id>] HTTP/1.1 

### Parameters

  ------------------------------------------------------------------------------
  Name                Type     Description
  ------------------- -------- -------------------------------------------------
  `notification-id`   String   Name of the notification. If not provided, all
                               notifications on the bucket are listed

  ------------------------------------------------------------------------------

### Response Entities

Response is XML encoded in the body of the request, in the following
format:

    <NotificationConfiguration xmlns="http://s3.amazonaws.com/doc/2006-03-01/">
        <TopicConfiguration>
            <Id></Id>
            <Topic></Topic>
            <Event></Event>
            <Filter>
                <S3Key>
                    <FilterRule>
                        <Name></Name>
                        <Value></Value>
                    </FilterRule>
                 </S3Key>
                 <S3Metadata>
                     <FilterRule>
                         <Name></Name>
                         <Value></Value>
                     </FilterRule>
                 </S3Metadata>
                 <S3Tags>
                     <FilterRule>
                         <Name></Name>
                         <Value></Value>
                     </FilterRule>
                 </S3Tags>
             </Filter>
        </TopicConfiguration>
    </NotificationConfiguration>

  -----------------------------------------------------------------------------------------------
  Name                          Type        Description                                Required
  ----------------------------- ----------- ------------------------------------------ ----------
  `NotificationConfiguration`   Container   Holding list of `TopicConfiguration`       Yes
                                            entities                                   

  `TopicConfiguration`          Container   Holding `Id`, `Topic` and list of `Event`  Yes
                                            entities                                   

  `Id`                          String      Name of the notification                   Yes

  `Topic`                       String      Topic ARN                                  Yes

  `Event`                       String      Handled event. Multiple `Event` entities   Yes
                                            may exist                                  

  `Filter`                      Container   Holding the filters configured for this    No
                                            notification                               
  -----------------------------------------------------------------------------------------------

### HTTP Response

  -----------------------------------------------------------------------
  HTTP Status Status Code       Description
  ----------- ----------------- -----------------------------------------
  `404`       NoSuchBucket      The bucket does not exist

  `404`       NoSuchKey         The notification does not exist (if
                                provided)
  -----------------------------------------------------------------------
