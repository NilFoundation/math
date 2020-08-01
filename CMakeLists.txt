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
    ${CMAKE_CURRENT_LIST_DIR}/src/acosh.cpp
    ${CMAKE_CURRENT_LIST_DIR}/src/asinh.cpp
    ${CMAKE_CURRENT_LIST_DIR}/src/atanh.cpp
    ${CMAKE_CURRENT_LIST_DIR}/src/cbrt.cpp
    ${CMAKE_CURRENT_LIST_DIR}/src/copysign.cpp
    ${CMAKE_CURRENT_LIST_DIR}/src/erfc.cpp
    ${CMAKE_CURRENT_LIST_DIR}/src/erf.cpp
    ${CMAKE_CURRENT_LIST_DIR}/src/expm1.cpp
    ${CMAKE_CURRENT_LIST_DIR}/src/fmax.cpp
    ${CMAKE_CURRENT_LIST_DIR}/src/fmin.cpp
    ${CMAKE_CURRENT_LIST_DIR}/src/fpclassify.cpp
    ${CMAKE_CURRENT_LIST_DIR}/src/hypot.cpp
    ${CMAKE_CURRENT_LIST_DIR}/src/lgamma.cpp
    ${CMAKE_CURRENT_LIST_DIR}/src/llround.cpp
    ${CMAKE_CURRENT_LIST_DIR}/src/log1p.cpp
    ${CMAKE_CURRENT_LIST_DIR}/src/lround.cpp
    ${CMAKE_CURRENT_LIST_DIR}/src/nextafter.cpp
    ${CMAKE_CURRENT_LIST_DIR}/src/nexttoward.cpp
    ${CMAKE_CURRENT_LIST_DIR}/src/round.cpp
    ${CMAKE_CURRENT_LIST_DIR}/src/tgamma.cpp
    ${CMAKE_CURRENT_LIST_DIR}/src/trunc.cpp)

set(C99F_SOURCES
    ${CMAKE_CURRENT_LIST_DIR}/src/acoshf.cpp
    ${CMAKE_CURRENT_LIST_DIR}/src/asinhf.cpp
    ${CMAKE_CURRENT_LIST_DIR}/src/atanhf.cpp
    ${CMAKE_CURRENT_LIST_DIR}/src/cbrtf.cpp
    ${CMAKE_CURRENT_LIST_DIR}/src/copysignf.cpp
    ${CMAKE_CURRENT_LIST_DIR}/src/erfcf.cpp
    ${CMAKE_CURRENT_LIST_DIR}/src/erff.cpp
    ${CMAKE_CURRENT_LIST_DIR}/src/expm1f.cpp
    ${CMAKE_CURRENT_LIST_DIR}/src/fmaxf.cpp
    ${CMAKE_CURRENT_LIST_DIR}/src/fminf.cpp
    ${CMAKE_CURRENT_LIST_DIR}/src/fpclassifyf.cpp
    ${CMAKE_CURRENT_LIST_DIR}/src/hypotf.cpp
    ${CMAKE_CURRENT_LIST_DIR}/src/lgammaf.cpp
    ${CMAKE_CURRENT_LIST_DIR}/src/llroundf.cpp
    ${CMAKE_CURRENT_LIST_DIR}/src/log1pf.cpp
    ${CMAKE_CURRENT_LIST_DIR}/src/lroundf.cpp
    ${CMAKE_CURRENT_LIST_DIR}/src/nextafterf.cpp
    ${CMAKE_CURRENT_LIST_DIR}/src/nexttowardf.cpp
    ${CMAKE_CURRENT_LIST_DIR}/src/roundf.cpp
    ${CMAKE_CURRENT_LIST_DIR}/src/tgammaf.cpp
    ${CMAKE_CURRENT_LIST_DIR}/src/truncf.cpp)

set(C99L_SOURCES
    ${CMAKE_CURRENT_LIST_DIR}/src/acoshl.cpp
    ${CMAKE_CURRENT_LIST_DIR}/src/asinhl.cpp
    ${CMAKE_CURRENT_LIST_DIR}/src/atanhl.cpp
    ${CMAKE_CURRENT_LIST_DIR}/src/cbrtl.cpp
    ${CMAKE_CURRENT_LIST_DIR}/src/copysignl.cpp
    ${CMAKE_CURRENT_LIST_DIR}/src/erfcl.cpp
    ${CMAKE_CURRENT_LIST_DIR}/src/erfl.cpp
    ${CMAKE_CURRENT_LIST_DIR}/src/expm1l.cpp
    ${CMAKE_CURRENT_LIST_DIR}/src/fmaxl.cpp
    ${CMAKE_CURRENT_LIST_DIR}/src/fminl.cpp
    ${CMAKE_CURRENT_LIST_DIR}/src/fpclassifyl.cpp
    ${CMAKE_CURRENT_LIST_DIR}/src/hypotl.cpp
    ${CMAKE_CURRENT_LIST_DIR}/src/lgammal.cpp
    ${CMAKE_CURRENT_LIST_DIR}/src/llroundl.cpp
    ${CMAKE_CURRENT_LIST_DIR}/src/log1pl.cpp
    ${CMAKE_CURRENT_LIST_DIR}/src/lroundl.cpp
    ${CMAKE_CURRENT_LIST_DIR}/src/nextafterl.cpp
    ${CMAKE_CURRENT_LIST_DIR}/src/nexttowardl.cpp
    ${CMAKE_CURRENT_LIST_DIR}/src/roundl.cpp
    ${CMAKE_CURRENT_LIST_DIR}/src/tgammal.cpp
    ${CMAKE_CURRENT_LIST_DIR}/src/truncl.cpp)

set(TR1_SOURCES
    ${CMAKE_CURRENT_LIST_DIR}/src/assoc_laguerre.cpp
    ${CMAKE_CURRENT_LIST_DIR}/src/assoc_legendre.cpp
    ${CMAKE_CURRENT_LIST_DIR}/src/beta.cpp
    ${CMAKE_CURRENT_LIST_DIR}/src/comp_ellint_1.cpp
    ${CMAKE_CURRENT_LIST_DIR}/src/comp_ellint_2.cpp
    ${CMAKE_CURRENT_LIST_DIR}/src/comp_ellint_3.cpp
    ${CMAKE_CURRENT_LIST_DIR}/src/cyl_bessel_i.cpp
    ${CMAKE_CURRENT_LIST_DIR}/src/cyl_bessel_j.cpp
    ${CMAKE_CURRENT_LIST_DIR}/src/cyl_bessel_k.cpp
    ${CMAKE_CURRENT_LIST_DIR}/src/cyl_neumann.cpp
    ${CMAKE_CURRENT_LIST_DIR}/src/ellint_1.cpp
    ${CMAKE_CURRENT_LIST_DIR}/src/ellint_2.cpp
    ${CMAKE_CURRENT_LIST_DIR}/src/ellint_3.cpp
    ${CMAKE_CURRENT_LIST_DIR}/src/expint.cpp
    ${CMAKE_CURRENT_LIST_DIR}/src/hermite.cpp
    ${CMAKE_CURRENT_LIST_DIR}/src/laguerre.cpp
    ${CMAKE_CURRENT_LIST_DIR}/src/legendre.cpp
    ${CMAKE_CURRENT_LIST_DIR}/src/riemann_zeta.cpp
    ${CMAKE_CURRENT_LIST_DIR}/src/sph_bessel.cpp
    ${CMAKE_CURRENT_LIST_DIR}/src/sph_legendre.cpp
    ${CMAKE_CURRENT_LIST_DIR}/src/sph_neumann.cpp)

set(TR1F_SOURCES
    ${CMAKE_CURRENT_LIST_DIR}/src/assoc_laguerref.cpp
    ${CMAKE_CURRENT_LIST_DIR}/src/assoc_legendref.cpp
    ${CMAKE_CURRENT_LIST_DIR}/src/betaf.cpp
    ${CMAKE_CURRENT_LIST_DIR}/src/comp_ellint_1f.cpp
    ${CMAKE_CURRENT_LIST_DIR}/src/comp_ellint_2f.cpp
    ${CMAKE_CURRENT_LIST_DIR}/src/comp_ellint_3f.cpp
    ${CMAKE_CURRENT_LIST_DIR}/src/cyl_bessel_if.cpp
    ${CMAKE_CURRENT_LIST_DIR}/src/cyl_bessel_jf.cpp
    ${CMAKE_CURRENT_LIST_DIR}/src/cyl_bessel_kf.cpp
    ${CMAKE_CURRENT_LIST_DIR}/src/cyl_neumannf.cpp
    ${CMAKE_CURRENT_LIST_DIR}/src/ellint_1f.cpp
    ${CMAKE_CURRENT_LIST_DIR}/src/ellint_2f.cpp
    ${CMAKE_CURRENT_LIST_DIR}/src/ellint_3f.cpp
    ${CMAKE_CURRENT_LIST_DIR}/src/expintf.cpp
    ${CMAKE_CURRENT_LIST_DIR}/src/hermitef.cpp
    ${CMAKE_CURRENT_LIST_DIR}/src/laguerref.cpp
    ${CMAKE_CURRENT_LIST_DIR}/src/legendref.cpp
    ${CMAKE_CURRENT_LIST_DIR}/src/riemann_zetaf.cpp
    ${CMAKE_CURRENT_LIST_DIR}/src/sph_besself.cpp
    ${CMAKE_CURRENT_LIST_DIR}/src/sph_legendref.cpp
    ${CMAKE_CURRENT_LIST_DIR}/src/sph_neumannf.cpp)

set(TR1F_SOURCES
    ${CMAKE_CURRENT_LIST_DIR}/src/assoc_laguerrefl.cpp
    ${CMAKE_CURRENT_LIST_DIR}/src/assoc_legendrefl.cpp
    ${CMAKE_CURRENT_LIST_DIR}/src/betafl.cpp
    ${CMAKE_CURRENT_LIST_DIR}/src/comp_ellint_1fl.cpp
    ${CMAKE_CURRENT_LIST_DIR}/src/comp_ellint_2fl.cpp
    ${CMAKE_CURRENT_LIST_DIR}/src/comp_ellint_3fl.cpp
    ${CMAKE_CURRENT_LIST_DIR}/src/cyl_bessel_ifl.cpp
    ${CMAKE_CURRENT_LIST_DIR}/src/cyl_bessel_jfl.cpp
    ${CMAKE_CURRENT_LIST_DIR}/src/cyl_bessel_kfl.cpp
    ${CMAKE_CURRENT_LIST_DIR}/src/cyl_neumannfl.cpp
    ${CMAKE_CURRENT_LIST_DIR}/src/ellint_1fl.cpp
    ${CMAKE_CURRENT_LIST_DIR}/src/ellint_2fl.cpp
    ${CMAKE_CURRENT_LIST_DIR}/src/ellint_3fl.cpp
    ${CMAKE_CURRENT_LIST_DIR}/src/expintfl.cpp
    ${CMAKE_CURRENT_LIST_DIR}/src/hermitefl.cpp
    ${CMAKE_CURRENT_LIST_DIR}/src/laguerrefl.cpp
    ${CMAKE_CURRENT_LIST_DIR}/src/legendrefl.cpp
    ${CMAKE_CURRENT_LIST_DIR}/src/riemann_zetafl.cpp
    ${CMAKE_CURRENT_LIST_DIR}/src/sph_besselfl.cpp
    ${CMAKE_CURRENT_LIST_DIR}/src/sph_legendrefl.cpp
    ${CMAKE_CURRENT_LIST_DIR}/src/sph_neumannfl.cpp)

add_library(main_pch SHARED ${CMAKE_CURRENT_LIST_DIR}/src/tr1/pch.hpp)
target_include_directories(main_pch PRIVATE ${CMAKE_CURRENT_LIST_DIR}/src/tr1)
target_compile_definitions(main_pch PRIVATE BOOST_MATH_TR1_DYN_LINK)
set_property(TARGET main_pch PROPERTY LINKER_LANGUAGE CXX)
target_link_libraries(main_pch PRIVATE Boost::unit_test_framework)

set(${CMAKE_WORKSPACE_NAME}_${CURRENT_PROJECT_NAME}_TARGET_NAMES c99 c99f c99l tr1 tr1f tr1l)

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

    foreach(TARGET_POSTFIX ${${CMAKE_WORKSPACE_NAME}_${CURRENT_PROJECT_NAME}_TARGET_NAMES})
        string(TOUPPER ${TARGET_POSTFIX} UPPER_TARGET_POSTFIX)
        if((${TARGET_POSTFIX} STREQUAL "tr1l") OR (${TARGET_POSTFIX} STREQUAL "c99l"))
            if(LONG_DOUBLE_SUPPORT_COMPILED)
                add_library(${CMAKE_WORKSPACE_NAME}_${CURRENT_PROJECT_NAME}_${TARGET_POSTFIX} ${${UPPER_TARGET_POSTFIX}_SOURCES})
            else()
                continue()
            endif()
        else()
            add_library(${CMAKE_WORKSPACE_NAME}_${CURRENT_PROJECT_NAME}_${TARGET_POSTFIX} ${${UPPER_TARGET_POSTFIX}_SOURCES})
        endif()
        set_property(TARGET ${CMAKE_WORKSPACE_NAME}_${CURRENT_PROJECT_NAME}_${TARGET_POSTFIX} PROPERTY EXPORT_NAME
                     ${CURRENT_PROJECT_NAME}_${TARGET_POSTFIX})
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
            target_compile_definitions(block_${name}_test PRIVATE BOOST_MATH_TR1_DYN_LINK)
        elseif(target_type STREQUAL "STATIC_LIB")

        endif()
    endforeach()
else()
    cm_workspace(boost SOURCES_DIR ${CMAKE_CURRENT_LIST_DIR})

    cm_project(math WORKSPACE_NAME ${CMAKE_WORKSPACE_NAME})

    find_package(Boost COMPONENTS REQUIRED random)

    foreach(TARGET_POSTFIX ${${CMAKE_WORKSPACE_NAME}_${CURRENT_PROJECT_NAME}_TARGET_NAMES})
        string(TOUPPER ${TARGET_POSTFIX} UPPER_TARGET_POSTFIX)
        if((${TARGET_POSTFIX} STREQUAL "tr1l") OR (${TARGET_POSTFIX} STREQUAL "c99l"))
            if(LONG_DOUBLE_SUPPORT_COMPILED)
                add_library(${CMAKE_WORKSPACE_NAME}_${CURRENT_PROJECT_NAME}_${TARGET_POSTFIX} ${${UPPER_TARGET_POSTFIX}_SOURCES})
            else()
                continue()
            endif()
        else()
            add_library(${CMAKE_WORKSPACE_NAME}_${CURRENT_PROJECT_NAME}_${TARGET_POSTFIX} ${${UPPER_TARGET_POSTFIX}_SOURCES})
        endif()
        set_property(TARGET ${CMAKE_WORKSPACE_NAME}_${CURRENT_PROJECT_NAME}_${TARGET_POSTFIX} PROPERTY EXPORT_NAME
                     ${CURRENT_PROJECT_NAME}_${TARGET_POSTFIX})
        target_link_libraries(${CMAKE_WORKSPACE_NAME}_${CURRENT_PROJECT_NAME}_${TARGET_POSTFIX} INTERFACE main_pch ${Boost_LIBRARIES})
        get_target_property(target_type ${CMAKE_WORKSPACE_NAME}_${CURRENT_PROJECT_NAME}_${TARGET_POSTFIX} TYPE)
        if(target_type STREQUAL "SHARED_LIB")
            target_compile_definitions(block_${name}_test PRIVATE BOOST_MATH_TR1_DYN_LINK)
        elseif(target_type STREQUAL "STATIC_LIB")

        endif()
        cm_deploy(TARGETS ${CMAKE_WORKSPACE_NAME}_${CURRENT_PROJECT_NAME}_${TARGET_POSTFIX}
                  INCLUDE ${CURRENT_SOURCES_DIR}/include
                  NAMESPACE ${CMAKE_WORKSPACE_NAME}::)
    endforeach()
endif()

if(BUILD_TESTS)
    add_subdirectory(test)
endif()
