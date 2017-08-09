; Auto-generated. Do not edit!


(cl:in-package app_manager-srv)


;//! \htmlinclude GetInstallationState-request.msg.html

(cl:defclass <GetInstallationState-request> (roslisp-msg-protocol:ros-message)
  ((remote_update
    :reader remote_update
    :initarg :remote_update
    :type cl:boolean
    :initform cl:nil))
)

(cl:defclass GetInstallationState-request (<GetInstallationState-request>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <GetInstallationState-request>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'GetInstallationState-request)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name app_manager-srv:<GetInstallationState-request> is deprecated: use app_manager-srv:GetInstallationState-request instead.")))

(cl:ensure-generic-function 'remote_update-val :lambda-list '(m))
(cl:defmethod remote_update-val ((m <GetInstallationState-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader app_manager-srv:remote_update-val is deprecated.  Use app_manager-srv:remote_update instead.")
  (remote_update m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <GetInstallationState-request>) ostream)
  "Serializes a message object of type '<GetInstallationState-request>"
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'remote_update) 1 0)) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <GetInstallationState-request>) istream)
  "Deserializes a message object of type '<GetInstallationState-request>"
    (cl:setf (cl:slot-value msg 'remote_update) (cl:not (cl:zerop (cl:read-byte istream))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<GetInstallationState-request>)))
  "Returns string type for a service object of type '<GetInstallationState-request>"
  "app_manager/GetInstallationStateRequest")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'GetInstallationState-request)))
  "Returns string type for a service object of type 'GetInstallationState-request"
  "app_manager/GetInstallationStateRequest")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<GetInstallationState-request>)))
  "Returns md5sum for a message object of type '<GetInstallationState-request>"
  "28f0a7294f6241e2423a9382e3c76987")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'GetInstallationState-request)))
  "Returns md5sum for a message object of type 'GetInstallationState-request"
  "28f0a7294f6241e2423a9382e3c76987")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<GetInstallationState-request>)))
  "Returns full string definition for message of type '<GetInstallationState-request>"
  (cl:format cl:nil "bool remote_update~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'GetInstallationState-request)))
  "Returns full string definition for message of type 'GetInstallationState-request"
  (cl:format cl:nil "bool remote_update~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <GetInstallationState-request>))
  (cl:+ 0
     1
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <GetInstallationState-request>))
  "Converts a ROS message object to a list"
  (cl:list 'GetInstallationState-request
    (cl:cons ':remote_update (remote_update msg))
))
;//! \htmlinclude GetInstallationState-response.msg.html

(cl:defclass <GetInstallationState-response> (roslisp-msg-protocol:ros-message)
  ((installed_apps
    :reader installed_apps
    :initarg :installed_apps
    :type (cl:vector app_manager-msg:ExchangeApp)
   :initform (cl:make-array 0 :element-type 'app_manager-msg:ExchangeApp :initial-element (cl:make-instance 'app_manager-msg:ExchangeApp)))
   (available_apps
    :reader available_apps
    :initarg :available_apps
    :type (cl:vector app_manager-msg:ExchangeApp)
   :initform (cl:make-array 0 :element-type 'app_manager-msg:ExchangeApp :initial-element (cl:make-instance 'app_manager-msg:ExchangeApp))))
)

(cl:defclass GetInstallationState-response (<GetInstallationState-response>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <GetInstallationState-response>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'GetInstallationState-response)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name app_manager-srv:<GetInstallationState-response> is deprecated: use app_manager-srv:GetInstallationState-response instead.")))

(cl:ensure-generic-function 'installed_apps-val :lambda-list '(m))
(cl:defmethod installed_apps-val ((m <GetInstallationState-response>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader app_manager-srv:installed_apps-val is deprecated.  Use app_manager-srv:installed_apps instead.")
  (installed_apps m))

(cl:ensure-generic-function 'available_apps-val :lambda-list '(m))
(cl:defmethod available_apps-val ((m <GetInstallationState-response>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader app_manager-srv:available_apps-val is deprecated.  Use app_manager-srv:available_apps instead.")
  (available_apps m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <GetInstallationState-response>) ostream)
  "Serializes a message object of type '<GetInstallationState-response>"
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'installed_apps))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (roslisp-msg-protocol:serialize ele ostream))
   (cl:slot-value msg 'installed_apps))
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'available_apps))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (roslisp-msg-protocol:serialize ele ostream))
   (cl:slot-value msg 'available_apps))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <GetInstallationState-response>) istream)
  "Deserializes a message object of type '<GetInstallationState-response>"
  (cl:let ((__ros_arr_len 0))
    (cl:setf (cl:ldb (cl:byte 8 0) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) __ros_arr_len) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'installed_apps) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'installed_apps)))
    (cl:dotimes (i __ros_arr_len)
    (cl:setf (cl:aref vals i) (cl:make-instance 'app_manager-msg:ExchangeApp))
  (roslisp-msg-protocol:deserialize (cl:aref vals i) istream))))
  (cl:let ((__ros_arr_len 0))
    (cl:setf (cl:ldb (cl:byte 8 0) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) __ros_arr_len) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'available_apps) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'available_apps)))
    (cl:dotimes (i __ros_arr_len)
    (cl:setf (cl:aref vals i) (cl:make-instance 'app_manager-msg:ExchangeApp))
  (roslisp-msg-protocol:deserialize (cl:aref vals i) istream))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<GetInstallationState-response>)))
  "Returns string type for a service object of type '<GetInstallationState-response>"
  "app_manager/GetInstallationStateResponse")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'GetInstallationState-response)))
  "Returns string type for a service object of type 'GetInstallationState-response"
  "app_manager/GetInstallationStateResponse")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<GetInstallationState-response>)))
  "Returns md5sum for a message object of type '<GetInstallationState-response>"
  "28f0a7294f6241e2423a9382e3c76987")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'GetInstallationState-response)))
  "Returns md5sum for a message object of type 'GetInstallationState-response"
  "28f0a7294f6241e2423a9382e3c76987")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<GetInstallationState-response>)))
  "Returns full string definition for message of type '<GetInstallationState-response>"
  (cl:format cl:nil "ExchangeApp[] installed_apps~%ExchangeApp[] available_apps~%~%================================================================================~%MSG: app_manager/ExchangeApp~%# app name~%string name~%# user-friendly display name of application~%string display_name~%# the version of the package currently installed~%string version~%# latest version of the package avaliable~%string latest_version~%# the detailed description of the app~%string description~%# icon for showing app~%Icon icon~%# hidden apps are not show - used for cases where multiple apps are in a deb~%bool hidden~%================================================================================~%MSG: app_manager/Icon~%# Image data format.  \"jpeg\" or \"png\"~%string format~%~%# Image data.~%uint8[] data~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'GetInstallationState-response)))
  "Returns full string definition for message of type 'GetInstallationState-response"
  (cl:format cl:nil "ExchangeApp[] installed_apps~%ExchangeApp[] available_apps~%~%================================================================================~%MSG: app_manager/ExchangeApp~%# app name~%string name~%# user-friendly display name of application~%string display_name~%# the version of the package currently installed~%string version~%# latest version of the package avaliable~%string latest_version~%# the detailed description of the app~%string description~%# icon for showing app~%Icon icon~%# hidden apps are not show - used for cases where multiple apps are in a deb~%bool hidden~%================================================================================~%MSG: app_manager/Icon~%# Image data format.  \"jpeg\" or \"png\"~%string format~%~%# Image data.~%uint8[] data~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <GetInstallationState-response>))
  (cl:+ 0
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'installed_apps) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ (roslisp-msg-protocol:serialization-length ele))))
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'available_apps) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ (roslisp-msg-protocol:serialization-length ele))))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <GetInstallationState-response>))
  "Converts a ROS message object to a list"
  (cl:list 'GetInstallationState-response
    (cl:cons ':installed_apps (installed_apps msg))
    (cl:cons ':available_apps (available_apps msg))
))
(cl:defmethod roslisp-msg-protocol:service-request-type ((msg (cl:eql 'GetInstallationState)))
  'GetInstallationState-request)
(cl:defmethod roslisp-msg-protocol:service-response-type ((msg (cl:eql 'GetInstallationState)))
  'GetInstallationState-response)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'GetInstallationState)))
  "Returns string type for a service object of type '<GetInstallationState>"
  "app_manager/GetInstallationState")