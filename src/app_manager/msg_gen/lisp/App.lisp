; Auto-generated. Do not edit!


(cl:in-package app_manager-msg)


;//! \htmlinclude App.msg.html

(cl:defclass <App> (roslisp-msg-protocol:ros-message)
  ((name
    :reader name
    :initarg :name
    :type cl:string
    :initform "")
   (display_name
    :reader display_name
    :initarg :display_name
    :type cl:string
    :initform "")
   (icon
    :reader icon
    :initarg :icon
    :type app_manager-msg:Icon
    :initform (cl:make-instance 'app_manager-msg:Icon))
   (client_apps
    :reader client_apps
    :initarg :client_apps
    :type (cl:vector app_manager-msg:ClientApp)
   :initform (cl:make-array 0 :element-type 'app_manager-msg:ClientApp :initial-element (cl:make-instance 'app_manager-msg:ClientApp))))
)

(cl:defclass App (<App>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <App>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'App)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name app_manager-msg:<App> is deprecated: use app_manager-msg:App instead.")))

(cl:ensure-generic-function 'name-val :lambda-list '(m))
(cl:defmethod name-val ((m <App>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader app_manager-msg:name-val is deprecated.  Use app_manager-msg:name instead.")
  (name m))

(cl:ensure-generic-function 'display_name-val :lambda-list '(m))
(cl:defmethod display_name-val ((m <App>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader app_manager-msg:display_name-val is deprecated.  Use app_manager-msg:display_name instead.")
  (display_name m))

(cl:ensure-generic-function 'icon-val :lambda-list '(m))
(cl:defmethod icon-val ((m <App>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader app_manager-msg:icon-val is deprecated.  Use app_manager-msg:icon instead.")
  (icon m))

(cl:ensure-generic-function 'client_apps-val :lambda-list '(m))
(cl:defmethod client_apps-val ((m <App>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader app_manager-msg:client_apps-val is deprecated.  Use app_manager-msg:client_apps instead.")
  (client_apps m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <App>) ostream)
  "Serializes a message object of type '<App>"
  (cl:let ((__ros_str_len (cl:length (cl:slot-value msg 'name))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_str_len) ostream))
  (cl:map cl:nil #'(cl:lambda (c) (cl:write-byte (cl:char-code c) ostream)) (cl:slot-value msg 'name))
  (cl:let ((__ros_str_len (cl:length (cl:slot-value msg 'display_name))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_str_len) ostream))
  (cl:map cl:nil #'(cl:lambda (c) (cl:write-byte (cl:char-code c) ostream)) (cl:slot-value msg 'display_name))
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'icon) ostream)
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'client_apps))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (roslisp-msg-protocol:serialize ele ostream))
   (cl:slot-value msg 'client_apps))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <App>) istream)
  "Deserializes a message object of type '<App>"
    (cl:let ((__ros_str_len 0))
      (cl:setf (cl:ldb (cl:byte 8 0) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'name) (cl:make-string __ros_str_len))
      (cl:dotimes (__ros_str_idx __ros_str_len msg)
        (cl:setf (cl:char (cl:slot-value msg 'name) __ros_str_idx) (cl:code-char (cl:read-byte istream)))))
    (cl:let ((__ros_str_len 0))
      (cl:setf (cl:ldb (cl:byte 8 0) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'display_name) (cl:make-string __ros_str_len))
      (cl:dotimes (__ros_str_idx __ros_str_len msg)
        (cl:setf (cl:char (cl:slot-value msg 'display_name) __ros_str_idx) (cl:code-char (cl:read-byte istream)))))
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'icon) istream)
  (cl:let ((__ros_arr_len 0))
    (cl:setf (cl:ldb (cl:byte 8 0) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) __ros_arr_len) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'client_apps) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'client_apps)))
    (cl:dotimes (i __ros_arr_len)
    (cl:setf (cl:aref vals i) (cl:make-instance 'app_manager-msg:ClientApp))
  (roslisp-msg-protocol:deserialize (cl:aref vals i) istream))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<App>)))
  "Returns string type for a message object of type '<App>"
  "app_manager/App")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'App)))
  "Returns string type for a message object of type 'App"
  "app_manager/App")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<App>)))
  "Returns md5sum for a message object of type '<App>"
  "643c1db5f71b615a47789ff5e190811e")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'App)))
  "Returns md5sum for a message object of type 'App"
  "643c1db5f71b615a47789ff5e190811e")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<App>)))
  "Returns full string definition for message of type '<App>"
  (cl:format cl:nil "# app name~%string name~%# user-friendly display name of application~%string display_name~%# icon for showing app~%Icon icon~%# ordered list (by preference) of client applications to interact with this robot app.  ~%ClientApp[] client_apps~%~%================================================================================~%MSG: app_manager/Icon~%# Image data format.  \"jpeg\" or \"png\"~%string format~%~%# Image data.~%uint8[] data~%~%================================================================================~%MSG: app_manager/ClientApp~%# like \"android\" or \"web\" or \"linux\"~%string client_type~%~%# like \"intent = ros.android.teleop\" and \"accelerometer = true\", used to choose which ClientApp to use~%KeyValue[] manager_data~%~%# parameters which just get passed through to the client app.~%KeyValue[] app_data~%~%================================================================================~%MSG: app_manager/KeyValue~%string key~%string value~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'App)))
  "Returns full string definition for message of type 'App"
  (cl:format cl:nil "# app name~%string name~%# user-friendly display name of application~%string display_name~%# icon for showing app~%Icon icon~%# ordered list (by preference) of client applications to interact with this robot app.  ~%ClientApp[] client_apps~%~%================================================================================~%MSG: app_manager/Icon~%# Image data format.  \"jpeg\" or \"png\"~%string format~%~%# Image data.~%uint8[] data~%~%================================================================================~%MSG: app_manager/ClientApp~%# like \"android\" or \"web\" or \"linux\"~%string client_type~%~%# like \"intent = ros.android.teleop\" and \"accelerometer = true\", used to choose which ClientApp to use~%KeyValue[] manager_data~%~%# parameters which just get passed through to the client app.~%KeyValue[] app_data~%~%================================================================================~%MSG: app_manager/KeyValue~%string key~%string value~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <App>))
  (cl:+ 0
     4 (cl:length (cl:slot-value msg 'name))
     4 (cl:length (cl:slot-value msg 'display_name))
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'icon))
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'client_apps) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ (roslisp-msg-protocol:serialization-length ele))))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <App>))
  "Converts a ROS message object to a list"
  (cl:list 'App
    (cl:cons ':name (name msg))
    (cl:cons ':display_name (display_name msg))
    (cl:cons ':icon (icon msg))
    (cl:cons ':client_apps (client_apps msg))
))
