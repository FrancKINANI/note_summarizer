cmake_minimum_required(VERSION 3.18)

project(ai_edge_native)

# Set C++ standard
set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

# Configure for Android
add_definitions(-DANDROID -DGGML_USE_CPU)

# Disable features we don't need on mobile to speed up compilation
set(GGML_CUDA OFF CACHE BOOL "" FORCE)
set(GGML_VULKAN OFF CACHE BOOL "" FORCE)
set(GGML_METAL OFF CACHE BOOL "" FORCE)
set(GGML_BLAS OFF CACHE BOOL "" FORCE)
set(GGML_OPENCL OFF CACHE BOOL "" FORCE)
set(GGML_SYCL OFF CACHE BOOL "" FORCE)
set(LLAMA_BUILD_EXAMPLES OFF CACHE BOOL "" FORCE)
set(LLAMA_BUILD_TESTS OFF CACHE BOOL "" FORCE)
set(LLAMA_BUILD_SERVER OFF CACHE BOOL "" FORCE)
set(BUILD_SHARED_LIBS ON CACHE BOOL "" FORCE)

# Add llama.cpp as a subdirectory (it will build itself)
add_subdirectory(llama.cpp)

# Build our bridge library
add_library(
    ai_edge_native
    SHARED
    native_lib.cpp
)

# Include directories
target_include_directories(ai_edge_native PRIVATE
    ${CMAKE_CURRENT_SOURCE_DIR}/llama.cpp/include
    ${CMAKE_CURRENT_SOURCE_DIR}/llama.cpp/ggml/include
)

# Link against the llama library built by the subdirectory
target_link_libraries(ai_edge_native
    llama
    log
)
