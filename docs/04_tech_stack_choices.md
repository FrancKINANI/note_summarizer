# 🏗️ Choix Technologiques & Décisions (ADR)

Ce document retrace toutes les décisions techniques importantes prises pour le projet et justifie les choix futurs.

## 1. Langage & Framework
### Décision : Flutter (Dart)
-   **Pourquoi ?** Permet de créer une application native iOS/Android (et Web) avec un seul code.
-   **Alternative rejetée** : Native (Kotlin/Swift) aurait demandé deux fois plus de travail. React Native est moins performant pour l'intégration de code natif C++ (nécessaire pour l'IA).
-   **Statut** : ✅ Implementé.

## 2. Intelligence Artificielle (Le "Cerveau")
### Décision : Modèle SLM (Phi-3 Mini) + GGUF
-   **Pourquoi Phi-3 ?** C'est un "Small Language Model" (3.8 milliards de paramètres) capable de rivaliser avec des modèles plus gros, mais assez léger pour tourner sur un téléphone.
-   **Pourquoi GGUF ?** C'est le format standard actuel pour l'inférence locale CPU/GPU. Il permet la "quantization" (réduire la taille du modèle de 16-bit à 4-bit) sans trop perdre en intelligence.
-   **Statut** : ✅ Validé en Python (Prototype).

### Décision : Binding Personnalisé `llama.cpp` via FFI
-   **Pourquoi ?**
    -   **Contrôle Total** : Pour respecter les contraintes du projet (déchargement mémoire, quantification dynamique), nous devons avoir un accès direct au cycle de vie du modèle.
    -   **Compétence "Bridge Engineer"** : Utiliser un wrapper tout fait (`fllama`) masquerait la complexité réelle. Créer notre propre pont (Dart <-> C++) prouve notre capacité à ingénier des systèmes complexes.
    -   **Flexibilité** : Permet d'implémenter des fonctionnalités avancées comme le *lazy loading* et le suivi précis de la batterie, impossibles avec des solutions "boîte noire".
-   **Alternative rejetée** : `fllama` ou `MLC LLM` (trop limités pour notre cas d'usage avancé).
-   **Statut** : 🚧 En cours d'architecture.

## 3. Stockage des Données (La "Mémoire")
### Décision : Fichiers Locaux (JSON) via `path_provider`
-   **Pourquoi ?**
    -   Pour l'instant, nous n'avons pas besoin de requêtes complexes (SQL).
    -   Stocker les notes dans des fichiers JSON est simple, lisible et facile à déboguer.
    -   `path_provider` nous donne le chemin correct sur Android (`/data/user/...`) et iOS (`Documents/`) sans qu'on se casse la tête.
-   **Alternative future** : Si l'app devient complexe avec des centaines de notes, nous migrerons vers **SQLite** (via `sqflite` ou `drift`) ou **Hive** (NoSQL rapide).
-   **Statut** : 🚧 En cours d'implémentation.

## 4. Gestion d'État
### Décision : Provider
-   **Pourquoi ?** C'est le standard recommandé par Google pour les applications de taille moyenne. Plus simple que BLoC ou Riverpod pour débuter, mais très puissant.
-   **Statut** : ✅ Installé.

## 5. Interface Utilisateur (UI)
### Décision : Material 3 + Google Fonts
-   **Pourquoi ?** Material 3 offre des composants modernes et accessibles par défaut. Google Fonts permet d'avoir une identité visuelle unique sans gérer manuellement les fichiers de police.
-   **Statut** : ✅ Implementé (Thème sombre).
