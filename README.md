# 🧳 Travel Assistant

A beautifully designed Flutter application focused on discovering and booking **trips and hotels in Egypt**, built with **Clean Architecture** and **MVVM** pattern using **BLoC** for state management.

---

## 🌟 Features

- 🔥 **Home Tab**
    - Shows Most Popular Trips
    - Categories: Beach, Mountain, Ancient, Wonder

- 🌍 **Explore Tab**
    - Includes `All Trips` and `Hotels` tabs
    - Browse all available destinations

- 🏨 **Explore Details**
  - View full details of each trip or hotel
  - Pricing based on type (hotel/day or trip/person)
  - Add or remove from wishlist

- ❤️ **Wishlist**
  - See all saved favorite destinations
  - Remove with a single tap

- 🧭 **Drawer Menu**Add commentMore actions
  - Navigate to Home
  - Toggle Dark/Light Theme
  - Emergency call button (direct dial)

- 🤖 **Chatbot Assistant**
  - Ask for trip suggestions
  - Find places to go in each city
  - Acts as a virtual travel guide

- 🔐 **Authentication**
  - Sign In, Sign Up, Forgot Password

- 🧑‍💼 **Admin Screen**
  - Add trips or hotels dynamically

- 🚀 **Onboarding Screen**
  - Beautifully introduces app capabilities

---

## 📱 UI Previews

|                                               Dark Mode                                                    |                                             Light Mode                                                     |
|------------------------------------------------------------------------------------------------------------|------------------------------------------------------------------------------------------------------------|
| ![1dark](https://raw.githubusercontent.com/khalidabdelrazk/photos/refs/heads/main/1dark.png)               | ![1light](https://raw.githubusercontent.com/khalidabdelrazk/photos/refs/heads/main/1light.png)             |
| ![1onboarding1](https://raw.githubusercontent.com/khalidabdelrazk/photos/refs/heads/main/1onboarding1.png) | ![1onboarding2](https://raw.githubusercontent.com/khalidabdelrazk/photos/refs/heads/main/1onboarding2.png) |
| ![1onboarding3](https://raw.githubusercontent.com/khalidabdelrazk/photos/refs/heads/main/1onboarding3.png) | ![1onboarding4](https://raw.githubusercontent.com/khalidabdelrazk/photos/refs/heads/main/1onboarding4.png) |
| ![1onboarding5](https://raw.githubusercontent.com/khalidabdelrazk/photos/refs/heads/main/1onboarding5.png) |                                                                                                            |
| ![2dark1](https://raw.githubusercontent.com/khalidabdelrazk/photos/refs/heads/main/2dark1.png)             | ![2light1](https://raw.githubusercontent.com/khalidabdelrazk/photos/refs/heads/main/2light1.png)           |
| ![2dark2](https://raw.githubusercontent.com/khalidabdelrazk/photos/refs/heads/main/2dark2.png)             | ![2light2](https://raw.githubusercontent.com/khalidabdelrazk/photos/refs/heads/main/2light2.png)           |
| ![3dark1](https://raw.githubusercontent.com/khalidabdelrazk/photos/refs/heads/main/3dark1.png)             | ![3light1](https://raw.githubusercontent.com/khalidabdelrazk/photos/refs/heads/main/3light1.png)           |
| ![3dark2](https://raw.githubusercontent.com/khalidabdelrazk/photos/refs/heads/main/3dark2.png)             | ![3light2](https://raw.githubusercontent.com/khalidabdelrazk/photos/refs/heads/main/3light2.png)           |
| ![3dark3](https://raw.githubusercontent.com/khalidabdelrazk/photos/refs/heads/main/3dark3.png)             | ![3light3](https://raw.githubusercontent.com/khalidabdelrazk/photos/refs/heads/main/3light3.png)           |
| ![3dark4](https://raw.githubusercontent.com/khalidabdelrazk/photos/refs/heads/main/3dark4.png)             | ![3light4](https://raw.githubusercontent.com/khalidabdelrazk/photos/refs/heads/main/3light4.png)           |
| ![3dark5](https://raw.githubusercontent.com/khalidabdelrazk/photos/refs/heads/main/3dark5.png)             | ![3light5](https://raw.githubusercontent.com/khalidabdelrazk/photos/refs/heads/main/3light5.png)           |
| ![3dark6](https://raw.githubusercontent.com/khalidabdelrazk/photos/refs/heads/main/3dark6.png)             | ![3light6](https://raw.githubusercontent.com/khalidabdelrazk/photos/refs/heads/main/3light6.png)           |
| ![3dark7](https://raw.githubusercontent.com/khalidabdelrazk/photos/refs/heads/main/3dark7.png)             | ![3light7](https://raw.githubusercontent.com/khalidabdelrazk/photos/refs/heads/main/3light7.png)           |
| ![3dark8](https://raw.githubusercontent.com/khalidabdelrazk/photos/refs/heads/main/3dark8.png)             | ![3light8](https://raw.githubusercontent.com/khalidabdelrazk/photos/refs/heads/main/3light8.png)           |
| ![3dark9](https://raw.githubusercontent.com/khalidabdelrazk/photos/refs/heads/main/3dark9.png)             | ![3light9](https://raw.githubusercontent.com/khalidabdelrazk/photos/refs/heads/main/3light9.png)           |
| ![3dark10](https://raw.githubusercontent.com/khalidabdelrazk/photos/refs/heads/main/3dark10.png)           | ![3light10](https://raw.githubusercontent.com/khalidabdelrazk/photos/refs/heads/main/3light10.png)         |
<div align="center">
  <img src="https://raw.githubusercontent.com/khalidabdelrazk/photos/refs/heads/main/final.png" width="300" alt=" "/>
</div>

> ✅ All screenshots are located in the `_iphone photos` directory.

---

## 🧠 Architecture

- 🧱 **Clean Architecture**
- 🎯 **MVVM Design Pattern**
- 🗂 **Feature-based Structure**
- 🧪 **Modular and Testable**
- 🧪 **Dependency Injection** with `get_it` and `injectable`
- 🔄 **Offline Support** with caching and error handling

---

## 🚀 Getting Started

### Prerequisites

- Flutter SDK (latest stable)
- Android Studio / VSCode / Xcode
- A connected device or emulator

### Installation

```bash
git clone https://github.com/khalidabdelrazk/Travel-App.git
cd Travel-App
flutter pub get
flutter run

---

## 🧩 Packages Used

```yaml
dependencies:
  cupertino_icons: ^1.0.8
  cached_network_image: ^3.4.1
  carousel_slider: ^5.0.0
  google_fonts: ^6.2.1
  badges: ^3.1.2
  flutter_svg: ^2.0.17
  flutter_staggered_grid_view: ^0.4.1
  path_provider: ^2.1.5
  provider: ^6.1.5
  shared_preferences: ^2.5.3
  bloc: ^9.0.0
  flutter_bloc: ^9.1.1
  either_dart: ^1.0.0
  dio: ^5.8.0+1
  get_it: ^8.0.3
  injectable: ^2.5.0
  connectivity_plus: ^6.1.4
  image_picker:
  permission_handler: ^11.3.1
  device_info_plus: ^10.0.1
  flutter_rating_bar: ^4.0.1
  mime: ^1.0.4
  http_parser: ^4.0.2
  path: ^1.8.3
  introduction_screen: ^3.1.17
  flutter_launcher_icons: ^0.14.4
  url_launcher: ^6.2.5

dev_dependencies:
  flutter_test:
    sdk: flutter
  flutter_lints: ^5.0.0
  injectable_generator:
  build_runner:



## 💡 Contribution

Feel free to **fork** the project and **submit a pull request**.  
For major changes, please **open an issue first** to discuss what you would like to change.
