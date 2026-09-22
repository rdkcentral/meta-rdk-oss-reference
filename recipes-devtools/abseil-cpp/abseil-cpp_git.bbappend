PACKAGE_BEFORE_PN += "${PN}-extras"

FILES:${PN}-extras =  "\
                        ${libdir}/libabsl_bad_any_cast_impl.so.0 \
                        ${libdir}/libabsl_civil_time.so.0 \
                        ${libdir}/libabsl_cordz_sample_token.so.0 \
                        ${libdir}/libabsl_examine_stack.so.0 \
                        ${libdir}/libabsl_failure_signal_handler.so.0 \
                        ${libdir}/libabsl_flags.so.0 \
                        ${libdir}/libabsl_flags_commandlineflag.so.0 \
                        ${libdir}/libabsl_flags_commandlineflag_internal.so.0 \
                        ${libdir}/libabsl_flags_config.so.0 \
                        ${libdir}/libabsl_flags_internal.so.0 \
                        ${libdir}/libabsl_flags_marshalling.so.0 \
                        ${libdir}/libabsl_flags_parse.so.0 \
                        ${libdir}/libabsl_flags_private_handle_accessor.so.0 \
                        ${libdir}/libabsl_flags_program_name.so.0 \
                        ${libdir}/libabsl_flags_reflection.so.0 \
                        ${libdir}/libabsl_flags_usage.so.0 \
                        ${libdir}/libabsl_flags_usage_internal.so.0 \
                        ${libdir}/libabsl_hashtablez_sampler.so.0 \
                        ${libdir}/libabsl_leak_check.so.0 \
                        ${libdir}/libabsl_log_severity.so.0 \
                        ${libdir}/libabsl_periodic_sampler.so.0 \
                        ${libdir}/libabsl_random_distributions.so.0 \ 
                        ${libdir}/libabsl_random_internal_distribution_test_util.so.0 \
                        ${libdir}/libabsl_random_internal_randen_hwaes.so.0 \
                        ${libdir}/libabsl_random_internal_randen_hwaes_impl.so.0 \
                        ${libdir}/libabsl_random_seed_sequences.so.0 \
                        ${libdir}/libabsl_scoped_set_env.so.0 \
"
