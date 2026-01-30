# 🗺️ Feuille de Route du Projet (Roadmap)

Ce document servira de guide tout au long du développement. Nous cocherons les étapes au fur et à mesure.

## Phase 1 : Validation Technique ✅
- [x] Organiser les dossiers du projet.
- [x] Installer l'environnement Python.
- [x] Tester le modèle `Phi-3` avec un script Python.
- [x] Valider que le modèle fonctionne hors-ligne.

## Phase 2 : Fondations de l'Application Mobile (Terminé) ✅
- [x] Initialiser le projet Flutter (`flutter create`).
- [x] Nettoyer le code par défaut et organiser l'architecture (dossiers `lib/core`, `lib/ui`, etc.).
- [x] Configurer les assets (polices, images, modèle IA).

## Phase 3 : Intégration du Moteur IA (En cours) 🚧
- [x] Télécharger et configurer `llama.cpp` (code source C++).
- [x] Créer le pont C++ (`native_lib.cpp`) avec les fonctions `load`, `infer`, `unload`.
- [x] Configurer le build Android (CMakeLists.txt + build.gradle.kts).
- [x] Créer le service Dart FFI (`ai_service.dart`).
- [ ] Compiler et tester sur un appareil Android réel.

## Phase 4 : Interface Utilisateur (UI)
- [ ] Créer l'écran d'accueil (Design moderne).
- [ ] Créer l'interface de Chat (bulles de messages, champ de saisie).
- [ ] Créer l'interface de Résumé de Notes.

## Phase 5 : Fonctionnalités Avancées
- [ ] Gestion de la mémoire (décharger le modèle si batterie faible).
- [ ] Base de données locale pour sauvegarder l'historique.
- [ ] Optimisations de performance.

## Phase 6 : Documentation & Livraison
- [ ] Rédiger le rapport technique final.
- [ ] Nettoyer le code final.
- [ ] Préparer les instructions d'installation pour les utilisateurs.
