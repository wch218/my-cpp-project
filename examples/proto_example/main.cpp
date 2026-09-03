#include "echo.pb.h"
#include <iostream>

int main() {
    example::Echo e;
    e.set_text("hello protobuf");
    std::string out = e.SerializeAsString();
    example::Echo r;
    if (r.ParseFromString(out)) {
        std::cout << "Echo.text = " << r.text() << "\n";
        return 0;
    }
    return 1;
}
