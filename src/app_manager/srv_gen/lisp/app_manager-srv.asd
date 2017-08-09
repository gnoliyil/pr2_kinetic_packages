
(cl:in-package :asdf)

(defsystem "app_manager-srv"
  :depends-on (:roslisp-msg-protocol :roslisp-utils :app_manager-msg
)
  :components ((:file "_package")
    (:file "InstallApp" :depends-on ("_package_InstallApp"))
    (:file "_package_InstallApp" :depends-on ("_package"))
    (:file "UninstallApp" :depends-on ("_package_UninstallApp"))
    (:file "_package_UninstallApp" :depends-on ("_package"))
    (:file "StopApp" :depends-on ("_package_StopApp"))
    (:file "_package_StopApp" :depends-on ("_package"))
    (:file "ListApps" :depends-on ("_package_ListApps"))
    (:file "_package_ListApps" :depends-on ("_package"))
    (:file "StartApp" :depends-on ("_package_StartApp"))
    (:file "_package_StartApp" :depends-on ("_package"))
    (:file "GetAppDetails" :depends-on ("_package_GetAppDetails"))
    (:file "_package_GetAppDetails" :depends-on ("_package"))
    (:file "GetInstallationState" :depends-on ("_package_GetInstallationState"))
    (:file "_package_GetInstallationState" :depends-on ("_package"))
  ))