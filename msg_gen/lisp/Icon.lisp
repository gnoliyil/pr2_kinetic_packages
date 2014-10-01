; Auto-generated. Do not edit!


(cl:in-package app_manager-msg)


;//! \htmlinclude Icon.msg.html

(cl:defclass <Icon> (roslisp-msg-protocol:ros-message)
  ((format
    :reader format
    :initarg :format
    :type cl:string
    :initform "")
   (data
    :reader data
    :initarg :data
    :type (cl:vector cl:fixnum)
   :initform (cl:make-array 0 :element-type 'cl:fixnum :initial-element 0)))
)

(cl:defclass Icon (<Icon>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <Icon>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'Icon)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name app_manager-msg:<Icon> is deprecated: use app_manager-msg:Icon instead.")))

(cl:ensure-generic-function 'format-val :lambda-list '(m))
(cl:defmethod format-val ((m <Icon>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader app_manager-msg:format-val is deprecated.  Use app_manager-msg:format instead.")
  (format m))

(cl:ensure-generic-function 'data-val :lambda-list '(m))
(cl:defmethod data-val ((m <Icon>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader app_manager-msg:data-val is deprecated.  Use app_manager-msg:data instead.")
  (data m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <Icon>) ostream)
  "Serializes a message object of type '<Icon>"
  (cl:let ((__ros_str_len (cl:length (cl:slot-value msg 'format))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_str_len) ostream))
  (cl:map cl:nil #'(cl:lambda (c) (cl:write-byte (cl:char-code c) ostream)) (cl:slot-value msg 'format))
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'data))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (cl:write-byte (cl:ldb (cl:byte 8 0) ele) ostream))
   (cl:slot-value msg 'data))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <Icon>) istream)
  "Deserializes a message object of type '<Icon>"
    (cl:let ((__ros_str_len 0))
      (cl:setf (cl:ldb (cl:byte 8 0) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'format) (cl:make-string __ros_str_len))
      (cl:dotimes (__ros_str_idx __ros_str_len msg)
        (cl:setf (cl:char (cl:slot-value msg 'format) __ros_str_idx) (cl:code-char (cl:read-byte istream)))))
  (cl:let ((__ros_arr_len 0))
    (cl:setf (cl:ldb (cl:byte 8 0) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) __ros_arr_len) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'data) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'data)))
    (cl:dotimes (i __ros_arr_len)
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:aref vals i)) (cl:read-byte istream)))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<Icon>)))
  "Returns string type for a message object of type '<Icon>"
  "app_manager/Icon")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'Icon)))
  "Returns string type for a message object of type 'Icon"
  "app_manager/Icon")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<Icon>)))
  "Returns md5sum for a message object of type '<Icon>"
  "e378a502c24c5aa2af7065d57c580d12")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'Icon)))
  "Returns md5sum for a message object of type 'Icon"
  "e378a502c24c5aa2af7065d57c580d12")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<Icon>)))
  "Returns full string definition for message of type '<Icon>"
  (cl:format cl:nil "# Image data format.  \"jpeg\" or \"png\"~%string format~%~%# Image data.~%uint8[] data~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'Icon)))
  "Returns full string definition for message of type 'Icon"
  (cl:format cl:nil "# Image data format.  \"jpeg\" or \"png\"~%string format~%~%# Image data.~%uint8[] data~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <Icon>))
  (cl:+ 0
     4 (cl:length (cl:slot-value msg 'format))
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'data) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ 1)))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <Icon>))
  "Converts a ROS message object to a list"
  (cl:list 'Icon
    (cl:cons ':format (format msg))
    (cl:cons ':data (data msg))
))
