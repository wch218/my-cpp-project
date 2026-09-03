cmake_minimum_required(VERSION 3.16)
project(ssl_example)

find_package(OpenSSL REQUIRED)
add_executable(ssl_example ssl_example.cpp)
target_link_libraries(ssl_example PRIVATE OpenSSL::SSL OpenSSL::Crypto)
