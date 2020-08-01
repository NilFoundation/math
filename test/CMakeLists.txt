#---------------------------------------------------------------------------#
# Copyright (c) 2018-2020 Mikhail Komarov <nemo@nil.foundation>
# Copyright (c) 2018-2020 Alexey Moskvin
#
# Distributed under the Boost Software License, Version 1.0
# See accompanying file LICENSE_1_0.txt or copy at
# http://www.boost.org/LICENSE_1_0.txt
#---------------------------------------------------------------------------#

include(CMTest)

if(BOOST_CMAKE)
    find_package(${CMAKE_WORKSPACE_NAME}_algorithm)
    find_package(${CMAKE_WORKSPACE_NAME}_chrono)
    find_package(${CMAKE_WORKSPACE_NAME}_exception)
    find_package(${CMAKE_WORKSPACE_NAME}_timer)
    find_package(${CMAKE_WORKSPACE_NAME}_numeric_ublas)
    find_package(${CMAKE_WORKSPACE_NAME}_filesystem)
    find_package(${CMAKE_WORKSPACE_NAME}_test)
    find_package(${CMAKE_WORKSPACE_NAME}_serialization)
    find_package(${CMAKE_WORKSPACE_NAME}_numeric_interval)
    find_package(${CMAKE_WORKSPACE_NAME}_detail)
    find_package(${CMAKE_WORKSPACE_NAME}_throw_exception)
    find_package(${CMAKE_WORKSPACE_NAME}_math)
    find_package(${CMAKE_WORKSPACE_NAME}_regexp)

    cm_test_link_libraries(${CMAKE_WORKSPACE_NAME}_math
                           ${CMAKE_WORKSPACE_NAME}::algorithm
                           ${CMAKE_WORKSPACE_NAME}::chrono
                           ${CMAKE_WORKSPACE_NAME}::exception
                           ${CMAKE_WORKSPACE_NAME}::timer
                           ${CMAKE_WORKSPACE_NAME}::numeric_ublas
                           ${CMAKE_WORKSPACE_NAME}::filesystem
                           ${CMAKE_WORKSPACE_NAME}::test
                           ${CMAKE_WORKSPACE_NAME}::serialization
                           ${CMAKE_WORKSPACE_NAME}::numeric_interval
                           ${CMAKE_WORKSPACE_NAME}::detail
                           ${CMAKE_WORKSPACE_NAME}::throw_exception
                           ${CMAKE_WORKSPACE_NAME}::math
                           ${CMAKE_WORKSPACE_NAME}::regexp)
else()
    find_package(Boost REQUIRED COMPONENTS chrono filesystem unit_test_framework serialization regex)
    find_package(Boost COMPONENTS timer exception)

    cm_test_link_libraries(${CMAKE_WORKSPACE_NAME}_${CURRENT_PROJECT_NAME}
                           ${Boost_LIBRARIES})

    include_directories("${CMAKE_CURRENT_SOURCE_DIR}/../include"
                        "${CMAKE_CURRENT_BINARY_DIR}/include"

                        ${Boost_INCLUDE_DIRS})
endif()

add_custom_target(${CURRENT_PROJECT_NAME}_test_suite_special_fun)
add_custom_target(${CURRENT_PROJECT_NAME}_test_suite_distribution_tests)
add_custom_target(${CURRENT_PROJECT_NAME}_test_suite_quadrature)
add_custom_target(${CURRENT_PROJECT_NAME}_test_suite_long_running_tests)
add_custom_target(${CURRENT_PROJECT_NAME}_test_suite_misc)
add_custom_target(${CURRENT_PROJECT_NAME}_test_suite_float128_tests)

# copyright John Maddock 2011
# Distributed under the Boost Software License, Version 1.0.
# (See accompanying file LICENSE_1_0.txt or copy at
# http://www.boost.org/LICENSE_1_0.txt.

# HACK: Workaround broken includes
file(GLOB TEST_HEADERS RELATIVE ${CMAKE_CURRENT_SOURCE_DIR} ${CMAKE_CURRENT_SOURCE_DIR}/*.hpp ${CMAKE_CURRENT_SOURCE_DIR}/*.ipp)
set(CMAKE_INCLUDE_CURRENT_DIR TRUE)
foreach(HEADER ${TEST_HEADERS})
    configure_file(${HEADER} ${CMAKE_CURRENT_BINARY_DIR}/libs/${CURRENT_PROJECT_NAME}/test/${HEADER}
                   @ONLY)
endforeach()

add_library(${CURRENT_PROJECT_NAME}_test_settings INTERFACE)
target_include_directories(${CURRENT_PROJECT_NAME}_test_settings INTERFACE ${CURRENT_TEST_SOURCES_DIR}/include)
cm_test_link_libraries(${CURRENT_PROJECT_NAME}_test_settings)

# We set these to make it easier to set up and test GMP and MPFR under Win32:
# Speed up compiles:
# We can't yet enable this - it breaks the STL in some tests...
#<toolset>msvc,<optimization>off:<cxxflags>-RTCc
#<toolset>msvc,<optimization>off:<define>_ALLOW_RTCc_IN_STL

# add_library(no_eh_support STATIC no_eh_support.cpp)
# cm_mark_as_test(no_eh_support)
# target_link_libraries(no_eh_support boost_throw_exception)
# cm_target_link_test_libs(no_eh_support)

#cm_test(NAME GMP_MY SOURCES ${CURRENT_TEST_SOURCES_DIR}/../config/has_float128.cpp)
#target_link_libraries(GMP_MY ${Quadmath_LIBRARY})
#target_include_directories(GMP_MY PRIVATE ${Quadmath_INCLUDE_DIR})

add_library(pch INTERFACE ${CURRENT_TEST_SOURCES_DIR}/pch.hpp)
target_link_libraries(pch INTERFACE Boost::unit_test_framework)

add_library(pch_light INTERFACE ${CURRENT_TEST_SOURCES_DIR}/pch_light.hpp)
target_link_libraries(pch_light INTERFACE Boost::unit_test_framework)

cm_test(NAME compile_test_main SOURCES compile_test/main.cpp COMPILE_ONLY WILL_FAIL)

include_directories(${CMAKE_WORKSPACE_SOURCES_DIR})