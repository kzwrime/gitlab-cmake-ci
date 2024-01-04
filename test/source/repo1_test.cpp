#include "lib.hpp"

auto main() -> int
{
  auto const lib = library {};

  return lib.name == "repo1" ? 0 : 1;
}
