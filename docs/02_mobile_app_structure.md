# Documentation Phase 2 : Structure de l'Application Mobile

## 🎯 Objectif
Cette phase consiste à créer la structure de base de notre application mobile Flutter. Une bonne organisation dès le début est cruciale pour que le projet reste compréhensible et facile à maintenir, surtout quand on ajoute de l'IA.

## 📂 Architecture Prévue
Nous allons suivre une architecture propre et modulaire, adaptée aux débutants mais scalable.

```text
/lib
├── main.dart             # 🏁 Point d'entrée de l'application
├── core/                 # ⚙️ Le cœur de l'app (ce qui est transverse)
│   ├── constants.dart    # Couleurs, tailles, textes fixes
│   └── theme.dart        # Le style global (Dark/Light mode)
├── data/                 # 💾 La gestion des données
│   ├── models/           # La forme de nos données (Note, Message)
│   └── repositories/     # Pour sauvegarder/lire les données (BDD locale)
├── services/             # 🧠 Les "cerveaux" de l'app
│   ├── ai_service.dart   # Notre lien avec le modèle IA (llama.cpp)
│   └── storage_service.dart # Gestion du stockage fichier
└── ui/                   # 🎨 L'interface utilisateur (ce qu'on voit)
    ├── screens/          # Les écrans complets (Accueil, Chat, Détail Note)
    └── widgets/          # Les petits composants réutilisables (Boutons, Cartes)
```

## 📝 Pourquoi cette structure ?
1.  **Séparation des responsabilités** : L'interface (`ui`) ne doit pas savoir *comment* l'IA fonctionne (`services`), elle doit juste demander un résultat.
2.  **Facilité de lecture** : Si vous voulez changer la couleur d'un bouton, vous allez dans `ui`. Si vous voulez changer le modèle d'IA, vous allez dans `services`.
3.  **Maintenance** : Si un bug survient dans la sauvegarde des notes, on sait tout de suite qu'il faut regarder dans `data`.

## 🚀 Prochaines Étapes Techniques
1.  Exécuter `flutter create app` pour générer le squelette.
2.  Créer manuellement les dossiers ci-dessus.
3.  Installer les dépendances nécessaires (`provider` pour la gestion d'état, `google_fonts` pour le style, etc.).
