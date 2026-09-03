#include <gtest/gtest.h>
#include "lib.h"

TEST(AddTest, Positive) {
    EXPECT_EQ(add(2, 3), 5);
}

TEST(AddTest, Negative) {
    EXPECT_EQ(add(-1, 1), 0);
}
