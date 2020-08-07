# generated from genmsg/cmake/pkg-genmsg.cmake.em

message(STATUS "boat: 2 messages, 0 services")

set(MSG_I_FLAGS "-Iboat:/home/deepdriving/catkin_ws/src/boat_control/src/boat/msg;-Istd_msgs:/opt/ros/kinetic/share/std_msgs/cmake/../msg")

# Find all generators
find_package(gencpp REQUIRED)
find_package(geneus REQUIRED)
find_package(genlisp REQUIRED)
find_package(gennodejs REQUIRED)
find_package(genpy REQUIRED)

add_custom_target(boat_generate_messages ALL)

# verify that message/service dependencies have not changed since configure



get_filename_component(_filename "/home/deepdriving/catkin_ws/src/boat_control/src/boat/msg/boat_mes.msg" NAME_WE)
add_custom_target(_boat_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "boat" "/home/deepdriving/catkin_ws/src/boat_control/src/boat/msg/boat_mes.msg" ""
)

get_filename_component(_filename "/home/deepdriving/catkin_ws/src/boat_control/src/boat/msg/con_boat.msg" NAME_WE)
add_custom_target(_boat_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "boat" "/home/deepdriving/catkin_ws/src/boat_control/src/boat/msg/con_boat.msg" ""
)

#
#  langs = gencpp;geneus;genlisp;gennodejs;genpy
#

### Section generating for lang: gencpp
### Generating Messages
_generate_msg_cpp(boat
  "/home/deepdriving/catkin_ws/src/boat_control/src/boat/msg/boat_mes.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/boat
)
_generate_msg_cpp(boat
  "/home/deepdriving/catkin_ws/src/boat_control/src/boat/msg/con_boat.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/boat
)

### Generating Services

### Generating Module File
_generate_module_cpp(boat
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/boat
  "${ALL_GEN_OUTPUT_FILES_cpp}"
)

add_custom_target(boat_generate_messages_cpp
  DEPENDS ${ALL_GEN_OUTPUT_FILES_cpp}
)
add_dependencies(boat_generate_messages boat_generate_messages_cpp)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/deepdriving/catkin_ws/src/boat_control/src/boat/msg/boat_mes.msg" NAME_WE)
add_dependencies(boat_generate_messages_cpp _boat_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/deepdriving/catkin_ws/src/boat_control/src/boat/msg/con_boat.msg" NAME_WE)
add_dependencies(boat_generate_messages_cpp _boat_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(boat_gencpp)
add_dependencies(boat_gencpp boat_generate_messages_cpp)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS boat_generate_messages_cpp)

### Section generating for lang: geneus
### Generating Messages
_generate_msg_eus(boat
  "/home/deepdriving/catkin_ws/src/boat_control/src/boat/msg/boat_mes.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/boat
)
_generate_msg_eus(boat
  "/home/deepdriving/catkin_ws/src/boat_control/src/boat/msg/con_boat.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/boat
)

### Generating Services

### Generating Module File
_generate_module_eus(boat
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/boat
  "${ALL_GEN_OUTPUT_FILES_eus}"
)

add_custom_target(boat_generate_messages_eus
  DEPENDS ${ALL_GEN_OUTPUT_FILES_eus}
)
add_dependencies(boat_generate_messages boat_generate_messages_eus)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/deepdriving/catkin_ws/src/boat_control/src/boat/msg/boat_mes.msg" NAME_WE)
add_dependencies(boat_generate_messages_eus _boat_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/deepdriving/catkin_ws/src/boat_control/src/boat/msg/con_boat.msg" NAME_WE)
add_dependencies(boat_generate_messages_eus _boat_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(boat_geneus)
add_dependencies(boat_geneus boat_generate_messages_eus)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS boat_generate_messages_eus)

### Section generating for lang: genlisp
### Generating Messages
_generate_msg_lisp(boat
  "/home/deepdriving/catkin_ws/src/boat_control/src/boat/msg/boat_mes.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/boat
)
_generate_msg_lisp(boat
  "/home/deepdriving/catkin_ws/src/boat_control/src/boat/msg/con_boat.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/boat
)

### Generating Services

### Generating Module File
_generate_module_lisp(boat
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/boat
  "${ALL_GEN_OUTPUT_FILES_lisp}"
)

add_custom_target(boat_generate_messages_lisp
  DEPENDS ${ALL_GEN_OUTPUT_FILES_lisp}
)
add_dependencies(boat_generate_messages boat_generate_messages_lisp)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/deepdriving/catkin_ws/src/boat_control/src/boat/msg/boat_mes.msg" NAME_WE)
add_dependencies(boat_generate_messages_lisp _boat_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/deepdriving/catkin_ws/src/boat_control/src/boat/msg/con_boat.msg" NAME_WE)
add_dependencies(boat_generate_messages_lisp _boat_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(boat_genlisp)
add_dependencies(boat_genlisp boat_generate_messages_lisp)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS boat_generate_messages_lisp)

### Section generating for lang: gennodejs
### Generating Messages
_generate_msg_nodejs(boat
  "/home/deepdriving/catkin_ws/src/boat_control/src/boat/msg/boat_mes.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/boat
)
_generate_msg_nodejs(boat
  "/home/deepdriving/catkin_ws/src/boat_control/src/boat/msg/con_boat.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/boat
)

### Generating Services

### Generating Module File
_generate_module_nodejs(boat
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/boat
  "${ALL_GEN_OUTPUT_FILES_nodejs}"
)

add_custom_target(boat_generate_messages_nodejs
  DEPENDS ${ALL_GEN_OUTPUT_FILES_nodejs}
)
add_dependencies(boat_generate_messages boat_generate_messages_nodejs)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/deepdriving/catkin_ws/src/boat_control/src/boat/msg/boat_mes.msg" NAME_WE)
add_dependencies(boat_generate_messages_nodejs _boat_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/deepdriving/catkin_ws/src/boat_control/src/boat/msg/con_boat.msg" NAME_WE)
add_dependencies(boat_generate_messages_nodejs _boat_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(boat_gennodejs)
add_dependencies(boat_gennodejs boat_generate_messages_nodejs)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS boat_generate_messages_nodejs)

### Section generating for lang: genpy
### Generating Messages
_generate_msg_py(boat
  "/home/deepdriving/catkin_ws/src/boat_control/src/boat/msg/boat_mes.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/boat
)
_generate_msg_py(boat
  "/home/deepdriving/catkin_ws/src/boat_control/src/boat/msg/con_boat.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/boat
)

### Generating Services

### Generating Module File
_generate_module_py(boat
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/boat
  "${ALL_GEN_OUTPUT_FILES_py}"
)

add_custom_target(boat_generate_messages_py
  DEPENDS ${ALL_GEN_OUTPUT_FILES_py}
)
add_dependencies(boat_generate_messages boat_generate_messages_py)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/deepdriving/catkin_ws/src/boat_control/src/boat/msg/boat_mes.msg" NAME_WE)
add_dependencies(boat_generate_messages_py _boat_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/deepdriving/catkin_ws/src/boat_control/src/boat/msg/con_boat.msg" NAME_WE)
add_dependencies(boat_generate_messages_py _boat_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(boat_genpy)
add_dependencies(boat_genpy boat_generate_messages_py)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS boat_generate_messages_py)



if(gencpp_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/boat)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/boat
    DESTINATION ${gencpp_INSTALL_DIR}
  )
endif()
if(TARGET std_msgs_generate_messages_cpp)
  add_dependencies(boat_generate_messages_cpp std_msgs_generate_messages_cpp)
endif()

if(geneus_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/boat)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/boat
    DESTINATION ${geneus_INSTALL_DIR}
  )
endif()
if(TARGET std_msgs_generate_messages_eus)
  add_dependencies(boat_generate_messages_eus std_msgs_generate_messages_eus)
endif()

if(genlisp_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/boat)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/boat
    DESTINATION ${genlisp_INSTALL_DIR}
  )
endif()
if(TARGET std_msgs_generate_messages_lisp)
  add_dependencies(boat_generate_messages_lisp std_msgs_generate_messages_lisp)
endif()

if(gennodejs_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/boat)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/boat
    DESTINATION ${gennodejs_INSTALL_DIR}
  )
endif()
if(TARGET std_msgs_generate_messages_nodejs)
  add_dependencies(boat_generate_messages_nodejs std_msgs_generate_messages_nodejs)
endif()

if(genpy_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/boat)
  install(CODE "execute_process(COMMAND \"/usr/bin/python\" -m compileall \"${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/boat\")")
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/boat
    DESTINATION ${genpy_INSTALL_DIR}
  )
endif()
if(TARGET std_msgs_generate_messages_py)
  add_dependencies(boat_generate_messages_py std_msgs_generate_messages_py)
endif()
