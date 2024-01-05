# ---- Variables ----

# We use variables separate from what CTest uses, because those have
# customization issues
set(
    COVERAGE_TRACE_COMMAND
    lcov -c -q
    -o "${PROJECT_BINARY_DIR}/coverage.info"
    -d "${PROJECT_BINARY_DIR}"
    --include "${PROJECT_SOURCE_DIR}/source/*" 
    --include "${PROJECT_SOURCE_DIR}/test/*"
    # --exclude "${PROJECT_SOURCE_DIR}/third_party/*"
    CACHE STRING
    "; separated command to generate a trace for the 'coverage' target"
)

set(
    COVERAGE_TRACE_COMMAND_GCOVR
    gcovr --xml-pretty --exclude-unreachable-branches --print-summary
    -o "${PROJECT_BINARY_DIR}/coverage.xml"
    --root "${PROJECT_SOURCE_DIR}"
    --filter "${PROJECT_SOURCE_DIR}/source/*" 
    --filter "${PROJECT_SOURCE_DIR}/test/*"
    CACHE STRING
    "; separated command to generate a trace for the 'coverage' target"
)

set(
    COVERAGE_HTML_COMMAND_GCOVR
    gcovr --html-details
    -o "${PROJECT_BINARY_DIR}/index.html"
    --root "${PROJECT_SOURCE_DIR}"
    --filter "${PROJECT_SOURCE_DIR}/source/*" 
    --filter "${PROJECT_SOURCE_DIR}/test/*"
    CACHE STRING
    "; separated command to generate a trace for the 'coverage' target"
)

set(
    COVERAGE_LINE_COMMAND_GCOVR
    gcovr
    --root "${PROJECT_SOURCE_DIR}"
    --filter "${PROJECT_SOURCE_DIR}/source/*" 
    --filter "${PROJECT_SOURCE_DIR}/test/*"
    CACHE STRING
    "; separated command to generate a trace for the 'coverage' target"
)

set(
    COVERAGE_HTML_COMMAND
    genhtml --legend -f -q
    "${PROJECT_BINARY_DIR}/coverage.info"
    -p "${PROJECT_SOURCE_DIR}"
    -o "${PROJECT_BINARY_DIR}/coverage_html"
    CACHE STRING
    "; separated command to generate an HTML report for the 'coverage' target"
)

# ---- Coverage target ----

add_custom_target(
    coverage
    COMMAND ${COVERAGE_TRACE_COMMAND}
    COMMAND ${COVERAGE_TRACE_COMMAND_GCOVR}
    COMMAND ${COVERAGE_HTML_COMMAND}
    COMMAND ${COVERAGE_HTML_COMMAND_GCOVR}
    COMMAND ${COVERAGE_LINE_COMMAND_GCOVR}
    COMMENT "Generating coverage report"
    VERBATIM
)
