; Auto-generated. Do not edit!


(cl:in-package app_manager-msg)


;//! \htmlinclude AppInstallationState.msg.html

(cl:defclass <AppInstallationState> (roslisp-msg-protocol:ros-message)
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

(cl:defclass AppInstallationState (<AppInstallationState>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <AppInstallationState>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'AppInstallationState)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name app_manager-msg:<AppInstallationState> is deprecated: use app_manager-msg:AppInstallationState instead.")))

(cl:ensure-generic-function 'installed_apps-val :lambda-list '(m))
(cl:defmethod installed_apps-val ((m <AppInstallationState>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader app_manager-msg:installed_apps-val is deprecated.  Use app_manager-msg:installed_apps instead.")
  (installed_apps m))

(cl:ensure-generic-function 'available_apps-val :lambda-list '(m))
(cl:defmethod available_apps-val ((m <AppInstallationState>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader app_manager-msg:available_apps-val is deprecated.  Use app_manager-msg:available_apps instead.")
  (available_apps m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <AppInstallationState>) ostream)
  "Serializes a message object of type '<AppInstallationState>"
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
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <AppInstallationState>) istream)
  "Deserializes a message object of type '<AppInstallationState>"
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
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<AppInstallationState>)))
  "Returns string type for a message object of type '<AppInstallationState>"
  "app_manager/AppInstallationState")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'AppInstallationState)))
  "Returns string type for a message object of type 'AppInstallationState"
  "app_manager/AppInstallationState")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<AppInstallationState>)))
  "Returns md5sum for a message object of type '<AppInstallationState>"
  "46d45bbda08250199267aff8c0ee8c41")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'AppInstallationState)))
  "Returns md5sum for a message object of type 'AppInstallationState"
  "46d45bbda08250199267aff8c0ee8c41")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<AppInstallationState>)))
  "Returns full string definition for message of type '<AppInstallationState>"
  (cl:format cl:nil "ExchangeApp[] installed_apps~%ExchangeApp[] available_apps~%~%================================================================================~%MSG: app_manager/ExchangeApp~%# app name~%string name~%# user-friendly display name of application~%string display_name~%# the version of the package currently installed~%string version~%# latest version of the package avaliable~%string latest_version~%# the detailed description of the app~%string description~%# icon for showing app~%Icon icon~%# hidden apps are not show - used for cases where multiple apps are in a deb~%bool hidden~%================================================================================~%MSG: app_manager/Icon~%# Image data format.  \"jpeg\" or \"png\"~%string format~%~%# Image data.~%uint8[] data~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'AppInstallationState)))
  "Returns full string definition for message of type 'AppInstallationState"
  (cl:format cl:nil "ExchangeApp[] installed_apps~%ExchangeApp[] available_apps~%~%================================================================================~%MSG: app_manager/ExchangeApp~%# app name~%string name~%# user-friendly display name of application~%string display_name~%# the version of the package currently installed~%string version~%# latest version of the package avaliable~%string latest_version~%# the detailed description of the app~%string description~%# icon for showing app~%Icon icon~%# hidden apps are not show - used for cases where multiple apps are in a deb~%bool hidden~%================================================================================~%MSG: app_manager/Icon~%# Image data format.  \"jpeg\" or \"png\"~%string format~%~%# Image data.~%uint8[] data~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <AppInstallationState>))
  (cl:+ 0
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'installed_apps) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ (roslisp-msg-protocol:serialization-length ele))))
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'available_apps) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ (roslisp-msg-protocol:serialization-length ele))))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <AppInstallationState>))
  "Converts a ROS message object to a list"
  (cl:list 'AppInstallationState
    (cl:cons ':installed_apps (installed_apps msg))
    (cl:cons ':available_apps (available_apps msg))
))
