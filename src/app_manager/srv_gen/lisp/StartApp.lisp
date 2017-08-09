; Auto-generated. Do not edit!


(cl:in-package app_manager-srv)


;//! \htmlinclude StartApp-request.msg.html

(cl:defclass <StartApp-request> (roslisp-msg-protocol:ros-message)
  ((name
    :reader name
    :initarg :name
    :type cl:string
    :initform ""))
)

(cl:defclass StartApp-request (<StartApp-request>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <StartApp-request>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'StartApp-request)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name app_manager-srv:<StartApp-request> is deprecated: use app_manager-srv:StartApp-request instead.")))

(cl:ensure-generic-function 'name-val :lambda-list '(m))
(cl:defmethod name-val ((m <StartApp-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader app_manager-srv:name-val is deprecated.  Use app_manager-srv:name instead.")
  (name m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <StartApp-request>) ostream)
  "Serializes a message object of type '<StartApp-request>"
  (cl:let ((__ros_str_len (cl:length (cl:slot-value msg 'name))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_str_len) ostream))
  (cl:map cl:nil #'(cl:lambda (c) (cl:write-byte (cl:char-code c) ostream)) (cl:slot-value msg 'name))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <StartApp-request>) istream)
  "Deserializes a message object of type '<StartApp-request>"
    (cl:let ((__ros_str_len 0))
      (cl:setf (cl:ldb (cl:byte 8 0) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'name) (cl:make-string __ros_str_len))
      (cl:dotimes (__ros_str_idx __ros_str_len msg)
        (cl:setf (cl:char (cl:slot-value msg 'name) __ros_str_idx) (cl:code-char (cl:read-byte istream)))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<StartApp-request>)))
  "Returns string type for a service object of type '<StartApp-request>"
  "app_manager/StartAppRequest")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'StartApp-request)))
  "Returns string type for a service object of type 'StartApp-request"
  "app_manager/StartAppRequest")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<StartApp-request>)))
  "Returns md5sum for a message object of type '<StartApp-request>"
  "07c2c0d81a44b3d573187630fa526c81")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'StartApp-request)))
  "Returns md5sum for a message object of type 'StartApp-request"
  "07c2c0d81a44b3d573187630fa526c81")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<StartApp-request>)))
  "Returns full string definition for message of type '<StartApp-request>"
  (cl:format cl:nil "~%string name~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'StartApp-request)))
  "Returns full string definition for message of type 'StartApp-request"
  (cl:format cl:nil "~%string name~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <StartApp-request>))
  (cl:+ 0
     4 (cl:length (cl:slot-value msg 'name))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <StartApp-request>))
  "Converts a ROS message object to a list"
  (cl:list 'StartApp-request
    (cl:cons ':name (name msg))
))
;//! \htmlinclude StartApp-response.msg.html

(cl:defclass <StartApp-response> (roslisp-msg-protocol:ros-message)
  ((started
    :reader started
    :initarg :started
    :type cl:boolean
    :initform cl:nil)
   (error_code
    :reader error_code
    :initarg :error_code
    :type cl:integer
    :initform 0)
   (message
    :reader message
    :initarg :message
    :type cl:string
    :initform "")
   (namespace
    :reader namespace
    :initarg :namespace
    :type cl:string
    :initform ""))
)

(cl:defclass StartApp-response (<StartApp-response>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <StartApp-response>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'StartApp-response)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name app_manager-srv:<StartApp-response> is deprecated: use app_manager-srv:StartApp-response instead.")))

(cl:ensure-generic-function 'started-val :lambda-list '(m))
(cl:defmethod started-val ((m <StartApp-response>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader app_manager-srv:started-val is deprecated.  Use app_manager-srv:started instead.")
  (started m))

(cl:ensure-generic-function 'error_code-val :lambda-list '(m))
(cl:defmethod error_code-val ((m <StartApp-response>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader app_manager-srv:error_code-val is deprecated.  Use app_manager-srv:error_code instead.")
  (error_code m))

(cl:ensure-generic-function 'message-val :lambda-list '(m))
(cl:defmethod message-val ((m <StartApp-response>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader app_manager-srv:message-val is deprecated.  Use app_manager-srv:message instead.")
  (message m))

(cl:ensure-generic-function 'namespace-val :lambda-list '(m))
(cl:defmethod namespace-val ((m <StartApp-response>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader app_manager-srv:namespace-val is deprecated.  Use app_manager-srv:namespace instead.")
  (namespace m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <StartApp-response>) ostream)
  "Serializes a message object of type '<StartApp-response>"
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'started) 1 0)) ostream)
  (cl:let* ((signed (cl:slot-value msg 'error_code)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 4294967296) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    )
  (cl:let ((__ros_str_len (cl:length (cl:slot-value msg 'message))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_str_len) ostream))
  (cl:map cl:nil #'(cl:lambda (c) (cl:write-byte (cl:char-code c) ostream)) (cl:slot-value msg 'message))
  (cl:let ((__ros_str_len (cl:length (cl:slot-value msg 'namespace))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_str_len) ostream))
  (cl:map cl:nil #'(cl:lambda (c) (cl:write-byte (cl:char-code c) ostream)) (cl:slot-value msg 'namespace))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <StartApp-response>) istream)
  "Deserializes a message object of type '<StartApp-response>"
    (cl:setf (cl:slot-value msg 'started) (cl:not (cl:zerop (cl:read-byte istream))))
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'error_code) (cl:if (cl:< unsigned 2147483648) unsigned (cl:- unsigned 4294967296))))
    (cl:let ((__ros_str_len 0))
      (cl:setf (cl:ldb (cl:byte 8 0) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'message) (cl:make-string __ros_str_len))
      (cl:dotimes (__ros_str_idx __ros_str_len msg)
        (cl:setf (cl:char (cl:slot-value msg 'message) __ros_str_idx) (cl:code-char (cl:read-byte istream)))))
    (cl:let ((__ros_str_len 0))
      (cl:setf (cl:ldb (cl:byte 8 0) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'namespace) (cl:make-string __ros_str_len))
      (cl:dotimes (__ros_str_idx __ros_str_len msg)
        (cl:setf (cl:char (cl:slot-value msg 'namespace) __ros_str_idx) (cl:code-char (cl:read-byte istream)))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<StartApp-response>)))
  "Returns string type for a service object of type '<StartApp-response>"
  "app_manager/StartAppResponse")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'StartApp-response)))
  "Returns string type for a service object of type 'StartApp-response"
  "app_manager/StartAppResponse")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<StartApp-response>)))
  "Returns md5sum for a message object of type '<StartApp-response>"
  "07c2c0d81a44b3d573187630fa526c81")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'StartApp-response)))
  "Returns md5sum for a message object of type 'StartApp-response"
  "07c2c0d81a44b3d573187630fa526c81")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<StartApp-response>)))
  "Returns full string definition for message of type '<StartApp-response>"
  (cl:format cl:nil "~%bool started~%~%~%int32 error_code~%~%string message~%~%string namespace~%~%~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'StartApp-response)))
  "Returns full string definition for message of type 'StartApp-response"
  (cl:format cl:nil "~%bool started~%~%~%int32 error_code~%~%string message~%~%string namespace~%~%~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <StartApp-response>))
  (cl:+ 0
     1
     4
     4 (cl:length (cl:slot-value msg 'message))
     4 (cl:length (cl:slot-value msg 'namespace))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <StartApp-response>))
  "Converts a ROS message object to a list"
  (cl:list 'StartApp-response
    (cl:cons ':started (started msg))
    (cl:cons ':error_code (error_code msg))
    (cl:cons ':message (message msg))
    (cl:cons ':namespace (namespace msg))
))
(cl:defmethod roslisp-msg-protocol:service-request-type ((msg (cl:eql 'StartApp)))
  'StartApp-request)
(cl:defmethod roslisp-msg-protocol:service-response-type ((msg (cl:eql 'StartApp)))
  'StartApp-response)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'StartApp)))
  "Returns string type for a service object of type '<StartApp>"
  "app_manager/StartApp")