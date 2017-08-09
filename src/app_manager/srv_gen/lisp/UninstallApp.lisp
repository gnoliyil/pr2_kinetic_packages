; Auto-generated. Do not edit!


(cl:in-package app_manager-srv)


;//! \htmlinclude UninstallApp-request.msg.html

(cl:defclass <UninstallApp-request> (roslisp-msg-protocol:ros-message)
  ((name
    :reader name
    :initarg :name
    :type cl:string
    :initform ""))
)

(cl:defclass UninstallApp-request (<UninstallApp-request>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <UninstallApp-request>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'UninstallApp-request)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name app_manager-srv:<UninstallApp-request> is deprecated: use app_manager-srv:UninstallApp-request instead.")))

(cl:ensure-generic-function 'name-val :lambda-list '(m))
(cl:defmethod name-val ((m <UninstallApp-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader app_manager-srv:name-val is deprecated.  Use app_manager-srv:name instead.")
  (name m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <UninstallApp-request>) ostream)
  "Serializes a message object of type '<UninstallApp-request>"
  (cl:let ((__ros_str_len (cl:length (cl:slot-value msg 'name))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_str_len) ostream))
  (cl:map cl:nil #'(cl:lambda (c) (cl:write-byte (cl:char-code c) ostream)) (cl:slot-value msg 'name))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <UninstallApp-request>) istream)
  "Deserializes a message object of type '<UninstallApp-request>"
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
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<UninstallApp-request>)))
  "Returns string type for a service object of type '<UninstallApp-request>"
  "app_manager/UninstallAppRequest")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'UninstallApp-request)))
  "Returns string type for a service object of type 'UninstallApp-request"
  "app_manager/UninstallAppRequest")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<UninstallApp-request>)))
  "Returns md5sum for a message object of type '<UninstallApp-request>"
  "1694b710073aaad53ae6c852885793c6")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'UninstallApp-request)))
  "Returns md5sum for a message object of type 'UninstallApp-request"
  "1694b710073aaad53ae6c852885793c6")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<UninstallApp-request>)))
  "Returns full string definition for message of type '<UninstallApp-request>"
  (cl:format cl:nil "~%string name~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'UninstallApp-request)))
  "Returns full string definition for message of type 'UninstallApp-request"
  (cl:format cl:nil "~%string name~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <UninstallApp-request>))
  (cl:+ 0
     4 (cl:length (cl:slot-value msg 'name))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <UninstallApp-request>))
  "Converts a ROS message object to a list"
  (cl:list 'UninstallApp-request
    (cl:cons ':name (name msg))
))
;//! \htmlinclude UninstallApp-response.msg.html

(cl:defclass <UninstallApp-response> (roslisp-msg-protocol:ros-message)
  ((uninstalled
    :reader uninstalled
    :initarg :uninstalled
    :type cl:boolean
    :initform cl:nil)
   (message
    :reader message
    :initarg :message
    :type cl:string
    :initform ""))
)

(cl:defclass UninstallApp-response (<UninstallApp-response>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <UninstallApp-response>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'UninstallApp-response)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name app_manager-srv:<UninstallApp-response> is deprecated: use app_manager-srv:UninstallApp-response instead.")))

(cl:ensure-generic-function 'uninstalled-val :lambda-list '(m))
(cl:defmethod uninstalled-val ((m <UninstallApp-response>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader app_manager-srv:uninstalled-val is deprecated.  Use app_manager-srv:uninstalled instead.")
  (uninstalled m))

(cl:ensure-generic-function 'message-val :lambda-list '(m))
(cl:defmethod message-val ((m <UninstallApp-response>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader app_manager-srv:message-val is deprecated.  Use app_manager-srv:message instead.")
  (message m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <UninstallApp-response>) ostream)
  "Serializes a message object of type '<UninstallApp-response>"
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'uninstalled) 1 0)) ostream)
  (cl:let ((__ros_str_len (cl:length (cl:slot-value msg 'message))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_str_len) ostream))
  (cl:map cl:nil #'(cl:lambda (c) (cl:write-byte (cl:char-code c) ostream)) (cl:slot-value msg 'message))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <UninstallApp-response>) istream)
  "Deserializes a message object of type '<UninstallApp-response>"
    (cl:setf (cl:slot-value msg 'uninstalled) (cl:not (cl:zerop (cl:read-byte istream))))
    (cl:let ((__ros_str_len 0))
      (cl:setf (cl:ldb (cl:byte 8 0) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'message) (cl:make-string __ros_str_len))
      (cl:dotimes (__ros_str_idx __ros_str_len msg)
        (cl:setf (cl:char (cl:slot-value msg 'message) __ros_str_idx) (cl:code-char (cl:read-byte istream)))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<UninstallApp-response>)))
  "Returns string type for a service object of type '<UninstallApp-response>"
  "app_manager/UninstallAppResponse")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'UninstallApp-response)))
  "Returns string type for a service object of type 'UninstallApp-response"
  "app_manager/UninstallAppResponse")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<UninstallApp-response>)))
  "Returns md5sum for a message object of type '<UninstallApp-response>"
  "1694b710073aaad53ae6c852885793c6")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'UninstallApp-response)))
  "Returns md5sum for a message object of type 'UninstallApp-response"
  "1694b710073aaad53ae6c852885793c6")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<UninstallApp-response>)))
  "Returns full string definition for message of type '<UninstallApp-response>"
  (cl:format cl:nil "~%bool uninstalled~%string message~%~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'UninstallApp-response)))
  "Returns full string definition for message of type 'UninstallApp-response"
  (cl:format cl:nil "~%bool uninstalled~%string message~%~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <UninstallApp-response>))
  (cl:+ 0
     1
     4 (cl:length (cl:slot-value msg 'message))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <UninstallApp-response>))
  "Converts a ROS message object to a list"
  (cl:list 'UninstallApp-response
    (cl:cons ':uninstalled (uninstalled msg))
    (cl:cons ':message (message msg))
))
(cl:defmethod roslisp-msg-protocol:service-request-type ((msg (cl:eql 'UninstallApp)))
  'UninstallApp-request)
(cl:defmethod roslisp-msg-protocol:service-response-type ((msg (cl:eql 'UninstallApp)))
  'UninstallApp-response)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'UninstallApp)))
  "Returns string type for a service object of type '<UninstallApp>"
  "app_manager/UninstallApp")