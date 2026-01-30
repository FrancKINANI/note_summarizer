import 'dart:ffi';
import 'dart:io';
import 'package:ffi/ffi.dart';

// ===== TYPE DEFINITIONS =====
// These define the signatures of our C++ functions

// int load_model(const char* model_path)
typedef LoadModelC = Int32 Function(Pointer<Utf8> modelPath);
typedef LoadModelDart = int Function(Pointer<Utf8> modelPath);

// const char* simple_infer(const char* prompt)
typedef SimpleInferC = Pointer<Utf8> Function(Pointer<Utf8> prompt);
typedef SimpleInferDart = Pointer<Utf8> Function(Pointer<Utf8> prompt);

// void unload_model()
typedef UnloadModelC = Void Function();
typedef UnloadModelDart = void Function();

class AIService {
  static AIService? _instance;
  late DynamicLibrary _lib;
  bool _isModelLoaded = false;

  // Private constructor (Singleton pattern)
  AIService._internal() {
    _lib = _loadLibrary();
  }

  // Get singleton instance
  static AIService get instance {
    _instance ??= AIService._internal();
    return _instance!;
  }

  // Load the appropriate native library based on platform
  DynamicLibrary _loadLibrary() {
    if (Platform.isAndroid) {
      return DynamicLibrary.open('libai_edge_native.so');
    } else if (Platform.isIOS) {
      return DynamicLibrary.process();
    } else if (Platform.isLinux) {
      return DynamicLibrary.open('libai_edge_native.so');
    } else if (Platform.isMacOS) {
      return DynamicLibrary.open('libai_edge_native.dylib');
    } else if (Platform.isWindows) {
      return DynamicLibrary.open('ai_edge_native.dll');
    }
    throw UnsupportedError('Unsupported platform for AI service');
  }

  /// Load the AI model from a given path.
  /// Returns 0 on success, negative values on error.
  int loadModel(String modelPath) {
    final loadModelFunc = _lib
        .lookup<NativeFunction<LoadModelC>>('load_model')
        .asFunction<LoadModelDart>();

    final pathPointer = modelPath.toNativeUtf8();
    final result = loadModelFunc(pathPointer);
    calloc.free(pathPointer);

    _isModelLoaded = (result == 0);
    return result;
  }

  /// Perform inference on the given prompt.
  /// Returns the model's response as a String.
  String infer(String prompt) {
    if (!_isModelLoaded) {
      return 'Error: Model not loaded. Call loadModel() first.';
    }

    final inferFunc = _lib
        .lookup<NativeFunction<SimpleInferC>>('simple_infer')
        .asFunction<SimpleInferDart>();

    final promptPointer = prompt.toNativeUtf8();
    final resultPointer = inferFunc(promptPointer);
    calloc.free(promptPointer);

    // Convert the result back to a Dart string
    final result = resultPointer.toDartString();
    return result;
  }

  /// Unload the model to free memory.
  void unloadModel() {
    final unloadFunc = _lib
        .lookup<NativeFunction<UnloadModelC>>('unload_model')
        .asFunction<UnloadModelDart>();

    unloadFunc();
    _isModelLoaded = false;
  }

  bool get isModelLoaded => _isModelLoaded;
}
