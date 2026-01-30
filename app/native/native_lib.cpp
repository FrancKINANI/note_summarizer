#include <iostream>
#include <string>
#include <vector>
#include <cstring>
#include "llama.h"

// Define a global model pointer
static llama_model * g_model = nullptr;
static llama_context * g_ctx = nullptr;

// External C functions for Dart
extern "C" {

  // Function to load the model
  int load_model(const char * model_path) {
    if (g_model) {
      llama_free_model(g_model);
      g_model = nullptr;
    }
    if (g_ctx) {
      llama_free(g_ctx);
      g_ctx = nullptr;
    }

    llama_model_params model_params = llama_model_default_params();
    g_model = llama_load_model_from_file(model_path, model_params);

    if (!g_model) {
      return -1; // Failed to load model
    }

    llama_context_params ctx_params = llama_context_default_params();
    g_ctx = llama_new_context_with_model(g_model, ctx_params);

    if (!g_ctx) {
      llama_free_model(g_model);
      g_model = nullptr;
      return -2; // Failed to create context
    }

    return 0; // Success
  }

  // Function to perform inference (simplified)
  // In a real app, this would handle token generation loop and callbacks
  const char* simple_infer(const char* prompt) {
    if (!g_ctx) return "Error: Model not loaded";
    
    // This is a placeholder for the actual inference logic
    // Implementing full inference here requires tokenizing, eval loop, sampling, etc.
    // For this step, we just return a static string ensuring the link works.
    return "Hello from C++! Inference logic pending implementation.";
  }

  // Function to unload the model
  void unload_model() {
    if (g_ctx) {
      llama_free(g_ctx);
      g_ctx = nullptr;
    }
    if (g_model) {
      llama_free_model(g_model);
      g_model = nullptr;
    }
  }

}
