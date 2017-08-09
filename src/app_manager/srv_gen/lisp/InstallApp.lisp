; Auto-generated. Do not edit!


(cl:in-package app_manager-srv)


;//! \htmlinclude InstallApp-request.msg.html

(cl:defclass <InstallApp-request> (roslisp-msg-protocol:ros-message)
  ((name
    :reader name
    :initarg :name
    :type cl:string
    :initform ""))
)

(cl:defclass InstallApp-request (<InstallApp-request>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <InstallApp-request>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'InstallApp-request)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name app_manager-srv:<InstallApp-request> is deprecated: use app_manager-srv:InstallApp-request instead.")))

(cl:ensure-generic-function 'name-val :lambda-list '(m))
(cl:defmethod name-val ((m <InstallApp-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader app_manager-srv:name-val is deprecated.  Use app_manager-srv:name instead.")
  (name m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <InstallApp-request>) ostream)
  "Serializes a message object of type '<InstallApp-request>"
  (cl:let ((__ros_str_len (cl:length (cl:slot-value msg 'name))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_str_len) ostream))
  (cl:map cl:nil #'(cl:lambda (c) (cl:write-byte (cl:char-code c) ostream)) (cl:slot-value msg 'name))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <InstallApp-request>) istream)
  "Deserializes a message object of type '<InstallApp-request>"
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
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<InstallApp-request>)))
  "Returns string type for a service object of type '<InstallApp-request>"
  "app_manager/InstallAppRequest")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'InstallApp-request)))
  "Returns string type for a service object of type 'InstallApp-request"
  "app_manager/InstallAppRequest")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<InstallApp-request>)))
  "Returns md5sum for a message object of type '<InstallApp-request>"
  "244a230f15ee33d3fe16b523058ae43f")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'InstallApp-request)))
  "Returns md5sum for a message object of type 'InstallApp-request"
  "244a230f15ee33d3fe16b523058ae43f")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<InstallApp-request>)))
  "Returns full string definition for message of type '<InstallApp-request>"
  (cl:format cl:nil "~%string name~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'InstallApp-request)))
  "Returns full string definition for message of type 'InstallApp-request"
  (cl:format cl:nil "~%string name~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <InstallApp-request>))
  (cl:+ 0
     4 (cl:length (cl:slot-value msg 'name))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <InstallApp-request>))
  "Converts a ROS message object to a list"
  (cl:list 'InstallApp-request
    (cl:cons ':name (name msg))
))
;//! \htmlinclude InstallApp-response.msg.html

(cl:defclass <InstallApp-response> (roslisp-msg-protocol:ros-message)
  ((installed
    :reader installed
    :initarg :installed
    :type cl:boolean
    :initform cl:nil)
   (message
    :reader message
    :initarg :message
    :type cl:string
    :initform ""))
)

(cl:defclass InstallApp-response (<InstallApp-response>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <InstallApp-response>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'InstallApp-response)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name app_manager-srv:<InstallApp-response> is deprecated: use app_manager-srv:InstallApp-response instead.")))

(cl:ensure-generic-function 'installed-val :lambda-list '(m))
(cl:defmethod installed-val ((m <InstallApp-response>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader app_manager-srv:installed-val is deprecated.  Use app_manager-srv:installed instead.")
  (installed m))

(cl:ensure-generic-function 'message-val :lambda-list '(m))
(cl:defmethod message-val ((m <InstallApp-response>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader app_manager-srv:message-val is deprecated.  Use app_manager-srv:message instead.")
  (message m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <InstallApp-response>) ostream)
  "Serializes a message object of type '<InstallApp-response>"
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'installed) 1 0)) ostream)
  (cl:let ((__ros_str_len (cl:length (cl:slot-value msg 'message))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_str_len) ostream))
  (cl:map cl:nil #'(cl:lambda (c) (cl:write-byte (cl:char-code c) ostream)) (cl:slot-value msg 'message))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <InstallApp-response>) istream)
  "Deserializes a message object of type '<InstallApp-response>"
    (cl:setf (cl:slot-value msg 'installed) (cl:not (cl:zerop (cl:read-byte istream))))
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
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<InstallApp-response>)))
  "Returns string type for a service object of type '<InstallApp-response>"
  "app_manager/InstallAppResponse")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'InstallApp-response)))
  "Returns string type for a service object of type 'InstallApp-response"
  "app_manager/InstallAppResponse")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<InstallApp-response>)))
  "Returns md5sum for a message object of type '<InstallApp-response>"
  "244a230f15ee33d3fe16b523058ae43f")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'InstallApp-response)))
  "Returns md5sum for a message object of type 'InstallApp-response"
  "244a230f15ee33d3fe16b523058ae43f")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<InstallApp-response>)))
  "Returns full string definition for message of type '<InstallApp-response>"
  (cl:format cl:nil "~%bool installed~%~%string message~%~%~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'InstallApp-response)))
  "Returns full string definition for message of type 'InstallApp-response"
  (cl:format cl:nil "~%bool installed~%~%string message~%~%~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <InstallApp-response>))
  (cl:+ 0
     1
     4 (cl:length (cl:slot-value msg 'message))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <InstallApp-response>))
  "Converts a ROS message object to a list"
  (cl:list 'InstallApp-response
    (cl:cons ':installed (installed msg))
    (cl:cons ':message (message msg))
))
(cl:defmethod roslisp-msg-protocol:service-request-type ((msg (cl:eql 'InstallApp)))
  'InstallApp-request)
(cl:defmethod roslisp-msg-protocol:service-response-type ((msg (cl:eql 'InstallApp)))
  'InstallApp-response)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'InstallApp)))
  "Returns string type for a service object of type '<InstallApp>"
  "app_manager/InstallApp")