; Auto-generated. Do not edit!


(cl:in-package app_manager-msg)


;//! \htmlinclude StatusCodes.msg.html

(cl:defclass <StatusCodes> (roslisp-msg-protocol:ros-message)
  ()
)

(cl:defclass StatusCodes (<StatusCodes>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <StatusCodes>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'StatusCodes)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name app_manager-msg:<StatusCodes> is deprecated: use app_manager-msg:StatusCodes instead.")))
(cl:defmethod roslisp-msg-protocol:symbol-codes ((msg-type (cl:eql '<StatusCodes>)))
    "Constants for message type '<StatusCodes>"
  '((:SUCCESS . 0)
    (:BAD_REQUEST . 400)
    (:NOT_FOUND . 404)
    (:NOT_RUNNING . 430)
    (:INTERNAL_ERROR . 500)
    (:APP_INVALID . 510)
    (:MULTIAPP_NOT_SUPPORTED . 511))
)
(cl:defmethod roslisp-msg-protocol:symbol-codes ((msg-type (cl:eql 'StatusCodes)))
    "Constants for message type 'StatusCodes"
  '((:SUCCESS . 0)
    (:BAD_REQUEST . 400)
    (:NOT_FOUND . 404)
    (:NOT_RUNNING . 430)
    (:INTERNAL_ERROR . 500)
    (:APP_INVALID . 510)
    (:MULTIAPP_NOT_SUPPORTED . 511))
)
(cl:defmethod roslisp-msg-protocol:serialize ((msg <StatusCodes>) ostream)
  "Serializes a message object of type '<StatusCodes>"
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <StatusCodes>) istream)
  "Deserializes a message object of type '<StatusCodes>"
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<StatusCodes>)))
  "Returns string type for a message object of type '<StatusCodes>"
  "app_manager/StatusCodes")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'StatusCodes)))
  "Returns string type for a message object of type 'StatusCodes"
  "app_manager/StatusCodes")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<StatusCodes>)))
  "Returns md5sum for a message object of type '<StatusCodes>"
  "5f286aed2b2ab4b227e7b7185bae624d")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'StatusCodes)))
  "Returns md5sum for a message object of type 'StatusCodes"
  "5f286aed2b2ab4b227e7b7185bae624d")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<StatusCodes>)))
  "Returns full string definition for message of type '<StatusCodes>"
  (cl:format cl:nil "# Common error codes used with App Manager.~%int32 SUCCESS = 0~%# Request was invalid.~%int32 BAD_REQUEST = 400~%# App is not installed.~%int32 NOT_FOUND = 404~%# App is not running.~%int32 NOT_RUNNING = 430~%# Unknown internal error on the server.~%int32 INTERNAL_ERROR = 500~%# App is installed but failed validation.~%int32 APP_INVALID = 510~%# App manager does not support launching multiple apps simultaneously. Running app must first be stopped.~%int32 MULTIAPP_NOT_SUPPORTED = 511~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'StatusCodes)))
  "Returns full string definition for message of type 'StatusCodes"
  (cl:format cl:nil "# Common error codes used with App Manager.~%int32 SUCCESS = 0~%# Request was invalid.~%int32 BAD_REQUEST = 400~%# App is not installed.~%int32 NOT_FOUND = 404~%# App is not running.~%int32 NOT_RUNNING = 430~%# Unknown internal error on the server.~%int32 INTERNAL_ERROR = 500~%# App is installed but failed validation.~%int32 APP_INVALID = 510~%# App manager does not support launching multiple apps simultaneously. Running app must first be stopped.~%int32 MULTIAPP_NOT_SUPPORTED = 511~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <StatusCodes>))
  (cl:+ 0
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <StatusCodes>))
  "Converts a ROS message object to a list"
  (cl:list 'StatusCodes
))
