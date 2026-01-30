# Documentation Phase 3 : Interface Utilisateur (UI)

## 🎯 Objectif
L'objectif de cette phase était de créer les écrans visibles de l'application, avant d'y connecter l'intelligence artificielle.

## 📱 Ce que nous avons réalisé
1.  **Architecture UI** : Séparation claire entre les écrans (`ui/screens`) et les composants (`ui/widgets`).
2.  **Design System** : Mise en place d'un système de design cohérent (`core/theme.dart`) avec :
    -   Un mode sombre (Dark Mode) par défaut.
    -   Des polices modernes (Outfit pour les titres, Inter pour le texte).
    -   Des couleurs vibrantes (Bleu électrique, Violet) sur fond sombre.
3.  **Écran d'Accueil (`HomeScreen`)** :
    -   Barre d'application personnalisée.
    -   Section de bienvenue dynamique.
    -   Boutons d'action rapide ("Nouvelle Note", "Résumer").
    -   Liste de cartes pour visualiser les notes futures.

## 🌐 Compatibilité Web
Nous avons configuré et vérifié que l'application peut être compilée pour le Web (`flutter build web`). Cela permet de tester l'interface rapidement sans avoir besoin d'un émulateur mobile lourd.

## 📸 Aperçu Technique
Le code utilise les meilleures pratiques Flutter 2026 :
-   `StatelessWidget` pour les interfaces statiques (performance).
-   `ThemeData` pour centraliser le style (maintenabilité).
-   `ListView.builder` pour les listes (optimisation mémoire).

## ⏭️ Prochaine Étape
Connecter le "cerveau" (IA) à cette "coquille" (UI). Nous allons intégrer le modèle `Phi-3` pour qu'il puisse générer du texte directement dans l'application.
