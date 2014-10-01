; Auto-generated. Do not edit!


(cl:in-package app_manager-srv)


;//! \htmlinclude ListApps-request.msg.html

(cl:defclass <ListApps-request> (roslisp-msg-protocol:ros-message)
  ()
)

(cl:defclass ListApps-request (<ListApps-request>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <ListApps-request>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'ListApps-request)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name app_manager-srv:<ListApps-request> is deprecated: use app_manager-srv:ListApps-request instead.")))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <ListApps-request>) ostream)
  "Serializes a message object of type '<ListApps-request>"
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <ListApps-request>) istream)
  "Deserializes a message object of type '<ListApps-request>"
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<ListApps-request>)))
  "Returns string type for a service object of type '<ListApps-request>"
  "app_manager/ListAppsRequest")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'ListApps-request)))
  "Returns string type for a service object of type 'ListApps-request"
  "app_manager/ListAppsRequest")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<ListApps-request>)))
  "Returns md5sum for a message object of type '<ListApps-request>"
  "8a71ede6bf51909653c7c551f462cb30")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'ListApps-request)))
  "Returns md5sum for a message object of type 'ListApps-request"
  "8a71ede6bf51909653c7c551f462cb30")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<ListApps-request>)))
  "Returns full string definition for message of type '<ListApps-request>"
  (cl:format cl:nil "~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'ListApps-request)))
  "Returns full string definition for message of type 'ListApps-request"
  (cl:format cl:nil "~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <ListApps-request>))
  (cl:+ 0
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <ListApps-request>))
  "Converts a ROS message object to a list"
  (cl:list 'ListApps-request
))
;//! \htmlinclude ListApps-response.msg.html

(cl:defclass <ListApps-response> (roslisp-msg-protocol:ros-message)
  ((running_apps
    :reader running_apps
    :initarg :running_apps
    :type (cl:vector app_manager-msg:App)
   :initform (cl:make-array 0 :element-type 'app_manager-msg:App :initial-element (cl:make-instance 'app_manager-msg:App)))
   (available_apps
    :reader available_apps
    :initarg :available_apps
    :type (cl:vector app_manager-msg:App)
   :initform (cl:make-array 0 :element-type 'app_manager-msg:App :initial-element (cl:make-instance 'app_manager-msg:App))))
)

(cl:defclass ListApps-response (<ListApps-response>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <ListApps-response>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'ListApps-response)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name app_manager-srv:<ListApps-response> is deprecated: use app_manager-srv:ListApps-response instead.")))

(cl:ensure-generic-function 'running_apps-val :lambda-list '(m))
(cl:defmethod running_apps-val ((m <ListApps-response>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader app_manager-srv:running_apps-val is deprecated.  Use app_manager-srv:running_apps instead.")
  (running_apps m))

(cl:ensure-generic-function 'available_apps-val :lambda-list '(m))
(cl:defmethod available_apps-val ((m <ListApps-response>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader app_manager-srv:available_apps-val is deprecated.  Use app_manager-srv:available_apps instead.")
  (available_apps m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <ListApps-response>) ostream)
  "Serializes a message object of type '<ListApps-response>"
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'running_apps))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (roslisp-msg-protocol:serialize ele ostream))
   (cl:slot-value msg 'running_apps))
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'available_apps))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (roslisp-msg-protocol:serialize ele ostream))
   (cl:slot-value msg 'available_apps))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <ListApps-response>) istream)
  "Deserializes a message object of type '<ListApps-response>"
  (cl:let ((__ros_arr_len 0))
    (cl:setf (cl:ldb (cl:byte 8 0) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) __ros_arr_len) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'running_apps) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'running_apps)))
    (cl:dotimes (i __ros_arr_len)
    (cl:setf (cl:aref vals i) (cl:make-instance 'app_manager-msg:App))
  (roslisp-msg-protocol:deserialize (cl:aref vals i) istream))))
  (cl:let ((__ros_arr_len 0))
    (cl:setf (cl:ldb (cl:byte 8 0) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) __ros_arr_len) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'available_apps) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'available_apps)))
    (cl:dotimes (i __ros_arr_len)
    (cl:setf (cl:aref vals i) (cl:make-instance 'app_manager-msg:App))
  (roslisp-msg-protocol:deserialize (cl:aref vals i) istream))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<ListApps-response>)))
  "Returns string type for a service object of type '<ListApps-response>"
  "app_manager/ListAppsResponse")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'ListApps-response)))
  "Returns string type for a service object of type 'ListApps-response"
  "app_manager/ListAppsResponse")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<ListApps-response>)))
  "Returns md5sum for a message object of type '<ListApps-response>"
  "8a71ede6bf51909653c7c551f462cb30")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'ListApps-response)))
  "Returns md5sum for a message object of type 'ListApps-response"
  "8a71ede6bf51909653c7c551f462cb30")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<ListApps-response>)))
  "Returns full string definition for message of type '<ListApps-response>"
  (cl:format cl:nil "App[] running_apps~%App[] available_apps~%~%================================================================================~%MSG: app_manager/App~%# app name~%string name~%# user-friendly display name of application~%string display_name~%# icon for showing app~%Icon icon~%# ordered list (by preference) of client applications to interact with this robot app.  ~%ClientApp[] client_apps~%~%================================================================================~%MSG: app_manager/Icon~%# Image data format.  \"jpeg\" or \"png\"~%string format~%~%# Image data.~%uint8[] data~%~%================================================================================~%MSG: app_manager/ClientApp~%# like \"android\" or \"web\" or \"linux\"~%string client_type~%~%# like \"intent = ros.android.teleop\" and \"accelerometer = true\", used to choose which ClientApp to use~%KeyValue[] manager_data~%~%# parameters which just get passed through to the client app.~%KeyValue[] app_data~%~%================================================================================~%MSG: app_manager/KeyValue~%string key~%string value~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'ListApps-response)))
  "Returns full string definition for message of type 'ListApps-response"
  (cl:format cl:nil "App[] running_apps~%App[] available_apps~%~%================================================================================~%MSG: app_manager/App~%# app name~%string name~%# user-friendly display name of application~%string display_name~%# icon for showing app~%Icon icon~%# ordered list (by preference) of client applications to interact with this robot app.  ~%ClientApp[] client_apps~%~%================================================================================~%MSG: app_manager/Icon~%# Image data format.  \"jpeg\" or \"png\"~%string format~%~%# Image data.~%uint8[] data~%~%================================================================================~%MSG: app_manager/ClientApp~%# like \"android\" or \"web\" or \"linux\"~%string client_type~%~%# like \"intent = ros.android.teleop\" and \"accelerometer = true\", used to choose which ClientApp to use~%KeyValue[] manager_data~%~%# parameters which just get passed through to the client app.~%KeyValue[] app_data~%~%================================================================================~%MSG: app_manager/KeyValue~%string key~%string value~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <ListApps-response>))
  (cl:+ 0
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'running_apps) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ (roslisp-msg-protocol:serialization-length ele))))
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'available_apps) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ (roslisp-msg-protocol:serialization-length ele))))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <ListApps-response>))
  "Converts a ROS message object to a list"
  (cl:list 'ListApps-response
    (cl:cons ':running_apps (running_apps msg))
    (cl:cons ':available_apps (available_apps msg))
))
(cl:defmethod roslisp-msg-protocol:service-request-type ((msg (cl:eql 'ListApps)))
  'ListApps-request)
(cl:defmethod roslisp-msg-protocol:service-response-type ((msg (cl:eql 'ListApps)))
  'ListApps-response)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'ListApps)))
  "Returns string type for a service object of type '<ListApps>"
  "app_manager/ListApps")