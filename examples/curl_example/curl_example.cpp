#include <curl/curl.h>
#include <iostream>

static size_t write_callback(void* contents, size_t size, size_t nmemb, void* userp) {
    size_t total = size * nmemb;
    std::string* s = static_cast<std::string*>(userp);
    s->append(static_cast<char*>(contents), total);
    return total;
}

int main() {
    CURL* curl = curl_easy_init();
    if(!curl) {
        std::cerr << "curl init failed\n";
        return 1;
    }
    std::string response;
    curl_easy_setopt(curl, CURLOPT_URL, "https://httpbin.org/get");
    curl_easy_setopt(curl, CURLOPT_WRITEFUNCTION, write_callback);
    curl_easy_setopt(curl, CURLOPT_WRITEDATA, &response);
    CURLcode res = curl_easy_perform(curl);
    if(res != CURLE_OK) {
        std::cerr << "curl failed: " << curl_easy_strerror(res) << "\n";
    } else {
        std::cout << "Response snippet: " << response.substr(0, 200) << "...\n";
    }
    curl_easy_cleanup(curl);
    return 0;
}
