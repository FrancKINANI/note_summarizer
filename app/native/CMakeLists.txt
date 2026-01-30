cmake_minimum_required(VERSION 3.18)

project(ai_edge_native)

# Set C++ standard
set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

# Configure logging
add_definitions(-DANDROID -DGGML_USE_CPU)

# --- LLAMA.CPP SOURCES ---
# We need to compile llama.cpp logic along with our bridge.
# The source files are in llama.cpp subfolder.

# Include paths
include_directories(
    ${CMAKE_CURRENT_SOURCE_DIR}/llama.cpp/include
    ${CMAKE_CURRENT_SOURCE_DIR}/llama.cpp/ggml/include
    ${CMAKE_CURRENT_SOURCE_DIR}/llama.cpp/src
)

# Collect source files (simplified for CPU-only first pass)
# This list might need adjustment based on llama.cpp version
set(LLAMA_SOURCES
    llama.cpp/src/llama.cpp
    llama.cpp/src/llama-vocab.cpp
    llama.cpp/src/llama-grammar.cpp
    llama.cpp/src/llama-sampling.cpp
    llama.cpp/src/unicode.cpp
    llama.cpp/src/unicode-data.cpp
    llama.cpp/ggml/src/ggml.c
    llama.cpp/ggml/src/ggml-alloc.c
    llama.cpp/ggml/src/ggml-backend.c
    llama.cpp/ggml/src/ggml-quants.c
    # Add other necessary files as needed
)

# Define the shared library
add_library(
    ai_edge_native
    SHARED
    native_lib.cpp
    ${LLAMA_SOURCES}
)

# Link necessary system libraries
find_library(
    log-lib
    log
)

target_link_libraries(
    ai_edge_native
    ${log-lib}
)
