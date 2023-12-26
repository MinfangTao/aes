#include <iostream>
#include "cxxopts.hpp"
#include "aes.h"

int main(int argc, char* argv[]) {

    // using try catch to catch the exception
    try {


// parsing command-line parameters
        cxxopts::Options options("MyApp", "A brief description");

        options.add_options()
                ("d,debug", "Enable debugging") // a boolean switch
                ("h,help", "Print usage")
                ("m,model", "model",cxxopts::value<std::string>()->default_value("1"))
                ("k,key-file", "key file",cxxopts::value<std::string>()->default_value("1"))
                ("i,input-file", "input file",cxxopts::value<std::string>()->default_value("1"))
                ("o,output-file", "output file",cxxopts::value<std::string>()->default_value("1"));

        // Parse command line arguments
        auto result = options.parse(argc, argv);

        // Check if help was requested
        if (result.count("help")) {
            std::cout << options.help() << std::endl;
            return 0;
        }

        // Check if debug mode is enabled
        if (result.count("debug")) {
            std::cout << "Debugging enabled" << std::endl;
        }

// get input file As File
        FILE * input_file = NULL;
        if(result.count("input-file")){
            input_file = fopen(result["input-file"].as<std::string>().c_str(),"rb");
            if(input_file == NULL){
                std::cout << "input file not found." << std::endl;
                return 0;
            }
        }
        else{
            std::cout << "input file was not set." << std::endl;
        }
        // get ouput file As File
        FILE * output_file = NULL;
        if(result.count("output-file")){
            output_file = fopen(result["output-file"].as<std::string>().c_str(),"wb");
            if(output_file == NULL){
                std::cout << "output file not found." << std::endl;
                return 0;
            }
        }
        else{
            std::cout << "output file was not set." << std::endl;
        }
        // get key file As File
        FILE * key_file = NULL;
        if(result.count("key-file")){
            key_file = fopen(result["key-file"].as<std::string>().c_str(),"rb");
            if(key_file == NULL){
                std::cout << "key file not found." << std::endl;
                return 0;
            }
        }
        else{
            std::cout << "key file was not set." << std::endl;
        }


        aes256_encode_file(input_file,key_file,output_file,false);

    }
    // Catch the every exception
    catch (const std::exception & e)
    {
        std::cout << "error parsing options: " << e.what() << std::endl;
        return 1;
    }


    catch (...) {
        // 这里捕获了所有其他类型的异常
        std::cerr << "Unknown exception caught" << std::endl;
        return 1;
    }

}
