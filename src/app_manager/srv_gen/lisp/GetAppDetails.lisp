; Auto-generated. Do not edit!


(cl:in-package app_manager-srv)


;//! \htmlinclude GetAppDetails-request.msg.html

(cl:defclass <GetAppDetails-request> (roslisp-msg-protocol:ros-message)
  ((name
    :reader name
    :initarg :name
    :type cl:string
    :initform ""))
)

(cl:defclass GetAppDetails-request (<GetAppDetails-request>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <GetAppDetails-request>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'GetAppDetails-request)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name app_manager-srv:<GetAppDetails-request> is deprecated: use app_manager-srv:GetAppDetails-request instead.")))

(cl:ensure-generic-function 'name-val :lambda-list '(m))
(cl:defmethod name-val ((m <GetAppDetails-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader app_manager-srv:name-val is deprecated.  Use app_manager-srv:name instead.")
  (name m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <GetAppDetails-request>) ostream)
  "Serializes a message object of type '<GetAppDetails-request>"
  (cl:let ((__ros_str_len (cl:length (cl:slot-value msg 'name))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_str_len) ostream))
  (cl:map cl:nil #'(cl:lambda (c) (cl:write-byte (cl:char-code c) ostream)) (cl:slot-value msg 'name))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <GetAppDetails-request>) istream)
  "Deserializes a message object of type '<GetAppDetails-request>"
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
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<GetAppDetails-request>)))
  "Returns string type for a service object of type '<GetAppDetails-request>"
  "app_manager/GetAppDetailsRequest")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'GetAppDetails-request)))
  "Returns string type for a service object of type 'GetAppDetails-request"
  "app_manager/GetAppDetailsRequest")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<GetAppDetails-request>)))
  "Returns md5sum for a message object of type '<GetAppDetails-request>"
  "982707be65dd9bb38c19f6e18cb18db5")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'GetAppDetails-request)))
  "Returns md5sum for a message object of type 'GetAppDetails-request"
  "982707be65dd9bb38c19f6e18cb18db5")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<GetAppDetails-request>)))
  "Returns full string definition for message of type '<GetAppDetails-request>"
  (cl:format cl:nil "~%string name~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'GetAppDetails-request)))
  "Returns full string definition for message of type 'GetAppDetails-request"
  (cl:format cl:nil "~%string name~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <GetAppDetails-request>))
  (cl:+ 0
     4 (cl:length (cl:slot-value msg 'name))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <GetAppDetails-request>))
  "Converts a ROS message object to a list"
  (cl:list 'GetAppDetails-request
    (cl:cons ':name (name msg))
))
;//! \htmlinclude GetAppDetails-response.msg.html

(cl:defclass <GetAppDetails-response> (roslisp-msg-protocol:ros-message)
  ((app
    :reader app
    :initarg :app
    :type app_manager-msg:ExchangeApp
    :initform (cl:make-instance 'app_manager-msg:ExchangeApp)))
)

(cl:defclass GetAppDetails-response (<GetAppDetails-response>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <GetAppDetails-response>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'GetAppDetails-response)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name app_manager-srv:<GetAppDetails-response> is deprecated: use app_manager-srv:GetAppDetails-response instead.")))

(cl:ensure-generic-function 'app-val :lambda-list '(m))
(cl:defmethod app-val ((m <GetAppDetails-response>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader app_manager-srv:app-val is deprecated.  Use app_manager-srv:app instead.")
  (app m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <GetAppDetails-response>) ostream)
  "Serializes a message object of type '<GetAppDetails-response>"
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'app) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <GetAppDetails-response>) istream)
  "Deserializes a message object of type '<GetAppDetails-response>"
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'app) istream)
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<GetAppDetails-response>)))
  "Returns string type for a service object of type '<GetAppDetails-response>"
  "app_manager/GetAppDetailsResponse")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'GetAppDetails-response)))
  "Returns string type for a service object of type 'GetAppDetails-response"
  "app_manager/GetAppDetailsResponse")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<GetAppDetails-response>)))
  "Returns md5sum for a message object of type '<GetAppDetails-response>"
  "982707be65dd9bb38c19f6e18cb18db5")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'GetAppDetails-response)))
  "Returns md5sum for a message object of type 'GetAppDetails-response"
  "982707be65dd9bb38c19f6e18cb18db5")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<GetAppDetails-response>)))
  "Returns full string definition for message of type '<GetAppDetails-response>"
  (cl:format cl:nil "ExchangeApp app~%~%~%~%================================================================================~%MSG: app_manager/ExchangeApp~%# app name~%string name~%# user-friendly display name of application~%string display_name~%# the version of the package currently installed~%string version~%# latest version of the package avaliable~%string latest_version~%# the detailed description of the app~%string description~%# icon for showing app~%Icon icon~%# hidden apps are not show - used for cases where multiple apps are in a deb~%bool hidden~%================================================================================~%MSG: app_manager/Icon~%# Image data format.  \"jpeg\" or \"png\"~%string format~%~%# Image data.~%uint8[] data~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'GetAppDetails-response)))
  "Returns full string definition for message of type 'GetAppDetails-response"
  (cl:format cl:nil "ExchangeApp app~%~%~%~%================================================================================~%MSG: app_manager/ExchangeApp~%# app name~%string name~%# user-friendly display name of application~%string display_name~%# the version of the package currently installed~%string version~%# latest version of the package avaliable~%string latest_version~%# the detailed description of the app~%string description~%# icon for showing app~%Icon icon~%# hidden apps are not show - used for cases where multiple apps are in a deb~%bool hidden~%================================================================================~%MSG: app_manager/Icon~%# Image data format.  \"jpeg\" or \"png\"~%string format~%~%# Image data.~%uint8[] data~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <GetAppDetails-response>))
  (cl:+ 0
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'app))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <GetAppDetails-response>))
  "Converts a ROS message object to a list"
  (cl:list 'GetAppDetails-response
    (cl:cons ':app (app msg))
))
(cl:defmethod roslisp-msg-protocol:service-request-type ((msg (cl:eql 'GetAppDetails)))
  'GetAppDetails-request)
(cl:defmethod roslisp-msg-protocol:service-response-type ((msg (cl:eql 'GetAppDetails)))
  'GetAppDetails-response)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'GetAppDetails)))
  "Returns string type for a service object of type '<GetAppDetails>"
  "app_manager/GetAppDetails")