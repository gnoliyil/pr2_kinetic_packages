; Auto-generated. Do not edit!


(cl:in-package app_manager-msg)


;//! \htmlinclude ClientApp.msg.html

(cl:defclass <ClientApp> (roslisp-msg-protocol:ros-message)
  ((client_type
    :reader client_type
    :initarg :client_type
    :type cl:string
    :initform "")
   (manager_data
    :reader manager_data
    :initarg :manager_data
    :type (cl:vector app_manager-msg:KeyValue)
   :initform (cl:make-array 0 :element-type 'app_manager-msg:KeyValue :initial-element (cl:make-instance 'app_manager-msg:KeyValue)))
   (app_data
    :reader app_data
    :initarg :app_data
    :type (cl:vector app_manager-msg:KeyValue)
   :initform (cl:make-array 0 :element-type 'app_manager-msg:KeyValue :initial-element (cl:make-instance 'app_manager-msg:KeyValue))))
)

(cl:defclass ClientApp (<ClientApp>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <ClientApp>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'ClientApp)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name app_manager-msg:<ClientApp> is deprecated: use app_manager-msg:ClientApp instead.")))

(cl:ensure-generic-function 'client_type-val :lambda-list '(m))
(cl:defmethod client_type-val ((m <ClientApp>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader app_manager-msg:client_type-val is deprecated.  Use app_manager-msg:client_type instead.")
  (client_type m))

(cl:ensure-generic-function 'manager_data-val :lambda-list '(m))
(cl:defmethod manager_data-val ((m <ClientApp>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader app_manager-msg:manager_data-val is deprecated.  Use app_manager-msg:manager_data instead.")
  (manager_data m))

(cl:ensure-generic-function 'app_data-val :lambda-list '(m))
(cl:defmethod app_data-val ((m <ClientApp>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader app_manager-msg:app_data-val is deprecated.  Use app_manager-msg:app_data instead.")
  (app_data m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <ClientApp>) ostream)
  "Serializes a message object of type '<ClientApp>"
  (cl:let ((__ros_str_len (cl:length (cl:slot-value msg 'client_type))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_str_len) ostream))
  (cl:map cl:nil #'(cl:lambda (c) (cl:write-byte (cl:char-code c) ostream)) (cl:slot-value msg 'client_type))
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'manager_data))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (roslisp-msg-protocol:serialize ele ostream))
   (cl:slot-value msg 'manager_data))
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'app_data))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (roslisp-msg-protocol:serialize ele ostream))
   (cl:slot-value msg 'app_data))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <ClientApp>) istream)
  "Deserializes a message object of type '<ClientApp>"
    (cl:let ((__ros_str_len 0))
      (cl:setf (cl:ldb (cl:byte 8 0) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'client_type) (cl:make-string __ros_str_len))
      (cl:dotimes (__ros_str_idx __ros_str_len msg)
        (cl:setf (cl:char (cl:slot-value msg 'client_type) __ros_str_idx) (cl:code-char (cl:read-byte istream)))))
  (cl:let ((__ros_arr_len 0))
    (cl:setf (cl:ldb (cl:byte 8 0) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) __ros_arr_len) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'manager_data) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'manager_data)))
    (cl:dotimes (i __ros_arr_len)
    (cl:setf (cl:aref vals i) (cl:make-instance 'app_manager-msg:KeyValue))
  (roslisp-msg-protocol:deserialize (cl:aref vals i) istream))))
  (cl:let ((__ros_arr_len 0))
    (cl:setf (cl:ldb (cl:byte 8 0) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) __ros_arr_len) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'app_data) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'app_data)))
    (cl:dotimes (i __ros_arr_len)
    (cl:setf (cl:aref vals i) (cl:make-instance 'app_manager-msg:KeyValue))
  (roslisp-msg-protocol:deserialize (cl:aref vals i) istream))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<ClientApp>)))
  "Returns string type for a message object of type '<ClientApp>"
  "app_manager/ClientApp")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'ClientApp)))
  "Returns string type for a message object of type 'ClientApp"
  "app_manager/ClientApp")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<ClientApp>)))
  "Returns md5sum for a message object of type '<ClientApp>"
  "0a8112672c3fbf73cb62ec78d67e41bb")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'ClientApp)))
  "Returns md5sum for a message object of type 'ClientApp"
  "0a8112672c3fbf73cb62ec78d67e41bb")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<ClientApp>)))
  "Returns full string definition for message of type '<ClientApp>"
  (cl:format cl:nil "# like \"android\" or \"web\" or \"linux\"~%string client_type~%~%# like \"intent = ros.android.teleop\" and \"accelerometer = true\", used to choose which ClientApp to use~%KeyValue[] manager_data~%~%# parameters which just get passed through to the client app.~%KeyValue[] app_data~%~%================================================================================~%MSG: app_manager/KeyValue~%string key~%string value~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'ClientApp)))
  "Returns full string definition for message of type 'ClientApp"
  (cl:format cl:nil "# like \"android\" or \"web\" or \"linux\"~%string client_type~%~%# like \"intent = ros.android.teleop\" and \"accelerometer = true\", used to choose which ClientApp to use~%KeyValue[] manager_data~%~%# parameters which just get passed through to the client app.~%KeyValue[] app_data~%~%================================================================================~%MSG: app_manager/KeyValue~%string key~%string value~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <ClientApp>))
  (cl:+ 0
     4 (cl:length (cl:slot-value msg 'client_type))
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'manager_data) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ (roslisp-msg-protocol:serialization-length ele))))
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'app_data) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ (roslisp-msg-protocol:serialization-length ele))))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <ClientApp>))
  "Converts a ROS message object to a list"
  (cl:list 'ClientApp
    (cl:cons ':client_type (client_type msg))
    (cl:cons ':manager_data (manager_data msg))
    (cl:cons ':app_data (app_data msg))
))
