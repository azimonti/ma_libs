cmake_minimum_required(VERSION 3.7)
project( imguizmoquat             )
if(APPLE)
    set(CMAKE_OSX_DEPLOYMENT_TARGET 13.0)
endif()
set(CMAKE_CXX_STANDARD 17         )
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF      )

include_directories( ${LIBS_ROOT} )
include_directories( ${LIBS_ROOT}/imGuIZMO.quat/imGuIZMO.quat )
if(WIN32)
    include_directories( ${LIBS_ROOT}/glm        )
elseif(APPLE)
    include_directories( /usr/local/include      )
else()
    include_directories( /usr/local/include      )
endif()

add_definitions( -DVGIZMO_USES_GLM -DGLM_ENABLE_EXPERIMENTAL )
set( SRCS ${LIBS_ROOT}/imGuIZMO.quat/imGuIZMO.quat/imGuIZMOquat.cpp )

add_library( ${PROJECT_NAME} STATIC ${SRCS} )
