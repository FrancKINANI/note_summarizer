# 📁 Project Structure

```
project-1-offline-ai-app/
├── README.md
├── pubspec.yaml                 # Flutter dependencies
├── assets/
│   └── models/
│       ├── phi-3-mini-q4.gguf   # 4-bit quantized model
│       └── phi-3-mini-q8.gguf   # 8-bit quantized model (optional)
├── lib/
│   ├── main.dart
│   ├── core/
│   │   ├── device_detector.dart     # Detects RAM, year, battery
│   │   └── resource_manager.dart    # Handles lazy load/unload
│   ├── ai/
│   │   ├── llm_engine.dart          # MLC LLM or llama.cpp wrapper
│   │   ├── embedding_engine.dart    # ONNX + Annoy for similarity
│   │   └── context_manager.dart     # Sliding window + semantic chunking
│   ├── data/
│   │   ├── local_store.dart         # Encrypted local DB
│   │   └── sync_service.dart        # Optional Azure sync
│   └── ui/
│       ├── home_screen.dart
│       └── chat_view.dart
├── android/
│   └── app/src/main/jni/           # For llama.cpp native integration
└── ios/
    └── Runner/MLC/                 # For MLC LLM iOS framework
```

---

## 📄 `pubspec.yaml` (Key Dependencies)

```yaml
dependencies:
  flutter:
    sdk: flutter
  path_provider: ^2.1.0            # Access device storage
  shared_preferences: ^2.2.0       # Store user prefs (e.g., quantization choice)
  encrypt: ^5.0.0                  # Local data encryption
  battery_plus: ^4.0.0             # Monitor battery level
  # Choose ONE LLM runtime:
  # Option A: Use community Flutter binding for llama.cpp
  fllama: ^0.0.5                   # https://github.com/xuegao-tzx/Fllama [[23]]
  # OR
  # Option B: Build custom MLC LLM bindings (more work, more control)

dev_dependencies:
  flutter_test:
    sdk: flutter
```

> 💡 **Note**: As of early 2026, **MLC LLM does not have an official Flutter plugin** [[16]], but **`fllama` provides a working Flutter binding for `llama.cpp`** [[23]]. We’ll use that for simplicity.

---

## 🔧 Step-by-Step Setup

### 1. **Download the Model**
Download a 4-bit GGUF version of Phi-3-mini:
- Go to Hugging Face: [`brittlewis12/Phi-3-mini-4k-instruct-GGUF`](https://huggingface.co/brittlewis12/Phi-3-mini-4k-instruct-GGUF)
- Download: `Phi-3-mini-4k-instruct-Q4_K_M.gguf` (good balance of size/speed) [[9]].
- Place it in `assets/models/phi-3-mini-q4.gguf`.

### 2. **Add Native Support (for `fllama`)**
The `fllama` package uses `llama.cpp` under the hood. Follow its setup:
- **Android**: The package includes prebuilt `.so` files—no extra config needed.
- **iOS**: Requires adding a build phase to compile `llama.cpp` (see [Fllama iOS guide](https://github.com/xuegao-tzx/Fllama)).

### 3. **Implement Core Logic**

#### `lib/core/device_detector.dart`
```dart
class DeviceDetector {
  static bool isLowEndDevice() {
    // Simplified: assume <4GB RAM = low-end
    // In practice, use platform channels to get real RAM
    return true; // placeholder
  }

  static bool isLowBattery() {
    // Use battery_plus package
  }
}
```

#### `lib/ai/llm_engine.dart`
```dart
import 'package:fllama/fllama.dart';

class LLMEngine {
  late Fllama _model;

  Future<void> loadModel(String modelPath) async {
    _model = await Fllama.create(
      modelPath: modelPath,
      nThreads: 4,
    );
  }

  Future<String> generate(String prompt) async {
    return await _model.complete(prompt);
  }

  void unload() {
    _model.dispose();
  }
}
```

#### `lib/ai/context_manager.dart`
```dart
// Use simple semantic chunking: split on ". "
List<String> semanticChunk(String text) {
  return text.split(RegExp(r'\.\s+'));
}

// Later, replace with Annoy + embeddings for relevance-based retention
```

---

## 🚀 Build & Run

### Android
```bash
flutter run
```
The `fllama` package handles native library loading automatically.

### iOS
You may need to:
1. Open `ios/Runner.xcworkspace` in Xcode.
2. Add `llama.cpp` as a subproject (follow `Fllama` instructions).
3. Set **Build Active Architecture Only** to `No` for release.

---

## 🌐 Optional: Cloud Sync with Azure
If you want optional sync:
1. Add `azure-storage-blob` Dart package.
2. Use MSAL for auth.
3. In `sync_service.dart`, upload encrypted blobs only when:
   - `ConnectivityResult != none`
   - User has granted permission.

---

## Contributing

Please read our [CONTRIBUTING.md](CONTRIBUTING.md) for guidelines on how to contribute to this project.

[Source Code here](https://github.com/FrancKINANI/note_summarizer.git)

If you find any issues or have suggestions for improvement, please open an issue or submit a pull request.