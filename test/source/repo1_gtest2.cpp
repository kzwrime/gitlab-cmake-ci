#include <gtest/gtest.h>

#include "lib.hpp"

// Demonstrate some basic assertions.

TEST(HelloTest2, BasicAssertions)
{
  // Expect two strings not to be equal.
  EXPECT_STRNE("hello", "world");
  // Expect equality.
  EXPECT_EQ(7 * 6, 42);

  auto const lib = library {};

  EXPECT_TRUE(lib.name == "repo1");
}