#include <iostream>

#include "lib.hpp"

library::library()
    : name {"repo1"}
{
  if (name == "repo1") {
    std::cout << "Create library with name = repo1\n";
  } else {
    std::cout << "Create library\n";
  }
}
