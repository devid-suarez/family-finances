# Family Finances App Blueprint

## Overview

This document outlines the style, design, and features of the Family Finances application. It serves as a single source of truth for the project's current state and future development plans.

## Current State & Features

*   **Platform**: Flutter
*   **Backend**: Firebase
*   **Firebase Services**:
    *   Firebase Core (Initialized)
*   **Dependencies**:
    *   `flutter/material.dart`
    *   `firebase_core`
    *   `provider`
    *   `google_fonts`
*   **UI**: 
    *   Basic Material 3 Theming (Light/Dark mode).
    *   `HomeScreen` with a welcome message.

## Current Goal: Family Group Creation

**Plan:**
1.  **Define Model**: Create a `FamilyGroup` class.
2.  **Create "Add Group" Screen**: Build a new screen with a form to create a family group, including validation for the group name (max 50 characters).
3.  **Integrate Screen**: Add a button on the `HomeScreen` to navigate to the new screen.
4.  **Setup Firestore**: Initialize Cloud Firestore to store the family group data.
