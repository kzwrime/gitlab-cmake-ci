install(
    TARGETS repo1_exe
    RUNTIME COMPONENT repo1_Runtime
)

if(PROJECT_IS_TOP_LEVEL)
  include(CPack)
endif()
