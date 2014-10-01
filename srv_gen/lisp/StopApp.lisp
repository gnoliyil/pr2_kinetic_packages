; Auto-generated. Do not edit!


(cl:in-package app_manager-srv)


;//! \htmlinclude StopApp-request.msg.html

(cl:defclass <StopApp-request> (roslisp-msg-protocol:ros-message)
  ((name
    :reader name
    :initarg :name
    :type cl:string
    :initform ""))
)

(cl:defclass StopApp-request (<StopApp-request>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <StopApp-request>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'StopApp-request)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name app_manager-srv:<StopApp-request> is deprecated: use app_manager-srv:StopApp-request instead.")))

(cl:ensure-generic-function 'name-val :lambda-list '(m))
(cl:defmethod name-val ((m <StopApp-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader app_manager-srv:name-val is deprecated.  Use app_manager-srv:name instead.")
  (name m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <StopApp-request>) ostream)
  "Serializes a message object of type '<StopApp-request>"
  (cl:let ((__ros_str_len (cl:length (cl:slot-value msg 'name))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_str_len) ostream))
  (cl:map cl:nil #'(cl:lambda (c) (cl:write-byte (cl:char-code c) ostream)) (cl:slot-value msg 'name))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <StopApp-request>) istream)
  "Deserializes a message object of type '<StopApp-request>"
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
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<StopApp-request>)))
  "Returns string type for a service object of type '<StopApp-request>"
  "app_manager/StopAppRequest")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'StopApp-request)))
  "Returns string type for a service object of type 'StopApp-request"
  "app_manager/StopAppRequest")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<StopApp-request>)))
  "Returns md5sum for a message object of type '<StopApp-request>"
  "57711838d4a1faddc5043a742845018b")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'StopApp-request)))
  "Returns md5sum for a message object of type 'StopApp-request"
  "57711838d4a1faddc5043a742845018b")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<StopApp-request>)))
  "Returns full string definition for message of type '<StopApp-request>"
  (cl:format cl:nil "~%string name~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'StopApp-request)))
  "Returns full string definition for message of type 'StopApp-request"
  (cl:format cl:nil "~%string name~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <StopApp-request>))
  (cl:+ 0
     4 (cl:length (cl:slot-value msg 'name))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <StopApp-request>))
  "Converts a ROS message object to a list"
  (cl:list 'StopApp-request
    (cl:cons ':name (name msg))
))
;//! \htmlinclude StopApp-response.msg.html

(cl:defclass <StopApp-response> (roslisp-msg-protocol:ros-message)
  ((stopped
    :reader stopped
    :initarg :stopped
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
    :initform ""))
)

(cl:defclass StopApp-response (<StopApp-response>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <StopApp-response>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'StopApp-response)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name app_manager-srv:<StopApp-response> is deprecated: use app_manager-srv:StopApp-response instead.")))

(cl:ensure-generic-function 'stopped-val :lambda-list '(m))
(cl:defmethod stopped-val ((m <StopApp-response>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader app_manager-srv:stopped-val is deprecated.  Use app_manager-srv:stopped instead.")
  (stopped m))

(cl:ensure-generic-function 'error_code-val :lambda-list '(m))
(cl:defmethod error_code-val ((m <StopApp-response>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader app_manager-srv:error_code-val is deprecated.  Use app_manager-srv:error_code instead.")
  (error_code m))

(cl:ensure-generic-function 'message-val :lambda-list '(m))
(cl:defmethod message-val ((m <StopApp-response>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader app_manager-srv:message-val is deprecated.  Use app_manager-srv:message instead.")
  (message m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <StopApp-response>) ostream)
  "Serializes a message object of type '<StopApp-response>"
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'stopped) 1 0)) ostream)
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
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <StopApp-response>) istream)
  "Deserializes a message object of type '<StopApp-response>"
    (cl:setf (cl:slot-value msg 'stopped) (cl:not (cl:zerop (cl:read-byte istream))))
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
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<StopApp-response>)))
  "Returns string type for a service object of type '<StopApp-response>"
  "app_manager/StopAppResponse")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'StopApp-response)))
  "Returns string type for a service object of type 'StopApp-response"
  "app_manager/StopAppResponse")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<StopApp-response>)))
  "Returns md5sum for a message object of type '<StopApp-response>"
  "57711838d4a1faddc5043a742845018b")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'StopApp-response)))
  "Returns md5sum for a message object of type 'StopApp-response"
  "57711838d4a1faddc5043a742845018b")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<StopApp-response>)))
  "Returns full string definition for message of type '<StopApp-response>"
  (cl:format cl:nil "~%bool stopped~%~%~%int32 error_code~%string message~%~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'StopApp-response)))
  "Returns full string definition for message of type 'StopApp-response"
  (cl:format cl:nil "~%bool stopped~%~%~%int32 error_code~%string message~%~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <StopApp-response>))
  (cl:+ 0
     1
     4
     4 (cl:length (cl:slot-value msg 'message))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <StopApp-response>))
  "Converts a ROS message object to a list"
  (cl:list 'StopApp-response
    (cl:cons ':stopped (stopped msg))
    (cl:cons ':error_code (error_code msg))
    (cl:cons ':message (message msg))
))
(cl:defmethod roslisp-msg-protocol:service-request-type ((msg (cl:eql 'StopApp)))
  'StopApp-request)
(cl:defmethod roslisp-msg-protocol:service-response-type ((msg (cl:eql 'StopApp)))
  'StopApp-response)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'StopApp)))
  "Returns string type for a service object of type '<StopApp>"
  "app_manager/StopApp")