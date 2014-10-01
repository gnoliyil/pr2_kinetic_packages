; Auto-generated. Do not edit!


(cl:in-package app_manager-msg)


;//! \htmlinclude AppStatus.msg.html

(cl:defclass <AppStatus> (roslisp-msg-protocol:ros-message)
  ((type
    :reader type
    :initarg :type
    :type cl:integer
    :initform 0)
   (status
    :reader status
    :initarg :status
    :type cl:string
    :initform ""))
)

(cl:defclass AppStatus (<AppStatus>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <AppStatus>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'AppStatus)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name app_manager-msg:<AppStatus> is deprecated: use app_manager-msg:AppStatus instead.")))

(cl:ensure-generic-function 'type-val :lambda-list '(m))
(cl:defmethod type-val ((m <AppStatus>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader app_manager-msg:type-val is deprecated.  Use app_manager-msg:type instead.")
  (type m))

(cl:ensure-generic-function 'status-val :lambda-list '(m))
(cl:defmethod status-val ((m <AppStatus>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader app_manager-msg:status-val is deprecated.  Use app_manager-msg:status instead.")
  (status m))
(cl:defmethod roslisp-msg-protocol:symbol-codes ((msg-type (cl:eql '<AppStatus>)))
    "Constants for message type '<AppStatus>"
  '((:INFO . 0)
    (:WARN . 1)
    (:ERROR . 2))
)
(cl:defmethod roslisp-msg-protocol:symbol-codes ((msg-type (cl:eql 'AppStatus)))
    "Constants for message type 'AppStatus"
  '((:INFO . 0)
    (:WARN . 1)
    (:ERROR . 2))
)
(cl:defmethod roslisp-msg-protocol:serialize ((msg <AppStatus>) ostream)
  "Serializes a message object of type '<AppStatus>"
  (cl:let* ((signed (cl:slot-value msg 'type)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 4294967296) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    )
  (cl:let ((__ros_str_len (cl:length (cl:slot-value msg 'status))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_str_len) ostream))
  (cl:map cl:nil #'(cl:lambda (c) (cl:write-byte (cl:char-code c) ostream)) (cl:slot-value msg 'status))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <AppStatus>) istream)
  "Deserializes a message object of type '<AppStatus>"
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'type) (cl:if (cl:< unsigned 2147483648) unsigned (cl:- unsigned 4294967296))))
    (cl:let ((__ros_str_len 0))
      (cl:setf (cl:ldb (cl:byte 8 0) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'status) (cl:make-string __ros_str_len))
      (cl:dotimes (__ros_str_idx __ros_str_len msg)
        (cl:setf (cl:char (cl:slot-value msg 'status) __ros_str_idx) (cl:code-char (cl:read-byte istream)))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<AppStatus>)))
  "Returns string type for a message object of type '<AppStatus>"
  "app_manager/AppStatus")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'AppStatus)))
  "Returns string type for a message object of type 'AppStatus"
  "app_manager/AppStatus")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<AppStatus>)))
  "Returns md5sum for a message object of type '<AppStatus>"
  "4f59466d6810d5e9557e6b8ff75c9437")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'AppStatus)))
  "Returns md5sum for a message object of type 'AppStatus"
  "4f59466d6810d5e9557e6b8ff75c9437")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<AppStatus>)))
  "Returns full string definition for message of type '<AppStatus>"
  (cl:format cl:nil "int32 INFO=0~%int32 WARN=1~%int32 ERROR=2~%# Status type.  One of INFO, WARN, ERROR.~%int32 type~%# Status message.~%string status~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'AppStatus)))
  "Returns full string definition for message of type 'AppStatus"
  (cl:format cl:nil "int32 INFO=0~%int32 WARN=1~%int32 ERROR=2~%# Status type.  One of INFO, WARN, ERROR.~%int32 type~%# Status message.~%string status~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <AppStatus>))
  (cl:+ 0
     4
     4 (cl:length (cl:slot-value msg 'status))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <AppStatus>))
  "Converts a ROS message object to a list"
  (cl:list 'AppStatus
    (cl:cons ':type (type msg))
    (cl:cons ':status (status msg))
))
