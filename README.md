# Flutter Technical Assessment — E-Shop Mobile App

A Flutter mobile application built for the **Electro Pi Flutter Mobile Developer** technical assessment. The app integrates with a real REST API, follows **Clean Architecture**, and uses **BLoC/Cubit** for state management.

**Repository:** [https://github.com/AbdelrahmanAddel/technical_assessment_task](https://github.com/AbdelrahmanAddel/technical_assessment_task)

---

## Important Note — API Choice

The assessment document suggests using [JSONPlaceholder](https://jsonplaceholder.typicode.com) as a mock API. After reviewing that service, I found that it **does not provide authentication endpoints** (no login, register, JWT, or user session). It only exposes static resources such as `/posts`, `/todos`, and `/users` for read/write prototyping.

Because the assessment **requires**:

- Login & Registration with **JWT token storage**
- Auto-navigation when the user is already logged in
- A **Profile** screen with user name, email, and logout

…I chose a **full REST API** that supports real authentication and CRUD operations:

| | JSONPlaceholder | API Used in This Project |
|---|---|---|
| Base URL | `jsonplaceholder.typicode.com` | `accessories-eshop.runasp.net` |
| Authentication | ❌ Not available | ✅ Login, Register, OTP, JWT, Logout |
| Protected routes | ❌ | ✅ Bearer token via interceptor |
| List + Detail + CRUD | Partial (fake data) | ✅ Products with pagination & update/delete |
| OpenAPI docs | — | `/openapi/v1.json` |
| Postman collection | — | [Accessories E-Shop API](https://winter-shuttle-873137.postman.co/workspace/My-Workspace~503bd648-8a0a-4e41-8b44-1b7782dfb485/collection/36783660-4239c120-fa6b-490c-b8ff-6999e2d83979?action=share&source=copy-link&creator=36783660) |

All other technical requirements from the assessment (architecture, state management, error handling, navigation, offline cache, dark mode, animations, and unit tests) were implemented on top of this API.

---

## Project Description

This is an **E-Shop catalog app** where authenticated users can:

- Register, verify email via OTP, and log in
- Browse a paginated list of products with pull-to-refresh
- View product details (price, stock, categories, images)
- Update and delete products
- View profile information and log out
- Switch between light and dark themes
- Continue browsing cached products when offline

The codebase is structured into **data**, **domain**, and **presentation** layers with dependency injection via **get_it**.

---

## Screenshots

### Splash

| Light Mode | Dark Mode |
|:---:|:---:|
| ![Splash — Light](https://github.com/user-attachments/assets/8176aa10-ed93-499d-87d7-2f3b224094dc) | ![Splash — Dark](https://github.com/user-attachments/assets/ff5bcce7-6b15-42a8-9d91-32644f4e8336) |

### Login

| Light Mode | Dark Mode |
|:---:|:---:|
| ![Login — Light](https://github.com/user-attachments/assets/54e749d2-c42e-40c8-ac30-6694a3fb1541) | ![Login — Dark](https://github.com/user-attachments/assets/4ab5cc6a-be5c-41ce-8e5e-fc0067808e2f) |

### Register

| Light Mode | Dark Mode |
|:---:|:---:|
| ![Register — Light](https://github.com/user-attachments/assets/17ef3d4a-fc94-4174-baa5-023bfd9e8b46) | ![Register — Dark](https://github.com/user-attachments/assets/f9b26e7e-9803-4495-891a-61c078153893) |

### OTP Verification

| Light Mode | Dark Mode |
|:---:|:---:|
| ![OTP — Light](https://github.com/user-attachments/assets/21540738-4c5e-4fe2-bd25-f8c2759456d4) | ![OTP — Dark](https://github.com/user-attachments/assets/a9eb9371-0185-422f-bc7e-a48c6dd6c974) |

### Home (Products)

| Light Mode | Dark Mode |
|:---:|:---:|
| ![Home — Light](https://github.com/user-attachments/assets/8aeeee73-dcfa-41f5-ac70-62f3973cbb0b) | ![Home — Dark](https://github.com/user-attachments/assets/36f51402-8024-4b88-a605-7cf301792b33) |

### Product Details

| Light Mode | Dark Mode |
|:---:|:---:|
| ![Product Details — Light](https://github.com/user-attachments/assets/1fd58fa0-23fe-49a4-97c0-6ea1c552cc97) | ![Product Details — Dark](https://github.com/user-attachments/assets/cab9ab72-0658-4b39-a82f-23723a5c1923) |

### Profile

| Light Mode | Dark Mode |
|:---:|:---:|
| ![Profile — Light](https://github.com/user-attachments/assets/dcf61753-185c-46a4-9582-14b92fbe1b4e) | ![Profile — Dark](https://github.com/user-attachments/assets/083e3a9d-d203-49a8-9270-3e0569bb0d3a) |

---

## Screen Recording

Full app walkthrough (auth flow, products, profile, dark mode):

[Watch on Google Drive](https://drive.google.com/file/d/19Io3mPeAjFLXiDlQX0rhVlb-KgQ_BsvN/view?usp=sharing)

---

## Assessment Requirements Coverage

| Requirement | Status | Implementation |
|---|---|---|
| Login (Email + Password) | ✅ | `features/auth` — JWT stored in `flutter_secure_storage` |
| Registration | ✅ | First/Last name, email, password + email OTP verification |
| Auto-navigate if logged in | ✅ | Splash screen checks cached token → `/home` or `/login` |
| Home list from API | ✅ | Paginated products with infinite scroll |
| Title, description, status | ✅ | Name, description, stock & discount on product cards |
| Pull-to-refresh | ✅ | `RefreshIndicator` on products list |
| Empty state | ✅ | Dedicated empty-state widget |
| Detail screen | ✅ | Product detail with full info |
| Item actions (update / delete) | ✅ | Bottom sheet update + delete confirmation dialog |
| Profile (name + email) | ✅ | Fetched from `/api/auth/me` with offline cache fallback |
| Logout | ✅ | Clears tokens, cache, and navigates to login |
| Clean Architecture | ✅ | `data` / `domain` / `presentation` per feature |
| BLoC / Cubit | ✅ | Used consistently across auth, products, profile, theme |
| Dio HTTP client | ✅ | Centralized `DioConsumer` with auth interceptor |
| Local storage | ✅ | `SharedPreferences` + `Hive` offline cache |
| GoRouter navigation | ✅ | Named routes with custom page transitions |
| Loading & error states | ✅ | Sealed states + dedicated UI widgets |
| Reusable components | ✅ | Shared buttons, text fields, cards, bottom nav |
| **Bonus:** Dark mode | ✅ | System / Light / Dark via `ThemeCubit` |
| **Bonus:** Offline cache | ✅ | Hive + connectivity check with cache fallback |
| **Bonus:** Animations | ✅ | Fade & slide page transitions, `AnimatedSwitcher` on tabs |
| **Bonus:** Unit tests | ✅ | Cubit & use case tests — run with `flutter test` |

---

## Tech Stack

| Category | Technology |
|---|---|
| Framework | Flutter (latest stable) |
| Language | Dart 3.11+ |
| State Management | flutter_bloc (Cubit) |
| HTTP Client | Dio |
| Local Storage | SharedPreferences, Hive, flutter_secure_storage |
| Navigation | go_router |
| DI | get_it |
| Architecture | Clean Architecture |
| Responsive UI | flutter_screenutil |
| Image Loading | cached_network_image |
| Connectivity | connectivity_plus |

---

## Project Structure

```
lib/
├── app/                    # MaterialApp, theme wiring
├── core/
│   ├── api/                # Dio consumer, Result type
│   ├── cache/              # Hive setup
│   ├── di/                 # Dependency injection
│   ├── network/            # Auth interceptor, network info
│   ├── router/             # GoRouter + transitions
│   ├── storage/            # Secure storage, app prefs
│   └── theme/              # Light/dark themes, ThemeCubit
└── features/
    ├── auth/               # Login, register, OTP, splash, profile cubit
    └── home/               # Products list, detail, profile tab
test/
└── features/               # Unit tests for cubits & use cases
```

---

## API Reference

**Base URL:** `https://accessories-eshop.runasp.net`

| Endpoint | Method | Description |
|---|---|---|
| `/api/auth/register` | POST | User registration |
| `/api/auth/verify-email` | POST | Email OTP verification |
| `/api/auth/login` | POST | Login → returns JWT |
| `/api/auth/me` | GET | Current user profile |
| `/api/auth/logout` | POST | Logout |
| `/api/products` | GET | Paginated product list |
| `/api/products/{id}` | GET | Product details |
| `/api/products/{id}` | PUT | Update product |
| `/api/products/{id}` | DELETE | Delete product |

**OpenAPI spec:** [https://accessories-eshop.runasp.net/openapi/v1.json](https://accessories-eshop.runasp.net/openapi/v1.json)

**Postman collection:** [Accessories E-Shop API](https://winter-shuttle-873137.postman.co/workspace/My-Workspace~503bd648-8a0a-4e41-8b44-1b7782dfb485/collection/36783660-4239c120-fa6b-490c-b8ff-6999e2d83979?action=share&source=copy-link&creator=36783660)

---

## How to Run

### Prerequisites

- [Flutter SDK](https://docs.flutter.dev/get-started/install) (stable channel)
- Android Studio / Xcode (for emulator or device)
- Internet connection (API calls)

### Steps

```bash
# 1. Clone the repository
git clone https://github.com/AbdelrahmanAddel/technical_assessment_task.git
cd technical_assessment_task

# 2. Install dependencies
flutter pub get

# 3. Run the app
flutter run

# 4. Run unit tests
flutter test
```

### Build APK (Release)

```bash
flutter build apk --release
```

The APK will be generated at:

```
build/app/outputs/flutter-apk/app-release.apk
```

---

## Dependencies

### Production

| Package | Purpose |
|---|---|
| `dio` | HTTP networking |
| `flutter_bloc` | State management (Cubit) |
| `go_router` | Declarative navigation |
| `get_it` | Dependency injection |
| `flutter_secure_storage` | Secure JWT token storage |
| `shared_preferences` | Theme preference & cached user |
| `hive` / `hive_flutter` | Offline product cache |
| `connectivity_plus` | Network status detection |
| `cached_network_image` | Image caching |
| `flutter_screenutil` | Responsive layout |
| `flutter_otp_text_field` | OTP input UI |
| `pretty_dio_logger` | API request logging (debug) |
| `dartx` | Utility extensions |

### Development

| Package | Purpose |
|---|---|
| `flutter_test` | Testing framework |
| `bloc_test` | Cubit/BLoC testing |
| `mocktail` | Mocking dependencies |
| `flutter_lints` | Lint rules |

---

## Testing

Unit tests cover core business logic:

- `ProductsCubit` — load, refresh, pagination
- `ProfileCubit` — load, refresh, logout, restore cached profile
- `GetProductsUseCase`, `GetCurrentUserUseCase`, `LogoutUseCase`, `GetCachedUserUseCase`

```bash
flutter test
```

---

## Demo Credentials

Use these credentials to test the app without registering:

| Field | Value |
|---|---|
| Email | `edgarstuart44@radiant-flow.org` |
| Password | `Sadio@2003` |

> You can also register a new account through the app (email OTP verification is required after registration).

---

## Author

**Abdelrahman Adel**  
Flutter Mobile Developer — Technical Assessment Submission for Electro Pi
