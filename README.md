<div align="center">

<img src="assets/images/devhub\\\_logo.png" alt="DevHub Logo" width="120" height="120"/>

# DevHub

### Where Teams Build Together

A mobile-first developer collaboration platform that unifies team communication,  
GitHub-native task management, and real-time project tracking in a single app.

[!\[Flutter](https://img.shields.io/badge/Flutter-3.x-02569B?style=flat-square&logo=flutter)](https://flutter.dev)
[!\[Dart](https://img.shields.io/badge/Dart-3.x-0175C2?style=flat-square&logo=dart)](https://dart.dev)
[!\[Firebase](https://img.shields.io/badge/Firebase-Firestore-FFCA28?style=flat-square&logo=firebase)](https://firebase.google.com)
[!\[Supabase](https://img.shields.io/badge/Supabase-Edge_Functions-3ECF8E?style=flat-square&logo=supabase)](https://supabase.com)
[!\[License: MIT](https://img.shields.io/badge/License-MIT-yellow?style=flat-square)](LICENSE)
[!\[PRs Welcome](https://img.shields.io/badge/PRs-welcome-brightgreen?style=flat-square)](CONTRIBUTING.md)

[Features](#-features) · [Architecture](#-architecture) · [Getting Started](#-getting-started) · [Configuration](#-configuration) · [Screenshots](#-screenshots) · [Roadmap](#-roadmap)

\---

</div>

## The Problem

Every development team runs on at least three separate tools. A chat app (Slack), a task tracker (Jira or GitHub Issues), and GitHub itself. These tools don't talk to each other meaningfully. Tasks get buried in chat. PR review requests go unnoticed for hours. Managers have no real-time visibility into team progress without manually checking three platforms.

**DevHub solves this by making GitHub the single source of truth.** Tasks are real GitHub Issues. PR events automatically update task status via webhooks. Team communication, task management, and project progress all live in one mobile-first interface.

\---

## ✨ Features

### 🔐 Authentication \& Workspace Management

* **GitHub OAuth login** : Every user authenticates via GitHub, providing a verified identity for all API operations
* **Workspace creation** : Linked to a GitHub Organization — all GitHub operations (team creation, issue assignment, invitations) are performed programmatically
* **Team creation** : Simultaneously creates a corresponding GitHub Team inside the linked organization
* **Role-based access** : Workspace Admin, Team Lead, Developer — with GitHub role mapping (Owner, Maintainer, Member)
* **Member invitations** : Dispatch a GitHub Organization invite alongside the in-app invite, keeping both platforms in sync

### 💬 Real-time Communication (Built with BLoC)

* **Real-time team chat** : Powered by Firestore snapshots with live delivery
* **Rich message types** : Text, images, voice messages, PR event cards, location pins
* **Voice message recording** : Hold-to-record with waveform visualization and playback
* **Message interactions** : Threaded replies, emoji reactions, long-press options
* **Push notifications** : Via Firebase Cloud Messaging with deep linking to the exact screen
* **Direct messaging** : 1-on-1 private conversations between workspace members

### ✅ GitHub-Native Task Management (Built with Riverpod)

* **Task creation → GitHub Issue** : Every task created in DevHub creates a real GitHub Issue in the linked repository with the assignee's GitHub account tagged
* **Kanban board** : Four-column board (To Do / In Progress / In Review / Done) that updates automatically from GitHub events
* **Bidirectional webhook sync** : Via Supabase Edge Functions:

  * PR opened referencing an issue → task moves to **In Review**, team lead notified
  * PR approved → task flagged as approved
  * PR merged → task moves to **Done**, GitHub Issue closes automatically
  * PR closed without merge → task returns to **In Progress**
* **PR event cards** : Auto-posted in team chat when a PR is opened or merged
* **In-app PR approve :** Team leads can approve a PR directly from the task detail screen via GitHub API
* **My Tasks :** Unified view of all tasks assigned to the current user across every workspace

### 📞 Audio \& Video Calling (Agora RTC)

* 1-on-1 audio calls and group team audio calls
* 1-on-1 video calls with PiP self-view
* Speaking indicators, mute controls, call history
* Background call notifications via `flutter\\\_callkit\\\_incoming`

### 💳 Subscription \& Payments (Razorpay)

* Free and Pro subscription tiers
* Pro features: unlimited workspaces, video calls, priority support
* Razorpay recurring subscription with in-app payment flow
* Subscription state managed in Firestore and enforced at the feature level

### 📍 Location Sharing (Google Maps)

* Drop a meeting location pin in any team chat or DM
* Google Maps widget for picking current or custom location
* Location messages render as tappable map thumbnails in chat

\---

## 🏗 Architecture

DevHub is built with **Clean Architecture**, strictly separating concerns across three layers. Each layer depends only on the layer below it — the UI layer has no knowledge of Firebase or GitHub; the domain layer has no Flutter imports; the data layer implements interfaces defined in the domain layer.

```
┌─────────────────────────────────────────────┐
│              Presentation Layer             │
│  BLoC (Chat)  ·  Riverpod (Tasks)  ·  GetX  │
│         Pages  ·  Widgets  ·  Routes        │
└────────────────────┬────────────────────────┘
                     │ depends on
┌────────────────────▼────────────────────────┐
│               Domain Layer                  │
│   Entities  ·  Repository Interfaces        │
│              Use Cases (pure Dart)          │
└────────────────────┬────────────────────────┘
                     │ implemented by
┌────────────────────▼────────────────────────┐
│                Data Layer                   │
│  Firestore  ·  GitHub API  ·  Supabase      │
│  FCM  ·  Agora  ·  Razorpay  ·  Google Maps │
└─────────────────────────────────────────────┘
```

### State Management Strategy

|Module|Solution|Rationale|
|-|-|-|
|**Chat \& Messaging**|BLoC|Event-driven Firestore streams, typing indicators, message send/fail states — BLoC's explicit event → state model handles this complexity cleanly|
|**Task Management**|Riverpod|Multiple screens reactively watch the same task state; `StreamProvider` wraps Firestore queries; `AsyncNotifier` manages GitHub API mutations|
|**Navigation \& UI State**|GetX|Lightweight app-level state — active workspace selection, bottom nav, snackbars, dialogs|

### GitHub Integration Architecture

```
DevHub App                   Supabase Edge Function          GitHub
──────────                   ──────────────────────          ──────
Create Task ──── GitHub API ──────────────────────────────► Create Issue #42
                                                             Assign to @developer

Developer opens PR "Fixes #42" on GitHub
                             ◄──── Webhook Event ──────────── pull\\\_request:opened
                             Parse payload
                             Validate HMAC signature
                             Find Firestore task (issue #42)
                             Update status → "in\\\_review"
                             Write PR event to messages collection
                             Trigger FCM notification
DevHub App ◄── Firestore stream picks up change ────────────────────────────────
Task card moves to "In Review" column automatically
PR event card appears in team chat
Team lead receives push notification

Reviewer merges PR on GitHub
                             ◄──── Webhook Event ──────────── pull\\\_request:closed (merged: true)
                             Update task status → "done"
                             Update GitHub Issue → closed
DevHub App ◄── Firestore stream ─────────────────────────────────────────────────
Task card moves to "Done" column automatically
```

\---

## 📁 Project Structure

```
devhub/
├── android/
├── ios/
├── web/
├── lib/
│   ├── core/
│   │   ├── constants/
│   │   │   ├── app\\\_colors.dart
│   │   │   ├── app\\\_strings.dart
│   │   │   └── app\\\_routes.dart
│   │   ├── errors/
│   │   │   ├── failures.dart
│   │   │   └── exceptions.dart
│   │   ├── usecases/
│   │   │   └── usecase.dart            # Base UseCase abstract class
│   │   └── utils/
│   │       ├── github\\\_utils.dart
│   │       └── date\\\_utils.dart
│   │
│   ├── data/
│   │   ├── datasources/
│   │   │   ├── remote/
│   │   │   │   ├── firestore\\\_datasource.dart
│   │   │   │   ├── github\\\_api\\\_datasource.dart
│   │   │   │   ├── supabase\\\_storage\\\_datasource.dart
│   │   │   │   └── fcm\\\_datasource.dart
│   │   │   └── local/
│   │   │       └── secure\\\_storage\\\_datasource.dart
│   │   ├── models/
│   │   │   ├── user\\\_model.dart
│   │   │   ├── workspace\\\_model.dart
│   │   │   ├── team\\\_model.dart
│   │   │   ├── task\\\_model.dart
│   │   │   ├── message\\\_model.dart      # Abstract + TextMessage, ImageMessage, AudioMessage
│   │   │   └── milestone\\\_model.dart
│   │   └── repositories/
│   │       ├── auth\\\_repository\\\_impl.dart
│   │       ├── workspace\\\_repository\\\_impl.dart
│   │       ├── team\\\_repository\\\_impl.dart
│   │       ├── chat\\\_repository\\\_impl.dart
│   │       ├── task\\\_repository\\\_impl.dart
│   │       └── github\\\_repository\\\_impl.dart
│   │
│   ├── domain/
│   │   ├── entities/
│   │   │   ├── user.dart
│   │   │   ├── workspace.dart
│   │   │   ├── team.dart
│   │   │   ├── task.dart
│   │   │   ├── message.dart
│   │   │   └── milestone.dart
│   │   ├── repositories/
│   │   │   ├── auth\\\_repository.dart
│   │   │   ├── workspace\\\_repository.dart
│   │   │   ├── team\\\_repository.dart
│   │   │   ├── chat\\\_repository.dart
│   │   │   ├── task\\\_repository.dart
│   │   │   └── github\\\_repository.dart
│   │   └── usecases/
│   │       ├── auth/
│   │       │   ├── sign\\\_in\\\_with\\\_github.dart
│   │       │   └── sign\\\_out.dart
│   │       ├── workspace/
│   │       │   ├── create\\\_workspace.dart
│   │       │   └── get\\\_workspaces.dart
│   │       ├── team/
│   │       │   ├── create\\\_team.dart
│   │       │   └── invite\\\_member.dart
│   │       ├── chat/
│   │       │   ├── send\\\_message.dart
│   │       │   └── get\\\_messages\\\_stream.dart
│   │       └── task/
│   │           ├── create\\\_task.dart
│   │           ├── get\\\_tasks\\\_stream.dart
│   │           └── get\\\_my\\\_tasks.dart
│   │
│   └── presentation/
│       ├── blocs/
│       │   ├── chat/
│       │   │   ├── chat\\\_bloc.dart
│       │   │   ├── chat\\\_event.dart
│       │   │   └── chat\\\_state.dart
│       │   ├── auth/
│       │   │   ├── auth\\\_bloc.dart
│       │   │   ├── auth\\\_event.dart
│       │   │   └── auth\\\_state.dart
│       │   └── notification/
│       │       ├── notification\\\_bloc.dart
│       │       ├── notification\\\_event.dart
│       │       └── notification\\\_state.dart
│       ├── providers/
│       │   ├── task\\\_providers.dart
│       │   ├── workspace\\\_providers.dart
│       │   └── github\\\_providers.dart
│       ├── controllers/
│       │   ├── navigation\\\_controller.dart
│       │   └── workspace\\\_controller.dart
│       ├── pages/
│       │   ├── auth/
│       │   │   ├── splash\\\_page.dart
│       │   │   └── auth\\\_page.dart
│       │   ├── home/
│       │   │   └── home\\\_page.dart
│       │   ├── workspace/
│       │   │   └── workspace\\\_page.dart
│       │   ├── team/
│       │   │   ├── team\\\_page.dart
│       │   │   ├── chat\\\_tab.dart
│       │   │   └── tasks\\\_tab.dart
│       │   ├── task/
│       │   │   ├── task\\\_detail\\\_page.dart
│       │   │   └── my\\\_tasks\\\_page.dart
│       │   ├── dm/
│       │   │   ├── dm\\\_list\\\_page.dart
│       │   │   └── dm\\\_chat\\\_page.dart
│       │   ├── calls/
│       │   │   ├── calls\\\_page.dart
│       │   │   ├── audio\\\_call\\\_page.dart
│       │   │   └── video\\\_call\\\_page.dart
│       │   ├── profile/
│       │   │   └── member\\\_profile\\\_page.dart
│       │   ├── notifications/
│       │   │   └── notifications\\\_page.dart
│       │   └── subscription/
│       │       └── subscription\\\_page.dart
│       └── widgets/
│           ├── message\\\_bubble.dart
│           ├── task\\\_card.dart
│           ├── workspace\\\_tile.dart
│           ├── team\\\_tile.dart
│           ├── pr\\\_event\\\_card.dart
│           └── bottom\\\_sheets/
│               ├── create\\\_workspace\\\_sheet.dart
│               ├── create\\\_team\\\_sheet.dart
│               ├── invite\\\_member\\\_sheet.dart
│               ├── create\\\_task\\\_sheet.dart
│               └── attachment\\\_picker\\\_sheet.dart
│
├── supabase/
│   └── functions/
│       └── github-webhook/
│           └── index.ts                # Edge Function — webhook receiver
│
├── test/
│   ├── unit/
│   │   ├── blocs/
│   │   │   └── chat\\\_bloc\\\_test.dart
│   │   └── usecases/
│   │       └── create\\\_task\\\_test.dart
│   └── widget/
│       └── message\\\_bubble\\\_test.dart
│
├── pubspec.yaml
├── .env.example
└── README.md
```

\---

## 🚀 Getting Started

### Prerequisites

Before you begin, ensure you have the following installed and configured:

* [Flutter SDK](https://docs.flutter.dev/get-started/install) `>=3.0.0`
* [Dart SDK](https://dart.dev/get-dart) `>=3.0.0`
* [Firebase CLI](https://firebase.google.com/docs/cli) — for Firebase project configuration
* [Supabase CLI](https://supabase.com/docs/guides/cli) — for deploying Edge Functions
* A [Firebase project](https://console.firebase.google.com/) with Firestore, Authentication, and Cloud Messaging enabled
* A [Supabase project](https://supabase.com/) for file storage and Edge Functions
* A [GitHub OAuth App](https://github.com/settings/developers) for authentication
* An [Agora account](https://www.agora.io/) for audio/video calling
* A [Razorpay account](https://razorpay.com/) (test mode) for subscription payments
* A [Google Cloud project](https://console.cloud.google.com/) with Maps SDK for Android enabled

\---

### Installation

**1. Clone the repository**

```bash
git clone https://github.com/your-username/devhub.git
cd devhub
```

**2. Install Flutter dependencies**

```bash
flutter pub get
```

**3. Firebase setup**

```bash
# Install FlutterFire CLI if not already installed
dart pub global activate flutterfire\\\_cli

# Configure Firebase for your project
flutterfire configure
```

This generates `lib/firebase\\\_options.dart` automatically.

**4. Environment configuration**

Copy the example environment file and fill in your values:

```bash
cp .env.example .env
```

See the [Configuration](#-configuration) section for all required values.

**5. Deploy the GitHub webhook Edge Function**

```bash
cd supabase/functions/github-webhook
supabase functions deploy github-webhook --project-ref YOUR\\\_SUPABASE\\\_PROJECT\\\_REF
```

**6. Configure GitHub Webhook**

In your GitHub repository settings → Webhooks → Add webhook:

* **Payload URL:** `https://YOUR\\\_SUPABASE\\\_PROJECT\\\_REF.supabase.co/functions/v1/github-webhook`
* **Content type:** `application/json`
* **Secret:** The value of `GITHUB\\\_WEBHOOK\\\_SECRET` from your `.env`
* **Events:** Select `Pull requests` and `Pull request reviews`

**7. Run the app**

```bash
# Android
flutter run

# iOS
flutter run -d ios

# Web
flutter run -d chrome
```

\---

## ⚙️ Configuration

All sensitive configuration is handled through environment variables. Create a `.env` file in the root directory based on `.env.example`.

|Variable|Description|Where to get it|
|-|-|-|
|`GITHUB\\\_CLIENT\\\_ID`|GitHub OAuth App client ID|[GitHub Developer Settings](https://github.com/settings/developers) → OAuth Apps|
|`GITHUB\\\_CLIENT\\\_SECRET`|GitHub OAuth App client secret|Same as above|
|`GITHUB\\\_WEBHOOK\\\_SECRET`|Secret for validating webhook payloads|Create any strong random string|
|`AGORA\\\_APP\\\_ID`|Agora project App ID|[Agora Console](https://console.agora.io/)|
|`RAZORPAY\\\_KEY\\\_ID`|Razorpay API key (use test key during development)|[Razorpay Dashboard](https://dashboard.razorpay.com/) → Settings → API Keys|
|`GOOGLE\\\_MAPS\\\_API\\\_KEY`|Google Maps API key|[Google Cloud Console](https://console.cloud.google.com/) → APIs \& Services → Credentials|
|`SUPABASE\\\_URL`|Your Supabase project URL|Supabase Dashboard → Settings → API|
|`SUPABASE\\\_ANON\\\_KEY`|Supabase anonymous key|Same as above|

### GitHub OAuth App Setup

When creating your GitHub OAuth App:

* **Homepage URL:** `https://devhub.app` (or your domain)
* **Authorization callback URL:** `com.devhub.app://callback` (must match the scheme in your Flutter app)

### Firebase Security Rules

Apply the following Firestore security rules to your Firebase project:

```javascript
rules\\\_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {

    function isAuthenticated() {
      return request.auth != null;
    }

    function isWorkspaceMember(workspaceId) {
      return isAuthenticated() \\\&\\\&
        exists(/databases/$(database)/documents/workspaces/$(workspaceId)/members/$(request.auth.uid));
    }

    function isWorkspaceAdmin(workspaceId) {
      return isAuthenticated() \\\&\\\&
        get(/databases/$(database)/documents/workspaces/$(workspaceId)/members/$(request.auth.uid)).data.role == 'admin';
    }

    match /users/{userId} {
      allow read: if isAuthenticated();
      allow write: if request.auth.uid == userId;
    }

    match /workspaces/{workspaceId} {
      allow read: if isWorkspaceMember(workspaceId);
      allow create: if isAuthenticated();
      allow update, delete: if isWorkspaceAdmin(workspaceId);

      match /teams/{teamId} {
        allow read: if isWorkspaceMember(workspaceId);
        allow write: if isWorkspaceAdmin(workspaceId);

        match /messages/{messageId} {
          allow read: if isWorkspaceMember(workspaceId);
          allow create: if isWorkspaceMember(workspaceId);
          allow update, delete: if request.auth.uid == resource.data.senderId;
        }

        match /tasks/{taskId} {
          allow read: if isWorkspaceMember(workspaceId);
          allow write: if isWorkspaceMember(workspaceId);
        }
      }
    }

    match /dms/{conversationId}/messages/{messageId} {
      allow read, write: if isAuthenticated() \\\&\\\&
        conversationId.matches('.\\\*' + request.auth.uid + '.\\\*');
    }
  }
}
```

\---

## 📦 Tech Stack

|Category|Technology|Version|
|-|-|-|
|**Framework**|Flutter|`>=3.0.0`|
|**Language**|Dart|`>=3.0.0`|
|**State Management**|flutter\_bloc|`^8.x`|
|**State Management**|flutter\_riverpod|`^2.x`|
|**State Management**|get|`^4.x`|
|**Navigation**|go\_router|`^13.x`|
|**Auth**|firebase\_auth|`^4.x`|
|**Database**|cloud\_firestore|`^4.x`|
|**Push Notifications**|firebase\_messaging|`^14.x`|
|**File Storage**|supabase\_flutter|`^2.x`|
|**HTTP Client**|dio|`^5.x`|
|**Audio/Video Calls**|agora\_rtc\_engine|`^6.x`|
|**Audio Recording**|record|`^5.x`|
|**Audio Playback**|audioplayers|`^5.x`|
|**Image Picker**|image\_picker|`^1.x`|
|**Image Caching**|cached\_network\_image|`^3.x`|
|**Payments**|razorpay\_flutter|`^1.x`|
|**Maps**|google\_maps\_flutter|`^2.x`|
|**Secure Storage**|flutter\_secure\_storage|`^9.x`|
|**OAuth**|flutter\_web\_auth\_2|`^4.x`|
|**Call Notifications**|flutter\_callkit\_incoming|`^2.x`|
|**Webhook Runtime**|Supabase Edge Functions (Deno/TypeScript)|`^1.x`|

\---

## 📱 Screenshots

> Screenshots will be added upon completion of the UI.

|Auth|Home|Team Chat|
|-|-|-|
|!\[Auth](screenshots/auth.png)|!\[Home](screenshots/home.png)|!\[Chat](screenshots/chat.png)|

|Task Board|Task Detail|Video Call|
|-|-|-|
|!\[Tasks](screenshots/tasks.png)|!\[Detail](screenshots/task\_detail.png)|!\[Call](screenshots/video\_call.png)|

\---

## 🗺 Roadmap

|Status|Feature|
|-|-|
|✅|GitHub OAuth authentication|
|✅|Workspace and team creation with GitHub API sync|
|✅|Real-time team chat (text, images, voice messages)|
|✅|Push notifications with deep linking|
|✅|Direct messaging|
|✅|Task creation → GitHub Issues via API|
|✅|Kanban board with automatic GitHub webhook status updates|
|✅|PR event cards in team chat|
|✅|Audio and video calling via Agora|
|✅|Razorpay subscription (Free / Pro)|
|✅|Google Maps location sharing in chat|
|🔄|Stakeholder web portal (Google-authenticated, shareable project report)|
|🔄|Milestone-based progress tracking|
|🔄|GitHub Actions CI/CD status display|
|🔄|Desktop build (Windows / macOS)|
|🔄|Screen sharing during video calls|
|⏳|Self-hosted / on-premise deployment option|
|⏳|GitHub Copilot integration for in-chat code suggestions|

✅ Completed · 🔄 In Progress · ⏳ Planned

\---

## 🧪 Running Tests

```bash
# Run all tests
flutter test

# Run tests with coverage
flutter test --coverage

# Run a specific test file
flutter test test/unit/blocs/chat\\\_bloc\\\_test.dart

# Generate coverage report (requires lcov)
genhtml coverage/lcov.info -o coverage/html
open coverage/html/index.html
```

\---

## 🤝 Contributing

Contributions are welcome. Please read the guidelines below before submitting a pull request.

**1. Fork the repository and create a feature branch**

```bash
git checkout -b feature/your-feature-name
```

**2. Follow the existing architecture**

* Domain layer entities and use cases must be pure Dart (no Flutter or Firebase imports)
* New features that involve real-time data use Riverpod `StreamProvider`
* New features that involve event-driven UI interactions use BLoC
* All network calls go through a repository interface — never call Firestore or GitHub API directly from a BLoC or provider

**3. Write tests for new use cases and BLoC classes**

**4. Commit with a descriptive message following conventional commits**

```bash
git commit -m "feat(tasks): add milestone assignment to task creation"
git commit -m "fix(chat): resolve duplicate message rendering on reconnect"
git commit -m "docs(readme): update environment variable table"
```

**5. Open a pull request against `develop`**

The `main` branch is protected. All PRs must target `develop` and pass CI checks before merging.

\---

## 📂 Branch Strategy

```
main        ← stable, production-ready
develop     ← integration branch, all PRs merge here
feature/\\\*   ← individual feature branches (e.g. feature/agora-calls)
fix/\\\*       ← bug fix branches (e.g. fix/chat-scroll-jump)
```

\---

## 📄 License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.

\---

## 🙏 Acknowledgements

* [Flutter](https://flutter.dev) — the framework that made cross-platform possible from a single codebase
* [Firebase](https://firebase.google.com) — real-time database and authentication
* [Supabase](https://supabase.com) — file storage and serverless webhook handling
* [Agora](https://www.agora.io/) — audio and video calling SDK
* [Razorpay](https://razorpay.com/) — payment infrastructure
* [GitHub REST API](https://docs.github.com/en/rest) — the backbone of the task management system

\---

<div align="center">

Built with ❤️ using Flutter

[Report a Bug](https://github.com/your-username/devhub/issues) · [Request a Feature](https://github.com/your-username/devhub/issues)

</div>

