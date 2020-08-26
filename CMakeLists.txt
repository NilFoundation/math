#---------------------------------------------------------------------------#
# Copyright (c) 2018-2020 Mikhail Komarov <nemo@nil.foundation>
# Copyright (c) 2018-2020 Alexey Moskvin
#
# Distributed under the Boost Software License, Version 1.0
# See accompanying file LICENSE_1_0.txt or copy at
# http://www.boost.org/LICENSE_1_0.txt
#---------------------------------------------------------------------------#

cmake_minimum_required(VERSION 3.5)

set(BOOST_CMAKE FALSE)

list(APPEND CMAKE_MODULE_PATH "${CMAKE_CURRENT_LIST_DIR}/cmake"
     "${CMAKE_CURRENT_LIST_DIR}/cmake/packages"
     "${CMAKE_CURRENT_LIST_DIR}/cmake/modules/share/modules/cmake")

include(CMDeploy)
include(CMConfig)
include(CMSetupVersion)

cm_setup_version(VERSION 1.73.0)

option(BUILD_WITH_CI_KNOWN_ISSUES_SUPPRESS "Build for CI suppressing known issues" FALSE)
option(BUILD_TESTS "Build unit tests" FALSE)
option(BUILD_TOOLS "Build tools" FALSE)
option(BUILD_EXAMPLES "Build examples" FALSE)

if(BUILD_WITH_CI_KNOWN_ISSUES_SUPPRESS)
    add_definitions(-DCI_SUPPRESS_KNOWN_ISSUES)
endif()

find_package(GMP)
find_package(GMPXX)
find_package(Quadmath)
find_package(TomMath)
find_package(MPFR)
find_package(MPFI)
find_package(FFTW3)
find_package(EFloat)
find_package(MPREAL)
find_package(NTL)

if(GMP_FOUND)
    try_compile(GMP_COMPILED ${CMAKE_BINARY_DIR} ${CMAKE_CURRENT_LIST_DIR}/config/has_gmp.cpp
                LINK_LIBRARIES ${GMP_LIBRARIES}
                CMAKE_FLAGS "-DCMAKE_CXX_LINK_EXECUTABLE='echo not linking now...'" "-DINCLUDE_DIRECTORIES=${GMP_INCLUDE_DIRS};${Boost_INCLUDE_DIRS}" OUTPUT_VARIABLE OUTP)
endif()

if(GMPXX_FOUND)
    try_compile(GMPXX_COMPILED ${CMAKE_BINARY_DIR} ${CMAKE_CURRENT_LIST_DIR}/config/has_gmpxx.cpp
                LINK_LIBRARIES ${GMPXX_LIBRARIES}
                CMAKE_FLAGS "-DCMAKE_CXX_LINK_EXECUTABLE='echo not linking now...'"
                "-DINCLUDE_DIRECTORIES=${GMPXX_INCLUDE_DIRS};${Boost_INCLUDE_DIRS}" OUTPUT_VARIABLE OUTP)
endif()

if(NTL_FOUND)
    try_compile(NTL_COMPILED ${CMAKE_BINARY_DIR} ${CMAKE_CURRENT_LIST_DIR}/config/has_ntl_rr.cpp
                LINK_LIBRARIES ${NTL_LIBRARIES}
                CMAKE_FLAGS "-DCMAKE_CXX_LINK_EXECUTABLE='echo not linking now...'"
                "-DINCLUDE_DIRECTORIES=${NTL_INCLUDE_DIRS};${Boost_INCLUDE_DIRS}" OUTPUT_VARIABLE OUTP)
endif()

if(MPFR_FOUND)
    try_compile(MPFR_COMPILED ${CMAKE_BINARY_DIR} ${CMAKE_CURRENT_LIST_DIR}/config/has_mpfr.cpp
                LINK_LIBRARIES ${MPFR_LIBRARIES}
                CMAKE_FLAGS "-DCMAKE_CXX_LINK_EXECUTABLE='echo not linking now...'" "-DINCLUDE_DIRECTORIES=${MPFR_INCLUDE_DIRS}")
    try_compile(MPFR_CLASS_COMPILED ${CMAKE_BINARY_DIR} ${CMAKE_CURRENT_LIST_DIR}/config/has_mpfr_class.cpp
                LINK_LIBRARIES ${MPFR_LIBRARIES}
                CMAKE_FLAGS "-DCMAKE_CXX_LINK_EXECUTABLE='echo not linking now...'" "-DINCLUDE_DIRECTORIES=${MPFR_INCLUDE_DIRS}")
endif()

if(MPREAL_FOUND)
    try_compile(MPREAL_COMPILED ${CMAKE_BINARY_DIR} ${CMAKE_CURRENT_LIST_DIR}/config/has_mpreal.cpp
                LINK_LIBRARIES ${MPREAL_LIBRARIES}
                CMAKE_FLAGS "-DCMAKE_CXX_LINK_EXECUTABLE='echo not linking now...'"
                "-DINCLUDE_DIRECTORIES=${MPREAL_INCLUDE_DIRS}")
endif()

if(TOMMATH_FOUND)
    try_compile(TOMMATH_COMPILED ${CMAKE_BINARY_DIR} ${CMAKE_CURRENT_LIST_DIR}/config/has_tommath.cpp
                LINK_LIBRARIES ${TomMath_LIBRARIES}
                CMAKE_FLAGS "-DCMAKE_CXX_LINK_EXECUTABLE='echo not linking now...'" "-DINCLUDE_DIRECTORIES=${TomMath_INCLUDE_DIRS}")
endif()

try_compile(FLOAT128_COMPILED ${CMAKE_BINARY_DIR} ${CMAKE_CURRENT_LIST_DIR}/config/has_float128.cpp)
try_compile(FLOAT128_FLOATMAX_COMPILED ${CMAKE_BINARY_DIR}
            ${CMAKE_CURRENT_LIST_DIR}/config/has_128bit_floatmax_t.cpp)
try_compile(GCC_VISIBILITY_COMPILED ${CMAKE_BINARY_DIR}
            ${CMAKE_CURRENT_LIST_DIR}/config/has_gcc_visibility.cpp)
try_compile(LONG_DOUBLE_SUPPORT_COMPILED ${CMAKE_BINARY_DIR}
            ${CMAKE_CURRENT_LIST_DIR}/config/has_long_double_support.cpp)

if(MPFI_FOUND)
    try_compile(MPFI_COMPILED ${CMAKE_BINARY_DIR} ${CMAKE_CURRENT_LIST_DIR}/config/has_mpfi.cpp
                LINK_LIBRARIES ${MPFI_LIBRARIES}
                CMAKE_FLAGS "-DCMAKE_CXX_LINK_EXECUTABLE='echo not linking now...'" "-DINCLUDE_DIRECTORIES=${MPFI_INCLUDE_DIRS}")
endif()

if(Quadmath_FOUND)
    try_compile(INTEL_QUAD_COMPILED ${CMAKE_BINARY_DIR} ${CMAKE_CURRENT_LIST_DIR}/config/has_intel_quad.cpp CMAKE_FLAGS
                "-DCMAKE_CXX_LINK_EXECUTABLE='echo not linking now...'")
endif()

if(FFTW3_FOUND)
    try_compile(FFTW3_COMPILED ${CMAKE_BINARY_DIR} ${CMAKE_CURRENT_LIST_DIR}/config/has_fftw3.cpp
                CMAKE_FLAGS "-DCMAKE_CXX_LINK_EXECUTABLE='echo not linking now...'"
                "-DINCLUDE_DIRECTORIES=${FFTW3_INCLUDE_DIRS}")
endif()

if(EFloat_FOUND)
    try_compile(EFLOAT_COMPILED ${CMAKE_BINARY_DIR} ${CMAKE_CURRENT_LIST_DIR}/config/has_e_float.cpp
                CMAKE_FLAGS "-DCMAKE_CXX_LINK_EXECUTABLE='echo not linking now...'" "-DINCLUDE_DIRECTORIES=${EFloat_INCLUDE_DIRS}")
endif()

set(C99_SOURCES
    ${CMAKE_CURRENT_LIST_DIR}/src/tr1/acosh.cpp
    ${CMAKE_CURRENT_LIST_DIR}/src/tr1/asinh.cpp
    ${CMAKE_CURRENT_LIST_DIR}/src/tr1/atanh.cpp
    ${CMAKE_CURRENT_LIST_DIR}/src/tr1/cbrt.cpp
    ${CMAKE_CURRENT_LIST_DIR}/src/tr1/copysign.cpp
    ${CMAKE_CURRENT_LIST_DIR}/src/tr1/erfc.cpp
    ${CMAKE_CURRENT_LIST_DIR}/src/tr1/erf.cpp
    ${CMAKE_CURRENT_LIST_DIR}/src/tr1/expm1.cpp
    ${CMAKE_CURRENT_LIST_DIR}/src/tr1/fmax.cpp
    ${CMAKE_CURRENT_LIST_DIR}/src/tr1/fmin.cpp
    ${CMAKE_CURRENT_LIST_DIR}/src/tr1/fpclassify.cpp
    ${CMAKE_CURRENT_LIST_DIR}/src/tr1/hypot.cpp
    ${CMAKE_CURRENT_LIST_DIR}/src/tr1/lgamma.cpp
    ${CMAKE_CURRENT_LIST_DIR}/src/tr1/llround.cpp
    ${CMAKE_CURRENT_LIST_DIR}/src/tr1/log1p.cpp
    ${CMAKE_CURRENT_LIST_DIR}/src/tr1/lround.cpp
    ${CMAKE_CURRENT_LIST_DIR}/src/tr1/nextafter.cpp
    ${CMAKE_CURRENT_LIST_DIR}/src/tr1/nexttoward.cpp
    ${CMAKE_CURRENT_LIST_DIR}/src/tr1/round.cpp
    ${CMAKE_CURRENT_LIST_DIR}/src/tr1/tgamma.cpp
    ${CMAKE_CURRENT_LIST_DIR}/src/tr1/trunc.cpp)

set(C99F_SOURCES
    ${CMAKE_CURRENT_LIST_DIR}/src/tr1/acoshf.cpp
    ${CMAKE_CURRENT_LIST_DIR}/src/tr1/asinhf.cpp
    ${CMAKE_CURRENT_LIST_DIR}/src/tr1/atanhf.cpp
    ${CMAKE_CURRENT_LIST_DIR}/src/tr1/cbrtf.cpp
    ${CMAKE_CURRENT_LIST_DIR}/src/tr1/copysignf.cpp
    ${CMAKE_CURRENT_LIST_DIR}/src/tr1/erfcf.cpp
    ${CMAKE_CURRENT_LIST_DIR}/src/tr1/erff.cpp
    ${CMAKE_CURRENT_LIST_DIR}/src/tr1/expm1f.cpp
    ${CMAKE_CURRENT_LIST_DIR}/src/tr1/fmaxf.cpp
    ${CMAKE_CURRENT_LIST_DIR}/src/tr1/fminf.cpp
    ${CMAKE_CURRENT_LIST_DIR}/src/tr1/fpclassifyf.cpp
    ${CMAKE_CURRENT_LIST_DIR}/src/tr1/hypotf.cpp
    ${CMAKE_CURRENT_LIST_DIR}/src/tr1/lgammaf.cpp
    ${CMAKE_CURRENT_LIST_DIR}/src/tr1/llroundf.cpp
    ${CMAKE_CURRENT_LIST_DIR}/src/tr1/log1pf.cpp
    ${CMAKE_CURRENT_LIST_DIR}/src/tr1/lroundf.cpp
    ${CMAKE_CURRENT_LIST_DIR}/src/tr1/nextafterf.cpp
    ${CMAKE_CURRENT_LIST_DIR}/src/tr1/nexttowardf.cpp
    ${CMAKE_CURRENT_LIST_DIR}/src/tr1/roundf.cpp
    ${CMAKE_CURRENT_LIST_DIR}/src/tr1/tgammaf.cpp
    ${CMAKE_CURRENT_LIST_DIR}/src/tr1/truncf.cpp)

set(C99L_SOURCES
    ${CMAKE_CURRENT_LIST_DIR}/src/tr1/acoshl.cpp
    ${CMAKE_CURRENT_LIST_DIR}/src/tr1/asinhl.cpp
    ${CMAKE_CURRENT_LIST_DIR}/src/tr1/atanhl.cpp
    ${CMAKE_CURRENT_LIST_DIR}/src/tr1/cbrtl.cpp
    ${CMAKE_CURRENT_LIST_DIR}/src/tr1/copysignl.cpp
    ${CMAKE_CURRENT_LIST_DIR}/src/tr1/erfcl.cpp
    ${CMAKE_CURRENT_LIST_DIR}/src/tr1/erfl.cpp
    ${CMAKE_CURRENT_LIST_DIR}/src/tr1/expm1l.cpp
    ${CMAKE_CURRENT_LIST_DIR}/src/tr1/fmaxl.cpp
    ${CMAKE_CURRENT_LIST_DIR}/src/tr1/fminl.cpp
    ${CMAKE_CURRENT_LIST_DIR}/src/tr1/fpclassifyl.cpp
    ${CMAKE_CURRENT_LIST_DIR}/src/tr1/hypotl.cpp
    ${CMAKE_CURRENT_LIST_DIR}/src/tr1/lgammal.cpp
    ${CMAKE_CURRENT_LIST_DIR}/src/tr1/llroundl.cpp
    ${CMAKE_CURRENT_LIST_DIR}/src/tr1/log1pl.cpp
    ${CMAKE_CURRENT_LIST_DIR}/src/tr1/lroundl.cpp
    ${CMAKE_CURRENT_LIST_DIR}/src/tr1/nextafterl.cpp
    ${CMAKE_CURRENT_LIST_DIR}/src/tr1/nexttowardl.cpp
    ${CMAKE_CURRENT_LIST_DIR}/src/tr1/roundl.cpp
    ${CMAKE_CURRENT_LIST_DIR}/src/tr1/tgammal.cpp
    ${CMAKE_CURRENT_LIST_DIR}/src/tr1/truncl.cpp)

set(TR1_SOURCES
    ${CMAKE_CURRENT_LIST_DIR}/src/tr1/assoc_laguerre.cpp
    ${CMAKE_CURRENT_LIST_DIR}/src/tr1/assoc_legendre.cpp
    ${CMAKE_CURRENT_LIST_DIR}/src/tr1/beta.cpp
    ${CMAKE_CURRENT_LIST_DIR}/src/tr1/comp_ellint_1.cpp
    ${CMAKE_CURRENT_LIST_DIR}/src/tr1/comp_ellint_2.cpp
    ${CMAKE_CURRENT_LIST_DIR}/src/tr1/comp_ellint_3.cpp
    ${CMAKE_CURRENT_LIST_DIR}/src/tr1/cyl_bessel_i.cpp
    ${CMAKE_CURRENT_LIST_DIR}/src/tr1/cyl_bessel_j.cpp
    ${CMAKE_CURRENT_LIST_DIR}/src/tr1/cyl_bessel_k.cpp
    ${CMAKE_CURRENT_LIST_DIR}/src/tr1/cyl_neumann.cpp
    ${CMAKE_CURRENT_LIST_DIR}/src/tr1/ellint_1.cpp
    ${CMAKE_CURRENT_LIST_DIR}/src/tr1/ellint_2.cpp
    ${CMAKE_CURRENT_LIST_DIR}/src/tr1/ellint_3.cpp
    ${CMAKE_CURRENT_LIST_DIR}/src/tr1/expint.cpp
    ${CMAKE_CURRENT_LIST_DIR}/src/tr1/hermite.cpp
    ${CMAKE_CURRENT_LIST_DIR}/src/tr1/laguerre.cpp
    ${CMAKE_CURRENT_LIST_DIR}/src/tr1/legendre.cpp
    ${CMAKE_CURRENT_LIST_DIR}/src/tr1/riemann_zeta.cpp
    ${CMAKE_CURRENT_LIST_DIR}/src/tr1/sph_bessel.cpp
    ${CMAKE_CURRENT_LIST_DIR}/src/tr1/sph_legendre.cpp
    ${CMAKE_CURRENT_LIST_DIR}/src/tr1/sph_neumann.cpp)

set(TR1F_SOURCES
    ${CMAKE_CURRENT_LIST_DIR}/src/tr1/assoc_laguerref.cpp
    ${CMAKE_CURRENT_LIST_DIR}/src/tr1/assoc_legendref.cpp
    ${CMAKE_CURRENT_LIST_DIR}/src/tr1/betaf.cpp
    ${CMAKE_CURRENT_LIST_DIR}/src/tr1/comp_ellint_1f.cpp
    ${CMAKE_CURRENT_LIST_DIR}/src/tr1/comp_ellint_2f.cpp
    ${CMAKE_CURRENT_LIST_DIR}/src/tr1/comp_ellint_3f.cpp
    ${CMAKE_CURRENT_LIST_DIR}/src/tr1/cyl_bessel_if.cpp
    ${CMAKE_CURRENT_LIST_DIR}/src/tr1/cyl_bessel_jf.cpp
    ${CMAKE_CURRENT_LIST_DIR}/src/tr1/cyl_bessel_kf.cpp
    ${CMAKE_CURRENT_LIST_DIR}/src/tr1/cyl_neumannf.cpp
    ${CMAKE_CURRENT_LIST_DIR}/src/tr1/ellint_1f.cpp
    ${CMAKE_CURRENT_LIST_DIR}/src/tr1/ellint_2f.cpp
    ${CMAKE_CURRENT_LIST_DIR}/src/tr1/ellint_3f.cpp
    ${CMAKE_CURRENT_LIST_DIR}/src/tr1/expintf.cpp
    ${CMAKE_CURRENT_LIST_DIR}/src/tr1/hermitef.cpp
    ${CMAKE_CURRENT_LIST_DIR}/src/tr1/laguerref.cpp
    ${CMAKE_CURRENT_LIST_DIR}/src/tr1/legendref.cpp
    ${CMAKE_CURRENT_LIST_DIR}/src/tr1/riemann_zetaf.cpp
    ${CMAKE_CURRENT_LIST_DIR}/src/tr1/sph_besself.cpp
    ${CMAKE_CURRENT_LIST_DIR}/src/tr1/sph_legendref.cpp
    ${CMAKE_CURRENT_LIST_DIR}/src/tr1/sph_neumannf.cpp)

set(TR1L_SOURCES
    ${CMAKE_CURRENT_LIST_DIR}/src/tr1/assoc_laguerrel.cpp
    ${CMAKE_CURRENT_LIST_DIR}/src/tr1/assoc_legendrel.cpp
    ${CMAKE_CURRENT_LIST_DIR}/src/tr1/betal.cpp
    ${CMAKE_CURRENT_LIST_DIR}/src/tr1/comp_ellint_1l.cpp
    ${CMAKE_CURRENT_LIST_DIR}/src/tr1/comp_ellint_2l.cpp
    ${CMAKE_CURRENT_LIST_DIR}/src/tr1/comp_ellint_3l.cpp
    ${CMAKE_CURRENT_LIST_DIR}/src/tr1/cyl_bessel_il.cpp
    ${CMAKE_CURRENT_LIST_DIR}/src/tr1/cyl_bessel_jl.cpp
    ${CMAKE_CURRENT_LIST_DIR}/src/tr1/cyl_bessel_kl.cpp
    ${CMAKE_CURRENT_LIST_DIR}/src/tr1/cyl_neumannl.cpp
    ${CMAKE_CURRENT_LIST_DIR}/src/tr1/ellint_1l.cpp
    ${CMAKE_CURRENT_LIST_DIR}/src/tr1/ellint_2l.cpp
    ${CMAKE_CURRENT_LIST_DIR}/src/tr1/ellint_3l.cpp
    ${CMAKE_CURRENT_LIST_DIR}/src/tr1/expintl.cpp
    ${CMAKE_CURRENT_LIST_DIR}/src/tr1/hermitel.cpp
    ${CMAKE_CURRENT_LIST_DIR}/src/tr1/laguerrel.cpp
    ${CMAKE_CURRENT_LIST_DIR}/src/tr1/legendrel.cpp
    ${CMAKE_CURRENT_LIST_DIR}/src/tr1/riemann_zetal.cpp
    ${CMAKE_CURRENT_LIST_DIR}/src/tr1/sph_bessell.cpp
    ${CMAKE_CURRENT_LIST_DIR}/src/tr1/sph_legendrel.cpp
    ${CMAKE_CURRENT_LIST_DIR}/src/tr1/sph_neumannl.cpp)

add_library(main_pch SHARED ${CMAKE_CURRENT_LIST_DIR}/src/tr1/pch.hpp)
target_include_directories(main_pch PRIVATE ${CMAKE_CURRENT_LIST_DIR}/src/tr1)
target_compile_definitions(main_pch PRIVATE BOOST_MATH_TR1_DYN_LINK)
set_property(TARGET main_pch PROPERTY LINKER_LANGUAGE CXX)
cm_deploy(TARGETS main_pch
          INCLUDE ${CURRENT_SOURCES_DIR}/src/tr1)

list(APPEND TARGET_POSTFIXES "c99" "c99f" "c99l" "tr1" "tr1f" "tr1l")
list(APPEND TARGET_NAMES)

if("${CMAKE_WORKSPACE_NAME}" STREQUAL "boost")
    set(BOOST_CMAKE TRUE)

    cm_project(math WORKSPACE_NAME ${CMAKE_WORKSPACE_NAME})

    find_package(${CMAKE_WORKSPACE_NAME}_core)
    find_package(${CMAKE_WORKSPACE_NAME}_static_assert)
    find_package(${CMAKE_WORKSPACE_NAME}_predef)
    find_package(${CMAKE_WORKSPACE_NAME}_mpl)
    find_package(${CMAKE_WORKSPACE_NAME}_random)
    find_package(${CMAKE_WORKSPACE_NAME}_functional)
    find_package(${CMAKE_WORKSPACE_NAME}_assert)
    find_package(${CMAKE_WORKSPACE_NAME}_type_traits)
    find_package(${CMAKE_WORKSPACE_NAME}_smart_ptr)
    find_package(${CMAKE_WORKSPACE_NAME}_rational)
    find_package(${CMAKE_WORKSPACE_NAME}_lexical_cast)
    find_package(${CMAKE_WORKSPACE_NAME}_integer)
    find_package(${CMAKE_WORKSPACE_NAME}_array)
    find_package(${CMAKE_WORKSPACE_NAME}_config)
    find_package(${CMAKE_WORKSPACE_NAME}_throw_exception)

    foreach(TARGET_POSTFIX ${TARGET_POSTFIXES})
        string(TOUPPER ${TARGET_POSTFIX} UPPER_TARGET_POSTFIX)
        if((${TARGET_POSTFIX} STREQUAL "tr1l") OR (${TARGET_POSTFIX} STREQUAL "c99l"))
            if(LONG_DOUBLE_SUPPORT_COMPILED)
                add_library(${CMAKE_WORKSPACE_NAME}_${CURRENT_PROJECT_NAME}_${TARGET_POSTFIX} ${${UPPER_TARGET_POSTFIX}_SOURCES})
                list(APPEND TARGET_NAMES ${CMAKE_WORKSPACE_NAME}_${CURRENT_PROJECT_NAME}_${TARGET_POSTFIX})
            else()
                continue()
            endif()
        else()
            add_library(${CMAKE_WORKSPACE_NAME}_${CURRENT_PROJECT_NAME}_${TARGET_POSTFIX} ${${UPPER_TARGET_POSTFIX}_SOURCES})
            list(APPEND TARGET_NAMES ${CMAKE_WORKSPACE_NAME}_${CURRENT_PROJECT_NAME}_${TARGET_POSTFIX})
        endif()
        set_property(TARGET ${CMAKE_WORKSPACE_NAME}_${CURRENT_PROJECT_NAME}_${TARGET_POSTFIX} PROPERTY EXPORT_NAME
                     ${CURRENT_PROJECT_NAME}_${TARGET_POSTFIX})
        target_include_directories(${CMAKE_WORKSPACE_NAME}_${CURRENT_PROJECT_NAME}_${TARGET_POSTFIX} PRIVATE
                                   $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/include>
                                   $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/src/tr1>
                                   $<BUILD_INTERFACE:${CMAKE_BINARY_DIR}/include>)
        target_link_libraries(${CMAKE_WORKSPACE_NAME}_${CURRENT_PROJECT_NAME}_${TARGET_POSTFIX} INTERFACE main_pch)
        target_link_libraries(${CMAKE_WORKSPACE_NAME}_${CURRENT_PROJECT_NAME}_${TARGET_POSTFIX} INTERFACE ${CMAKE_WORKSPACE_NAME}::core)
        target_link_libraries(${CMAKE_WORKSPACE_NAME}_${CURRENT_PROJECT_NAME}_${TARGET_POSTFIX} INTERFACE ${CMAKE_WORKSPACE_NAME}::static_assert)
        target_link_libraries(${CMAKE_WORKSPACE_NAME}_${CURRENT_PROJECT_NAME}_${TARGET_POSTFIX} INTERFACE ${CMAKE_WORKSPACE_NAME}::predef)
        target_link_libraries(${CMAKE_WORKSPACE_NAME}_${CURRENT_PROJECT_NAME}_${TARGET_POSTFIX} INTERFACE ${CMAKE_WORKSPACE_NAME}::mpl)
        target_link_libraries(${CMAKE_WORKSPACE_NAME}_${CURRENT_PROJECT_NAME}_${TARGET_POSTFIX} INTERFACE ${CMAKE_WORKSPACE_NAME}::random)
        target_link_libraries(${CMAKE_WORKSPACE_NAME}_${CURRENT_PROJECT_NAME}_${TARGET_POSTFIX} INTERFACE ${CMAKE_WORKSPACE_NAME}::functional)
        target_link_libraries(${CMAKE_WORKSPACE_NAME}_${CURRENT_PROJECT_NAME}_${TARGET_POSTFIX} INTERFACE ${CMAKE_WORKSPACE_NAME}::assert)
        target_link_libraries(${CMAKE_WORKSPACE_NAME}_${CURRENT_PROJECT_NAME}_${TARGET_POSTFIX} INTERFACE ${CMAKE_WORKSPACE_NAME}::type_traits)
        target_link_libraries(${CMAKE_WORKSPACE_NAME}_${CURRENT_PROJECT_NAME}_${TARGET_POSTFIX} INTERFACE ${CMAKE_WORKSPACE_NAME}::smart_ptr)
        target_link_libraries(${CMAKE_WORKSPACE_NAME}_${CURRENT_PROJECT_NAME}_${TARGET_POSTFIX} INTERFACE ${CMAKE_WORKSPACE_NAME}::rational)
        target_link_libraries(${CMAKE_WORKSPACE_NAME}_${CURRENT_PROJECT_NAME}_${TARGET_POSTFIX} INTERFACE ${CMAKE_WORKSPACE_NAME}::lexical_cast)
        target_link_libraries(${CMAKE_WORKSPACE_NAME}_${CURRENT_PROJECT_NAME}_${TARGET_POSTFIX} INTERFACE ${CMAKE_WORKSPACE_NAME}::integer)
        target_link_libraries(${CMAKE_WORKSPACE_NAME}_${CURRENT_PROJECT_NAME}_${TARGET_POSTFIX} INTERFACE ${CMAKE_WORKSPACE_NAME}::array)
        target_link_libraries(${CMAKE_WORKSPACE_NAME}_${CURRENT_PROJECT_NAME}_${TARGET_POSTFIX} INTERFACE ${CMAKE_WORKSPACE_NAME}::config)
        target_link_libraries(${CMAKE_WORKSPACE_NAME}_${CURRENT_PROJECT_NAME}_${TARGET_POSTFIX} INTERFACE ${CMAKE_WORKSPACE_NAME}::throw_exception)
        get_target_property(target_type ${CMAKE_WORKSPACE_NAME}_${CURRENT_PROJECT_NAME}_${TARGET_POSTFIX} TYPE)
        if(target_type STREQUAL "SHARED_LIB")
            target_compile_definitions(${CMAKE_WORKSPACE_NAME}_${CURRENT_PROJECT_NAME}_${TARGET_POSTFIX} PRIVATE BOOST_MATH_TR1_DYN_LINK)
        elseif(target_type STREQUAL "STATIC_LIB")

        endif()
    endforeach()
else()
    cm_workspace(boost SOURCES_DIR ${CMAKE_CURRENT_LIST_DIR})

    cm_project(math WORKSPACE_NAME ${CMAKE_WORKSPACE_NAME})

    if(NOT Boost_FOUND OR NOT Boost_RANDOM_FOUND)
        find_package(Boost COMPONENTS REQUIRED random)
    endif()

    foreach(TARGET_POSTFIX ${TARGET_POSTFIXES})
        string(TOUPPER ${TARGET_POSTFIX} UPPER_TARGET_POSTFIX)
        if((${TARGET_POSTFIX} STREQUAL "tr1l") OR (${TARGET_POSTFIX} STREQUAL "c99l"))
            if(LONG_DOUBLE_SUPPORT_COMPILED)
                add_library(${CMAKE_WORKSPACE_NAME}_${CURRENT_PROJECT_NAME}_${TARGET_POSTFIX} ${${UPPER_TARGET_POSTFIX}_SOURCES})
                list(APPEND TARGET_NAMES ${CMAKE_WORKSPACE_NAME}_${CURRENT_PROJECT_NAME}_${TARGET_POSTFIX})
            else()
                continue()
            endif()
        else()
            add_library(${CMAKE_WORKSPACE_NAME}_${CURRENT_PROJECT_NAME}_${TARGET_POSTFIX} ${${UPPER_TARGET_POSTFIX}_SOURCES})
            list(APPEND TARGET_NAMES ${CMAKE_WORKSPACE_NAME}_${CURRENT_PROJECT_NAME}_${TARGET_POSTFIX})
        endif()
        set_property(TARGET ${CMAKE_WORKSPACE_NAME}_${CURRENT_PROJECT_NAME}_${TARGET_POSTFIX} PROPERTY EXPORT_NAME
                     ${CURRENT_PROJECT_NAME}_${TARGET_POSTFIX})
        target_link_libraries(${CMAKE_WORKSPACE_NAME}_${CURRENT_PROJECT_NAME}_${TARGET_POSTFIX} INTERFACE
                              main_pch ${Boost_LIBRARIES})
        target_include_directories(${CMAKE_WORKSPACE_NAME}_${CURRENT_PROJECT_NAME}_${TARGET_POSTFIX} PRIVATE
                                   $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/include>
                                   $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/src/tr1>
                                   $<BUILD_INTERFACE:${CMAKE_BINARY_DIR}/include>

                                   ${Boost_INCLUDE_DIRS})
        get_target_property(target_type ${CMAKE_WORKSPACE_NAME}_${CURRENT_PROJECT_NAME}_${TARGET_POSTFIX} TYPE)
        if(target_type STREQUAL "SHARED_LIB")
            target_compile_definitions(${CMAKE_WORKSPACE_NAME}_${CURRENT_PROJECT_NAME}_${TARGET_POSTFIX} PRIVATE BOOST_MATH_TR1_DYN_LINK)
        elseif(target_type STREQUAL "STATIC_LIB")

        endif()
    endforeach()
endif()

cm_deploy(TARGETS ${TARGET_NAMES}
          INCLUDE ${CURRENT_SOURCES_DIR}/include ${CURRENT_SOURCES_DIR}/src/tr1
          NAMESPACE ${CMAKE_WORKSPACE_NAME}::)

if(BUILD_TESTS)
    add_subdirectory(test)
endif()

if(BUILD_TOOLS)
    add_subdirectory(tools)
endif()
