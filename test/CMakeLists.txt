# Parent project does not export its library target, so this CML implicitly
# depends on being added from it, i.e. the testing is done only from the build
# tree and is not feasible from an install location

project(repo1Tests LANGUAGES CXX)

# ---- common ctest ----


# ---- googletest ----
add_executable(
  repo1_gtest
  source/repo1_gtest1.cpp
  source/repo1_gtest2.cpp
)
target_link_libraries(
  repo1_gtest PRIVATE
  gtest_main repo1_lib
)
target_compile_features(repo1_gtest PRIVATE cxx_std_17)

include(GoogleTest)
gtest_discover_tests(repo1_gtest)

# ---- End-of-file commands ----

add_folders(Test)
