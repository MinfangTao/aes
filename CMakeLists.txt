cmake_minimum_required(VERSION 3.26)
project(AES CUDA)

set(CMAKE_CUDA_STANDARD 17)

add_executable(AES main.cu
        aes.h
        gpu_aes256_encode.cu)

set_target_properties(AES PROPERTIES
        CUDA_SEPARABLE_COMPILATION ON)

include_directories(external/cxxopts/include)