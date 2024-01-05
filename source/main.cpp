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

  // // warning
  // std::string naMe = lib.name;
  // // error
  // int a[3] = {0};
  // std::cout << a[3] << '\n';
  return 0;
}
