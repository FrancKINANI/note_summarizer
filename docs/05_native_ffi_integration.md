# Documentation Phase 4 : Intégration Native C++ (FFI)

## 🎯 Objectif
Cette phase établit le **pont critique** entre Flutter (Dart) et le moteur d'inférence IA (`llama.cpp`) écrit en C++. C'est le cœur du projet et la preuve de nos compétences en ingénierie système.

## 📂 Structure Native Créée
```text
app/
├── native/                         # Sources C++ (hors Android)
│   ├── CMakeLists.txt              # Instructions de compilation
│   ├── native_lib.cpp              # Notre pont C++ personnalisé
│   ├── llama.h                     # En-tête llama.cpp
│   └── llama.cpp/                  # Code source llama.cpp (clone Git)
│       ├── include/
│       ├── ggml/
│       └── src/
└── android/app/src/native/         # Copie pour le build Android
```

## 🧠 Comment ça fonctionne (Simplifié)

### 1. Le Code C++ (`native_lib.cpp`)
Nous avons défini 3 fonctions simples exposées à Dart :

| Fonction       | Rôle                                    | Retour         |
|----------------|-----------------------------------------|----------------|
| `load_model()` | Charge le fichier `.gguf` en mémoire    | 0 si OK, < 0 si erreur |
| `simple_infer()` | Génère du texte à partir d'un prompt  | `const char*` (texte) |
| `unload_model()` | Libère la mémoire du modèle           | (rien)         |

Le mot-clé `extern "C"` empêche le compilateur C++ de "déformer" les noms de fonctions, ce qui est nécessaire pour que Dart les trouve.

### 2. Le Fichier CMake (`CMakeLists.txt`)
Ce fichier dit au compilateur Android (NDK) :
- Quels fichiers `.cpp` / `.c` compiler.
- Où trouver les `.h` (en-têtes).
- Comment nommer la bibliothèque finale (`libai_edge_native.so`).

### 3. Le Service Dart (`ai_service.dart`)
Ce fichier est le **côté Flutter** du pont.

```dart
// Exemple simplifié de FFI
final loadModelFunc = _lib
    .lookup<NativeFunction<LoadModelC>>('load_model')
    .asFunction<LoadModelDart>();
```
- `DynamicLibrary.open()` charge le fichier `.so` compilé.
- `lookup()` cherche une fonction par son nom.
- `asFunction()` la transforme en fonction Dart appelable.

## ⚠️ État Actuel
- ✅ Structure créée.
- ✅ Code Dart FFI compilé sans erreur.
- 🚧 **Non testé sur device réel** : La compilation native complète nécessite un SDK Android complet (NDK). Le test final se fera sur un émulateur ou téléphone Android.

## ⏭️ Prochaine Étape
1. Configurer un émulateur Android ou brancher un téléphone.
2. Lancer `flutter build apk` pour compiler le code C++.
3. Tester le chargement du modèle et une inférence simple.
