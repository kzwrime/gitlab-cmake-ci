# repo1

This is the repo1 project.

## 环境配置

Ubuntu

```bash
pip3 install codespell
sudo apt-get install cmake cpupcheck clang-format clang-tidy lcov gcovr
```

## 运行

```bash
export PROJECT_HOME=$(pwd)

# 格式检查
cmake -D FORMAT_COMMAND=clang-format -P cmake/lint.cmake
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


```

# 体验静态检查的效果

将 source/main.cpp 修改为

```cpp
#include <iostream>
#include <string>

#include "lib.hpp"

auto addsub(int aaa, int bbb) -> int
{
  if (aaa > 0) {
    return aaa + bbb;
  }
  return aaa - bbb;
}

auto main() -> int
{
  auto const lib = library {};
  auto const message = "Hello from " + lib.name + "!";
  std::cout << message << '\n';
  std::cout << "1 + 2 = " << addsub(1, 2) << '\n';

  // warning
  std::string naMe = lib.name;
  // error
  int a[3] = {0};
  std::cout << a[3] << '\n';
  return 0;
}
```

将能观察到如下的错误

```
[ 20%] Built target repo1_lib
Consolidate compiler generated dependencies of target repo1_exe
[ 60%] Built target repo1_test
[ 80%] Building CXX object CMakeFiles/repo1_exe.dir/source/main.cpp.o
/home/kunzh/projects/repo1/source/main.cpp:22:15: error: invalid case style for local variable 'naMe' [readability-identifier-naming,-warnings-as-errors]
  std::string naMe = lib.name;
              ^~~~
              na_me
/home/kunzh/projects/repo1/source/main.cpp:24:3: error: do not declare C-style arrays, use std::array<> instead [cppcoreguidelines-avoid-c-arrays,hicpp-avoid-c-arrays,modernize-avoid-c-arrays,-warnings-as-errors]
  int a[3] = {0};
  ^
/home/kunzh/projects/repo1/source/main.cpp:24:7: error: variable name 'a' is too short, expected at least 3 characters [readability-identifier-length,-warnings-as-errors]
  int a[3] = {0};
      ^
/home/kunzh/projects/repo1/source/main.cpp:25:16: error: array index 3 is past the end of the array (which contains 3 elements) [clang-diagnostic-array-bounds,-warnings-as-errors]
  std::cout << a[3] << '\n';
               ^ ~
/home/kunzh/projects/repo1/source/main.cpp:24:3: note: array 'a' declared here
  int a[3] = {0};
  ^
41101 warnings generated.
Suppressed 41095 warnings (41095 in non-user code).
Use -header-filter=.* to display errors from all non-system headers. Use -system-headers to display errors from system headers as well.
4 warnings treated as errors
gmake[2]: *** [CMakeFiles/repo1_exe.dir/build.make:76: CMakeFiles/repo1_exe.dir/source/main.cpp.o] Error 1
gmake[1]: *** [CMakeFiles/Makefile2:161: CMakeFiles/repo1_exe.dir/all] Error 2
gmake: *** [Makefile:166: all] Error 2
```


# Building and installing

See the [BUILDING](BUILDING.md) document.

# Contributing

See the [CONTRIBUTING](CONTRIBUTING.md) document.

# Licensing

<!--
Please go to https://choosealicense.com/licenses/ and choose a license that
fits your needs. The recommended license for a project of this type is the
GNU AGPLv3.
-->
