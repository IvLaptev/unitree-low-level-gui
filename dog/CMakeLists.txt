cmake_minimum_required(VERSION 3.5)
project(robot-low-level-backend CXX)

include(CheckIncludeFileCXX)
link_directories(${CMAKE_CURRENT_SOURCE_DIR}/lib)

check_include_file_cxx(any HAS_ANY)
check_include_file_cxx(string_view HAS_STRING_VIEW)
check_include_file_cxx(coroutine HAS_COROUTINE)
if (NOT "${CMAKE_CXX_STANDARD}" STREQUAL "")
    # Do nothing
elseif (HAS_ANY AND HAS_STRING_VIEW AND HAS_COROUTINE)
    set(CMAKE_CXX_STANDARD 20)
elseif (HAS_ANY AND HAS_STRING_VIEW)
    set(CMAKE_CXX_STANDARD 17)
else ()
    set(CMAKE_CXX_STANDARD 14)
endif ()

set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF)

# Build server components
add_library(server
    ${CMAKE_CURRENT_SOURCE_DIR}/src/models/connection.cc
    ${CMAKE_CURRENT_SOURCE_DIR}/include/server/models/connection.h
    ${CMAKE_CURRENT_SOURCE_DIR}/src/models/motion.cc
    ${CMAKE_CURRENT_SOURCE_DIR}/include/server/models/motion.h
    ${CMAKE_CURRENT_SOURCE_DIR}/src/store.cc
    ${CMAKE_CURRENT_SOURCE_DIR}/include/server/store.h)

target_include_directories(server PRIVATE ${CMAKE_CURRENT_SOURCE_DIR}/include)

# Build robot control components
add_library(robot
    ${CMAKE_CURRENT_SOURCE_DIR}/src/robot/robot.cc
    ${CMAKE_CURRENT_SOURCE_DIR}/include/robot/robot.h
    ${CMAKE_CURRENT_SOURCE_DIR}/src/robot/controller.cc
    ${CMAKE_CURRENT_SOURCE_DIR}/include/robot/controller.h
    ${CMAKE_CURRENT_SOURCE_DIR}/src/robot/program.cc
    ${CMAKE_CURRENT_SOURCE_DIR}/include/robot/program.h)

target_include_directories(robot PRIVATE ${CMAKE_CURRENT_SOURCE_DIR}/include)

add_executable(${PROJECT_NAME} src/main.cc)

# ##############################################################################
# If you include the drogon source code locally in your project, use this method
# to add drogon 
# add_subdirectory(drogon) 
# target_link_libraries(${PROJECT_NAME} PRIVATE drogon)
#
# and comment out the following lines
find_package(Drogon CONFIG REQUIRED)
target_link_libraries(${PROJECT_NAME} PRIVATE Drogon::Drogon)

# ##############################################################################

if (CMAKE_CXX_STANDARD LESS 17)
    # With C++14, use boost to support any, string_view and filesystem
    message(STATUS "use c++14")
    find_package(Boost 1.61.0 REQUIRED)
    target_link_libraries(${PROJECT_NAME} PUBLIC Boost::boost)
elseif (CMAKE_CXX_STANDARD LESS 20)
    message(STATUS "use c++17")
else ()
    message(STATUS "use c++20")
endif ()

aux_source_directory(${CMAKE_CURRENT_SOURCE_DIR}/src/controllers CTL_SRC)
# aux_source_directory(filters FILTER_SRC)
# aux_source_directory(plugins PLUGIN_SRC)
aux_source_directory(${CMAKE_CURRENT_SOURCE_DIR}/src/models MODEL_SRC)

target_include_directories(${PROJECT_NAME}
                           PRIVATE ${CMAKE_CURRENT_SOURCE_DIR}
                                   ${CMAKE_CURRENT_SOURCE_DIR}/models
                                   ${CMAKE_CURRENT_SOURCE_DIR}/include)

message(STATUS ${CMAKE_CURRENT_SOURCE_DIR}/lib)

target_sources(${PROJECT_NAME}
               PRIVATE
               ${SRC_DIR}
               ${CTL_SRC}
            #    ${CMAKE_CURRENT_SOURCE_DIR}/controllers/v1.cc
            #    ${FILTER_SRC}
            #    ${PLUGIN_SRC}
            #    ${MODEL_SRC}
)

target_link_libraries(${PROJECT_NAME} PRIVATE server robot)
target_link_libraries(${PROJECT_NAME} PRIVATE libunitree_legged_sdk_amd64.so lcm)
