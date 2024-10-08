################################################################################################
#
#  generic_libs_find function to find include and libraries path
#
################################################################################################

if(EXISTS ${CMAKE_SOURCE_DIR}/usr/src)
    set(LIBS_SRC_DIR ${CMAKE_SOURCE_DIR}/usr/src)
elseif(EXISTS ${MA_LIBS_ROOT}/usr/src)
    set(LIBS_SRC_DIR ${MA_LIBS_ROOT}/usr/src)
elseif(EXISTS $ENV{USR_SRC_DIR})
    set(LIBS_SRC_DIR $ENV{USR_SRC_DIR})
else()
    message( FATAL_ERROR "no valid libraries source directory found. Exiting..." )
endif()

if(EXISTS ${CMAKE_SOURCE_DIR}/usr/libs)
    set(LIBS_DIR ${CMAKE_SOURCE_DIR}/usr/libs)
elseif(EXISTS ${MA_LIBS_ROOT}/usr/libs)
    set(LIBS_DIR ${MA_LIBS_ROOT}/usr/libs)
elseif(EXISTS $ENV{USR_BUILD_DIR}/libs)
    set(LIBS_DIR $ENV{USR_BUILD_DIR}/libs)
else()
    message( FATAL_ERROR "no valid libraries files directory found. Exiting..." )
endif()

if(MSVC)
    if(EXISTS ${CMAKE_SOURCE_DIR}/usr/local)
        set(LOCAL_DIR ${CMAKE_SOURCE_DIR}/usr/local)
    elseif(EXISTS ${MA_LIBS_ROOT}/usr/local)
        set(LOCAL_DIR ${MA_LIBS_ROOT}/usr/local)
    elseif(EXISTS $ENV{USR_LIB_DIR})
        set(LOCAL_DIR $ENV{USR_LIB_DIR})
    else()
        message( FATAL_ERROR "no valid local files directory found. Exiting..." )
    endif()
endif()

FUNCTION(generic_libs_find LIBNAME ISLOCAL)

    string(TOUPPER ${LIBNAME} LIBNAME_UCASE)
    string(REPLACE "." "" LIBNAME_UCASE ${LIBNAME_UCASE})
    string(TOLOWER ${LIBNAME_UCASE} LIBNAME_LCASE)
    if(ISLOCAL)
	    set("${LIBNAME_UCASE}_INCLUDE_DIRS" "${LIBS_SRC_DIR}/${LIBNAME}" PARENT_SCOPE)
	    if(WIN32)
		    set("${LIBNAME_UCASE}_INCLUDE_DIRS2" "${LOCAL_DIR}/include" PARENT_SCOPE)
		    set("${LIBNAME_UCASE}_LIBRARY_PATH" "${LOCAL_DIR}/lib"      PARENT_SCOPE)
	    endif()
    else()
        if(WIN32)
            SET(CMAKE_FIND_LIBRARY_PREFIXES "")
            SET(CMAKE_FIND_LIBRARY_SUFFIXES ".lib")
            set("${LIBNAME_UCASE}_INCLUDE_DIRS" "${LIBS_SRC_DIR}/${LIBNAME}" PARENT_SCOPE)
            set("${LIBNAME_UCASE}_INCLUDE_DIRS2" "${LOCAL_DIR}/include" PARENT_SCOPE)
            set("${LIBNAME_UCASE}_INCLUDE_DIRS3" "${LOCAL_DIR2}/local/include" PARENT_SCOPE)
            set("${LIBNAME_UCASE}_LIBRARY_PATH" "${LOCAL_DIR}/lib"      PARENT_SCOPE)
            set("${LIBNAME_UCASE}_LIBRARY_PATH2" "${LOCAL_DIR2}/local/bin" PARENT_SCOPE)
            set("${LIBNAME_UCASE}_LIBRARY_PATH3" "${LOCAL_DIR2}/local/lib" PARENT_SCOPE)
        elseif(APPLE)
            if (CMAKE_HOST_SYSTEM_PROCESSOR MATCHES "arm64")
                set(BREW_ROOT /opt/homebrew)
            else()
                set(BREW_ROOT /usr/local)
            endif()
            set("${LIBNAME_UCASE}_INCLUDE_DIRS"  "${BREW_ROOT}/include" PARENT_SCOPE  )
            set("${LIBNAME_UCASE}_INCLUDE_DIRS2" "${BREW_ROOT}/opt/${LIBNAME}/include"    PARENT_SCOPE )
            set("${LIBNAME_UCASE}_LIBRARY_PATH"  "${BREW_ROOT}/lib"      PARENT_SCOPE )
            set("${LIBNAME_UCASE}_LIBRARY_PATH2" "${BREW_ROOT}/opt/${LIBNAME}/lib"    PARENT_SCOPE )
        else()
            set("${LIBNAME_UCASE}_INCLUDE_DIRS" "/usr/local/include" PARENT_SCOPE)
        endif()
    endif()

ENDFUNCTION()
