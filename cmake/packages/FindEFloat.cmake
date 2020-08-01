#---------------------------------------------------------------------------#
# Copyright (c) 2020 Mikhail Komarov <nemo@nil.foundation>
#
# Distributed under the Boost Software License, Version 1.0
# See accompanying file LICENSE_1_0.txt or copy at
# http://www.boost.org/LICENSE_1_0.txt
#---------------------------------------------------------------------------#
#
#  EFloat_FOUND - system has EFloat
#  EFloat_INCLUDE_DIRS - the EFloat include directories
#  EFloat_LIBRARY - link these to use EFloat

find_path(EFloat_INCLUDE_DIRS e_float.hpp)

set(EFloat_NAMES ${EFloat_NAMES} e_float libe_float)
find_library(EFloat_LIBRARY NAMES ${EFloat_NAMES})

# handle the QUIETLY and REQUIRED arguments and set TIFF_FOUND to TRUE if
# all listed variables are TRUE
include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(EFloat DEFAULT_MSG EFloat_LIBRARY EFloat_INCLUDE_DIRS)

if(EFloat_FOUND)
    set(EFloat_FOUND true)
    set(EFloat_LIBRARIES ${EFloat_LIBRARY})
    set(EFloat_INCLUDE_DIRS ${EFloat_INCLUDE_DIRS})
endif(EFloat_FOUND)

mark_as_advanced(EFloat_INCLUDE_DIRS EFloat_LIBRARY EFloat_FOUND)
