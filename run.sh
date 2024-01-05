export PROJECT_HOME=$(pwd)

# 格式检查
cmake -D FORMAT_COMMAND=clang-format-14 -P cmake/lint.cmake
# 拼写检查
cmake -P cmake/spell.cmake

# develop mode
cmake --preset=dev  # config

# 静态检查（clang-tidy 和 cppcheck）及编译
cmake --build --preset=dev

# 使用 googletest 测试
./build/dev/test/repo1_gtest

# run
./build/dev/repo1


# coverage mode，专用于覆盖率测试，会造成 -Og
cmake --preset=dev-coverage # config

export PROJECT_HOME=$(pwd)
cmake --build build/coverage -j 8
cd build/coverage && ctest --output-on-failure --no-tests=error -j 8
cd $PROJECT_HOME
cmake --build build/coverage -t coverage # 进行代码覆盖率统计

# lcov 输出，略微简洁美观一些
python3 -m http.server --directory ./build/coverage/coverage_html/ 8999

# gcovr 输出，包含分支覆盖率，更齐全
python3 -m http.server --directory ./build/coverage/ 8999