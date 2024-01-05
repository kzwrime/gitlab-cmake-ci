cmake_minimum_required(VERSION 3.14)

include(cmake/prelude.cmake)

project(
    repo1
    VERSION 0.1.0
    DESCRIPTION "Short description"
    HOMEPAGE_URL "https://example.com/"
    LANGUAGES CXX
)

include(cmake/project-is-top-level.cmake)
include(cmake/variables.cmake)

# External library, not affected by checking
add_subdirectory(third_party/googletest-1.14.0)

# Add checking
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} ${CMAKE_EXTRA_CXX_FLAGS}")
set(CMAKE_CXX_CPPCHECK "${CMAKE_EXTRA_CXX_CPPCHECK}")
set(CMAKE_CXX_CLANG_TIDY "${CMAKE_EXTRA_CXX_CLANG_TIDY}")

message(STATUS "CMAKE_CXX_FLAGS=${CMAKE_CXX_FLAGS}")

# ---- Declare library ----

add_library(
    repo1_lib OBJECT
    source/lib.cpp
)

target_include_directories(
    repo1_lib ${warning_guard}
    PUBLIC
    "$<BUILD_INTERFACE:${PROJECT_SOURCE_DIR}/source>"
)

target_compile_features(repo1_lib PUBLIC cxx_std_17)

# ---- Declare executable ----

add_executable(repo1_exe source/main.cpp)
add_executable(repo1::exe ALIAS repo1_exe)

set_property(TARGET repo1_exe PROPERTY OUTPUT_NAME repo1)

target_compile_features(repo1_exe PRIVATE cxx_std_17)

target_link_libraries(repo1_exe PRIVATE repo1_lib)

# ---- Install rules ----

if(NOT CMAKE_SKIP_INSTALL_RULES)
  include(cmake/install-rules.cmake)
endif()

# ---- Developer mode ----

if(NOT repo1_DEVELOPER_MODE)
  return()
elseif(NOT PROJECT_IS_TOP_LEVEL)
  message(
      AUTHOR_WARNING
      "Developer mode is intended for developers of repo1"
  )
endif()

include(cmake/dev-mode.cmake)
