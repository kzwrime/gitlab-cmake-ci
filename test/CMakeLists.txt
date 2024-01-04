# Parent project does not export its library target, so this CML implicitly
# depends on being added from it, i.e. the testing is done only from the build
# tree and is not feasible from an install location

project(repo1Tests LANGUAGES CXX)

# ---- Tests ----

add_executable(repo1_test source/repo1_test.cpp)
target_link_libraries(repo1_test PRIVATE repo1_lib)
target_compile_features(repo1_test PRIVATE cxx_std_17)

add_test(NAME repo1_test COMMAND repo1_test)

# ---- End-of-file commands ----

add_folders(Test)
