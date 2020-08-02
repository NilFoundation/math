add_executable(bessel_data ${CMAKE_CURRENT_LIST_DIR}/bessel_data.cpp)

add_executable(ellint_f_data ${CMAKE_CURRENT_LIST_DIR}/ellint_f_data.cpp)

add_executable(heuman_lambda_data ${CMAKE_CURRENT_LIST_DIR}/heuman_lambda_data.cpp)

add_executable(hyp_2f2_data ${CMAKE_CURRENT_LIST_DIR}/hyp_2f2_data.cpp)

add_executable(laguerre_data ${CMAKE_CURRENT_LIST_DIR}/laguerre_data.cpp)

if(GMP_COMPILED OR MPFR_COMPILED)
    add_executable(bessel_derivative_data ${CMAKE_CURRENT_LIST_DIR}/bessel_derivative_data.cpp)
endif()

add_executable(ellint_k_data ${CMAKE_CURRENT_LIST_DIR}/ellint_k_data.cpp)

add_executable(hyp_0f2_data ${CMAKE_CURRENT_LIST_DIR}/hyp_0f2_data.cpp)

add_executable(hypergeometric_dist_data ${CMAKE_CURRENT_LIST_DIR}/hypergeometric_dist_data.cpp)

add_executable(legendre_data ${CMAKE_CURRENT_LIST_DIR}/legendre_data.cpp)

add_executable(beta_data ${CMAKE_CURRENT_LIST_DIR}/beta_data.cpp)

add_executable(ellint_pi2_data ${CMAKE_CURRENT_LIST_DIR}/ellint_pi2_data.cpp)

if(GMP_COMPILED OR MPFI_COMPILED OR MPFR_COMPILED)
    add_executable(hyp_1f1_big_data ${CMAKE_CURRENT_LIST_DIR}/hyp_1f1_big_data.cpp)
endif()

add_executable(ibeta_data ${CMAKE_CURRENT_LIST_DIR}/ibeta_data.cpp)

add_executable(log1p_expm1_data ${CMAKE_CURRENT_LIST_DIR}/log1p_expm1_data.cpp)

add_executable(carlson_ellint_data ${CMAKE_CURRENT_LIST_DIR}/carlson_ellint_data.cpp)

add_executable(ellint_pi3_data ${CMAKE_CURRENT_LIST_DIR}/ellint_pi3_data.cpp)

if(GMP_COMPILED OR MPFR_COMPILED OR MPFI_COMPILED)
    add_executable(hyp_1f1_data ${CMAKE_CURRENT_LIST_DIR}/hyp_1f1_data.cpp)
endif()

add_executable(ibeta_derivative_data ${CMAKE_CURRENT_LIST_DIR}/ibeta_derivative_data.cpp)

add_executable(sinc_data ${CMAKE_CURRENT_LIST_DIR}/sinc_data.cpp)

add_executable(cbrt_data ${CMAKE_CURRENT_LIST_DIR}/cbrt_data.cpp)

if(FLOAT128_COMPILED)
    add_executable(erf_data ${CMAKE_CURRENT_LIST_DIR}/erf_data.cpp)
endif()

if(GMP_COMPIED OR MPFR_COMPILED OR MPFI_COMPILED)
    add_executable(hyp_1f1_log_big_data ${CMAKE_CURRENT_LIST_DIR}/hyp_1f1_log_big_data.cpp)
endif()

if(FLOAT128_COMPILED)
    add_executable(ibeta_inv_data ${CMAKE_CURRENT_LIST_DIR}/ibeta_inv_data.cpp)
endif()

add_executable(spherical_harmonic_data ${CMAKE_CURRENT_LIST_DIR}/spherical_harmonic_data.cpp)

if(FLOAT128_COMPILED)
    add_executable(digamma_data ${CMAKE_CURRENT_LIST_DIR}/digamma_data.cpp)
endif()

add_executable(expint_data ${CMAKE_CURRENT_LIST_DIR}/expint_data.cpp)

if(GMP_COMPILED OR MPFR_COMPILED OR MPFI_COMPILED)
    add_executable(hyp_1f1_reg_big_data ${CMAKE_CURRENT_LIST_DIR}/hyp_1f1_reg_big_data.cpp)
endif()

if(FLOAT128_COMPILED)
    add_executable(ibeta_invab_data ${CMAKE_CURRENT_LIST_DIR}/ibeta_invab_data.cpp)
endif()

if(GMP_COMPILED OR MPFR_COMPILED)
    add_executable(tgamma_large_data ${CMAKE_CURRENT_LIST_DIR}/tgamma_large_data.cpp)
endif()

add_executable(ellint_d_data ${CMAKE_CURRENT_LIST_DIR}/ellint_d_data.cpp)

add_executable(expint_i_data ${CMAKE_CURRENT_LIST_DIR}/expint_i_data.cpp)

add_executable(hyp_1f2_data ${CMAKE_CURRENT_LIST_DIR}/hyp_1f2_data.cpp)

if(FLOAT128_COMPILED)
    add_executable(igamma_data igamma_data.cpp)
endif()

add_executable(tgamma_ratio_data tgamma_ratio_data.cpp)

add_executable(ellint_d2_data ellint_d2_data.cpp)

if(FLOAT128_COMPILED)
    add_executable(gamma_p_inva_data gamma_p_inva_data.cpp)
endif()

add_executable(hyp_2f0_data hyp_2f0_data.cpp)

add_executable(inv_hyp_data inv_hyp_data.cpp)

add_executable(trig_data trig_data.cpp)

add_executable(ellint_e_data ellint_e_data.cpp)

add_executable(hermite_data hermite_data.cpp)

add_executable(hyp_2f1_data hyp_2f1_data.cpp)

add_executable(jacobi_zeta_data jacobi_zeta_data.cpp)

add_executable(zeta_data zeta_data.cpp)

add_executable(generate_test_values generate_test_values.cpp)

add_executable(igamma_temme_large_coef igamma_temme_large_coef.cpp)

if(FLOAT128_COMPILED)
    add_executable(lanczos_generator lanczos_generator.cpp)
    target_link_libraries(lanczos_generator PRIVATE boost_chrono boost_system)
endif()

add_executable(factorial_tables factorial_tables.cpp)

add_executable(generate_rational_test generate_rational_test.cpp)

#for local source in [ glob *_data.cpp ] generate_test_values.cpp igamma_temme_large_coef.cpp lanczos_generator.cpp factorial_tables.cpp generate_rational_test.cpp
#{
#   add_executable($(source:B) : $(source) : [ check-target-builds ../../multiprecision/config//has_gmp : <define>HAS_GMP <source>gmp : <build>no ] [ check-target-builds ../../multiprecision/config//has_mpfr : <define>HAS_MPFR <source>mpfr : <build>no ] [ check-target-builds ../../multiprecision/config//has_mpfi : <define>HAS_MPFI <source>gmp <source>mpfr <source>mpfi ] ;
#   install $(source:B)_bin : $(source:B) : <location>bin ;
#}

add_executable(generate_rational_code generate_rational_code.cpp)
add_executable(process_perf_results process_perf_results.cpp)
target_link_libraries(process_perf_results boost_regex)

