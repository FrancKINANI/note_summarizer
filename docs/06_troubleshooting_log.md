# Rapport d'Incidents Techniques : Intégration Native

Ce document répertorie les obstacles majeurs rencontrés lors de l'intégration de `llama.cpp` via FFI et les solutions apportées.

## 1. Environnement de Build (SDK/NDK)
**Obstacle** : Échec de la compilation Gradle à cause des licences Android non acceptées et du gestionnaire de SDK manquant.
* **Cause** : Installation incomplète des `cmdline-tools` du SDK Android sur la machine hôte.
* **Solution** : Installation manuelle des outils, configuration du `PATH` et exécution de `flutter doctor --android-licenses`.

## 2. Structure des Sources llama.cpp
**Obstacle** : CMake ne trouvait pas les fichiers sources (ex: `ggml-backend.c`).
* **Cause** : `llama.cpp` est un projet en évolution rapide. Entre deux versions, de nombreux fichiers `.c` ont été migrés en `.cpp`, et la structure des dossiers a changé.
* **Solution** : Migration vers une approche `add_subdirectory(llama.cpp)` dans CMake pour utiliser le système de build officiel du moteur plutôt que de lister manuellement les fichiers.

## 3. Conflits de Définition (Headers)
**Obstacle** : Erreurs de type `redefinition of 'ggml_status'`.
* **Cause** : Présence de copies locales des fichiers d'en-tête (`llama.h`, `ggml.h`) en plus des sources dans le sous-dossier `llama.cpp`, créant une confusion pour le compilateur.
* **Solution** : Nettoyage drastique des fichiers redondants pour ne garder que le pont `native_lib.cpp`.

## 4. Pollution par l'Environnement Hôte (Confirmé)
**Obstacle actuel** : `error: cast from pointer to smaller type 'uintptr_t' (aka 'unsigned int') loses information`.
* **Analyse** : 
    * Le log montre : `In file included from /snap/flutter/current/usr/include/c++/9/filesystem:37`.
    * **Le problème est identifié** : L'installation Flutter via **Snap** force l'usage des headers C++ de l'hôte Linux au lieu de ceux du NDK Android. 
    * Sur l'hôte (via Snap), `uintptr_t` est résolu en 32 bits (`unsigned int`), ce qui est incompatible avec la cible `arm64-v8a` (64 bits).
* **Solution prévue** : Forcer la désactivation des chemins d'inclusion système standards et rediriger explicitement vers les headers du NDK.

## 5. Problème de Casting dans llama.cpp
**Obstacle** : `cast from pointer to smaller type 'uintptr_t' loses information` dans `ggml-impl.h`.
* **Cause** : Conséquence directe du point 4. Le compilateur utilise la mauvaise définition de `uintptr_t`.

---

## 📅 Plan d'action pour résoudre le blocage actuel

| Étape | Action | Objectif |
| :--- | :--- | :--- |
| **1** | **Isolation CMake** | Re-vérifier les drapeaux d'isolation pour empêcher Clang de regarder dans `/snap/flutter/...` |
| **2** | **Update Flutter SDK** | Vérifier si une installation "classique" (hors Snap) de Flutter résout les conflits de headers système. |
| **3** | **Fix C++ Casts** | Si le problème persiste, ajouter des flags de compilation pour ignorer ces avertissements spécifiques ou forcer le type `uint64_t`. |
| **4** | **Test Minimal** | Tenter de compiler une bibliothèque C++ vide avec FFI pour isoler si le problème vient de `llama.cpp` ou de la configuration NDK globale. |
