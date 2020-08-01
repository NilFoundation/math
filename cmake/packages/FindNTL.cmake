#---------------------------------------------------------------------------#
# Copyright (c) 2018-2020 Mikhail Komarov <nemo@nil.foundation>
# Copyright (c) 2018-2020 Alexey Moskvin
#
# Distributed under the Boost Software License, Version 1.0
# See accompanying file LICENSE_1_0.txt or copy at
# http://www.boost.org/LICENSE_1_0.txt
#---------------------------------------------------------------------------#
#
# Try to find the NTL libraries
#
# Once done this will define
# NTL_FOUND - system has NTL lib
# NTL_INCLUDE_DIRS - the NTL include directory
# NTL_LIBRARIES - Libraries needed to use NTL

if(GMP_FOUND)
    find_package(GMP QUIET)
else()
    find_package(GMP)
endif()

if(GMP_FOUND)
    if(NTL_INCLUDE_DIRS AND NTL_LIBRARIES)
        # Already in cache, be silent
        set(NTL_FIND_QUIETLY TRUE)
    endif()

    find_path(NTL_INCLUDE_DIRS NAMES RR.h
              PATHS ${GMP_INCLUDE_DIRS_SEARCH}
              DOC "The directory containing the NTL include files")

    find_library(NTL_LIBRARIES NAMES ntl
                 PATHS ${GMP_LIBRARIES_DIR_SEARCH}
                 DOC "Path to the NTL library")

    include(FindPackageHandleStandardArgs)
    find_package_handle_standard_args(NTL "DEFAULT_MSG" NTL_LIBRARIES NTL_INCLUDE_DIRS)
endif()
