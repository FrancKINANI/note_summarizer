# Documentation Phase 1 : Validation du Prototype Python

## 🎯 Objectif
L'objectif de cette phase était de valider que nous pouvons faire tourner un modèle d'IA (SLM - Small Language Model) localement sur votre machine, sans connexion internet. C'est la brique fondamentale de notre application "Offline-First".

## 🛠️ Outils Utilisés
- **Python** : Langage de script pour tester rapidement.
- **llama-cpp-python** : Une bibliothèque qui permet d'utiliser des modèles optimisés (format GGUF) avec Python.
- **Phi-3 Mini** : Le modèle d'intelligence artificielle de Microsoft, optimisé pour être léger et performant.

## 📂 Structure du Projet
Nous avons organisé le projet comme suit pour séparer proprement les expérimentations de l'application finale :

```text
/
├── prototypes/           # Nos tests Python
│   ├── prototype_script.py
│   ├── requirements.txt  # Liste des dépendances (bibliothèques)
│   └── .venv/            # Environnement virtuel isolé
├── assets/
│   └── models/           # Stockage du modèle IA (.gguf)
```

## 📝 Le Script (Explication pas à pas)
Le fichier `prototypes/prototype_script.py` fait 3 choses simples :

1.  **Chargement (`Llama(...)`)** :
    -   Il va chercher le fichier modèle dans `assets/models`.
    -   `n_ctx=2048` : Définit la "mémoire" à court terme du modèle (combien de mots il peut lire/écrire en une fois).
    -   `n_threads=4` : Utilise 4 cœurs de votre processeur pour les calculs.

2.  **Génération (`create_chat_completion`)** :
    -   On envoie un message : "Summarize: Machine learning is..."
    -   Le modèle calcule la suite logique mot par mot.

3.  **Affichage** :
    -   On imprime le résultat dans le terminal.

## ✅ Résultat
Le test a réussi ! Le modèle a généré une explication complète du Machine Learning, ce qui prouve que :
1.  Le fichier modèle est valide.
2.  Votre ordinateur est capable de l'exécuter.
3.  L'environnement de développement est fonctionnel.

---
**Prochaine étape** : Transposer cette logique dans une application mobile **Flutter**.
