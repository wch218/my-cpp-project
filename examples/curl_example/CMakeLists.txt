cmake_minimum_required(VERSION 3.16)
project(curl_example)

find_package(CURL REQUIRED)
add_executable(curl_example curl_example.cpp)
target_link_libraries(curl_example PRIVATE CURL::libcurl)
