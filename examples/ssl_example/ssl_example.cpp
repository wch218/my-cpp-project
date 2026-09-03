#include <openssl/sha.h>
#include <iostream>
#include <iomanip>
#include <string>

int main() {
    std::string data = "hello";
    unsigned char hash[SHA256_DIGEST_LENGTH];
    SHA256(reinterpret_cast<const unsigned char*>(data.c_str()), data.size(), hash);
    std::cout << "SHA256(\"" << data << "\") = ";
    for(int i = 0; i < SHA256_DIGEST_LENGTH; ++i)
        std::cout << std::hex << std::setw(2) << std::setfill('0') << (int)hash[i];
    std::cout << std::dec << "\n";
    return 0;
}
