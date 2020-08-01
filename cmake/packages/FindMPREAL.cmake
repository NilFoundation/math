#---------------------------------------------------------------------------#
# Copyright (c) 2018-2020 Mikhail Komarov <nemo@nil.foundation>
# Copyright (c) 2018-2020 Alexey Moskvin
#
# Distributed under the Boost Software License, Version 1.0
# See accompanying file LICENSE_1_0.txt or copy at
# http://www.boost.org/LICENSE_1_0.txt
#---------------------------------------------------------------------------#
#
# Try to find the MPREAL library
# See http://www.holoborodko.com/pavel/mpfr/
#
# This module supports requiring a minimum version, e.g. you can do
#   find_package(MPREAL 2.3.0)
# to require version 2.3.0 to newer of MPREAL.
#
# Once done this will define
#
#  MPREAL_FOUND - system has MPREAL lib with correct version
#  MPREAL_INCLUDE_DIRS - the MPREAL include directory
#  MPREAL_LIBRARIES - the MPREAL library
#  MPREAL_VERSION - MPREAL version

find_path(MPREAL_INCLUDE_DIRS NAMES mpreal.h PATHS $ENV{MPFRDIR} $ENV{MPREALDIR}
          ${INCLUDE_INSTALL_DIR})

# Set MPREAL_FIND_VERSION to 1.0.0 if no minimum version is specified
if(NOT MPREAL_FIND_VERSION)
    if(NOT MPREAL_FIND_VERSION_MAJOR)
        set(MPREAL_FIND_VERSION_MAJOR 1)
    endif()
    if(NOT MPREAL_FIND_VERSION_MINOR)
        set(MPREAL_FIND_VERSION_MINOR 0)
    endif()
    if(NOT MPREAL_FIND_VERSION_PATCH)
        set(MPREAL_FIND_VERSION_PATCH 0)
    endif()
    set(MPREAL_FIND_VERSION
        "${MPREAL_FIND_VERSION_MAJOR}.${MPREAL_FIND_VERSION_MINOR}.${MPREAL_FIND_VERSION_PATCH}")
endif()

if(MPREAL_INCLUDE_DIRS)
    # Query MPREAL_VERSION
    file(READ "${MPREAL_INCLUDE_DIRS}/mpreal.h" _mpfr_version_header)

    string(REGEX MATCH "define[ \t]+MPREAL_VERSION_MAJOR[ \t]+([0-9]+)"
           _mpfr_major_version_match "${_mpfr_version_header}")
    set(MPREAL_MAJOR_VERSION "${CMAKE_MATCH_1}")
    string(REGEX MATCH "define[ \t]+MPREAL_VERSION_MINOR[ \t]+([0-9]+)"
           _mpfr_minor_version_match "${_mpfr_version_header}")
    set(MPREAL_MINOR_VERSION "${CMAKE_MATCH_1}")
    string(REGEX MATCH "define[ \t]+MPREAL_VERSION_PATCHLEVEL[ \t]+([0-9]+)"
           _mpfr_patchlevel_version_match "${_mpfr_version_header}")
    set(MPREAL_PATCHLEVEL_VERSION "${CMAKE_MATCH_1}")

    set(MPREAL_VERSION
        ${MPREAL_MAJOR_VERSION}.${MPREAL_MINOR_VERSION}.${MPREAL_PATCHLEVEL_VERSION})

    # Check whether found version exceeds minimum required
    if(${MPREAL_VERSION} VERSION_LESS ${MPREAL_FIND_VERSION})
        set(MPREAL_VERSION_OK FALSE)
        message(STATUS "MPREAL version ${MPREAL_VERSION} found in ${MPREAL_INCLUDE_DIRS}, "
                "but at least version ${MPREAL_FIND_VERSION} is required")
    else()
        set(MPREAL_VERSION_OK TRUE)
    endif()
endif()

find_library(MPREAL_LIBRARIES mpreal
             PATHS $ENV{GMPDIR} $ENV{MPREALDIR} ${LIB_INSTALL_DIR})

include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(MPREAL DEFAULT_MSG
                                  MPREAL_INCLUDE_DIRS MPREAL_LIBRARIES MPREAL_VERSION_OK)
mark_as_advanced(MPREAL_INCLUDE_DIRS MPREAL_LIBRARIES)