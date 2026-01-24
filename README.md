# Showtime

## A Cross-Platform Movie & TV Show Streaming App

A feature-rich Flutter application for discovering and exploring trending movies and TV shows. Built with the TMDB API, Showtime delivers a seamless browsing experience with detailed information, personalized favorites, and an elegant dark-themed interface.

---

## ✨ Features

### Core Functionality
- **Browse Trending Movies** - Discover the latest trending movies with infinite scrolling pagination
- **Browse Trending TV Shows** - Stay updated with trending television series
- **Detailed Content Pages** - View comprehensive information including:
  - High-quality backdrop and poster images
  - Plot overview and synopsis
  - Release dates and ratings (out of 10)
  - Trailer carousel with YouTube integration
- **Favorites Management** - Add or remove movies and TV shows to a personalized favorites list
- **Unified Favorites View** - Access both saved movies and series from a single tab

### User Experience
- **Infinite Scroll Pagination** - Seamlessly load more content as you scroll to the bottom
- **Dark Theme UI** - Eye-friendly dark interface optimized for content discovery
- **Responsive Grid Layout** - Optimized 3-column poster grid for mobile and tablet devices
- **Smooth Navigation** - Intuitive bottom navigation bar for easy tab switching
- **Fast Load Times** - Efficient caching and network management

---

## 🛠️ Tech Stack

### Framework & Language
- **Flutter 3.0+** - Cross-platform mobile framework
- **Dart** - Primary programming language

### State Management & Architecture
- **Provider 6.1.2** - Reactive state management with ChangeNotifier pattern
- **Three Dedicated Providers**:
  - `MoviesProvider` - Handles trending movies and movie favorites
  - `SeriesProvider` - Manages TV series and series favorites
  - `VideosProvider` - Fetches and manages video trailers

### API & Data
- **TMDB API** - The Movie Database for comprehensive entertainment data
- **HTTP 1.2.2** - Network requests and API communication

### UI Components & Libraries
- **Material Design** - Flutter's Material Design system
- **Carousel Slider 5.0.0** - Interactive carousel for trailers and clips
- **YouTube Player Flutter 9.1.3** - Embedded YouTube video playback

### Storage & Utilities
- **Shared Preferences 2.3.2** - Local key-value storage for app preferences
- **SQLite 2.3.3+1** - Database support for potential future features
- **Flutter InAppWebView 6.0.0** - Web content viewing capabilities
- **Flutter DotEnv 6.0.0** - Environment variable management for secure API key storage

### Development
- **Flutter Lints 3.0.0** - Code quality and style guidelines
- **Flutter Native Splash 2.4.1** - Beautiful splash screen configuration

---

## 📁 Project Structure

```
lib/
├── main.dart                 # App entry point with MultiProvider setup
├── models/
│   ├── movies.dart          # Movies data model with TMDB JSON parsing
│   ├── series.dart          # Series data model with TMDB JSON parsing
│   └── videos.dart          # Videos/trailers data model
├── pages/
│   ├── home_page.dart       # Main navigation hub with bottom nav bar
│   ├── movies_page.dart     # Movies grid with infinite scroll
│   ├── series_page.dart     # TV series grid with infinite scroll
│   ├── movies_details_page.dart  # Movie detail view with trailers
│   ├── series_details_page.dart  # TV series detail view
│   └── favs_page.dart       # Combined favorites display
├── provider/
│   ├── movies_provider.dart       # Movies state management
│   ├── series_provider.dart       # TV series state management
│   └── videos_provider.dart       # Video trailers state management
└── utils/
    ├── constants.dart       # TMDB API key and image base URL
    └── colors.dart          # App color scheme definitions
```

---

## 🚀 Getting Started

### Prerequisites

Before you begin, ensure you have the following installed:

- **Flutter SDK** - Version 3.0 or higher
  - [Download Flutter](https://flutter.dev/docs/get-started/install)
- **Dart SDK** - Comes bundled with Flutter
- **TMDB API Key** - Free account at [The Movie Database](https://www.themoviedb.org/signup)
- **Android Studio** or **Xcode** (for iOS development)

### Installation

1. **Clone the repository**

```bash
git clone https://github.com/AritraC1/Showtime.git
cd Showtime
```

2. **Install dependencies**

```bash
flutter pub get
```

3. **Get your TMDB API Key**

- Visit [themoviedb.org](https://www.themoviedb.org/signup) and create a free account
- Go to Settings → API to generate your API key

### Configuration

1. **Create a `.env` file**

In the root of your project, create a `.env` file with your TMDB API key:

```env
TMDB_API_KEY=your_tmdb_api_key_here
```

2. **Verify `.gitignore`**

Make sure your `.gitignore` includes `.env` to keep your API key secure:

```
.env
```

3. **How It Works**

The app uses `flutter_dotenv` to load environment variables at runtime. The `main.dart` initializes the dotenv package:

```dart
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  // ... rest of app initialization
}
```

The API key is accessed from `lib/utils/constants.dart`:

```dart
class Constants {
  static String get apiKey => dotenv.env['TMDB_API_KEY'] ?? '';
  static const imagePath = 'https://image.tmdb.org/t/p/w500';
}
```

---

## 📱 Running the App

### Run on Development Device

```bash
flutter run
```

### Run on Specific Device/Emulator

```bash
flutter devices                    # List available devices
flutter run -d <device_id>        # Run on specific device
```

### Run in Release Mode

```bash
flutter run --release
```

### Build Standalone APK (Android)

```bash
flutter build apk --release
```

### Build for iOS

```bash
flutter build ios --release
```

---

## 🎯 How to Use

### Browse Content

1. **Movies Tab** - Swipe up to explore trending movies
2. **TV Series Tab** - Swipe up to explore trending series
3. **Tap any poster** - View detailed information about a title

### View Details

- **Overview** - Read full plot synopsis
- **Release Date** - Check when the content was released
- **Rating** - View average community ratings (0-10 scale)
- **Trailers** - Watch video clips via YouTube Player

### Manage Favorites

1. **Add to Favorites** - Tap the heart icon on any detail page
2. **View Favorites** - Go to the Favorites tab
3. **Remove Favorites** - Tap the heart icon again to unfavorite
4. **Favorites persist** - During the current app session

---

## 🔑 API Integration

### TMDB API Endpoints Used

- **Trending Movies**: `/trending/movie/day`
- **Trending TV**: `/trending/tv/day`
- **Movie Videos**: `/movie/{id}/videos`

### Pagination

- Both movies and series support page-based pagination
- Automatic page increments as user scrolls to bottom
- Loading state prevents duplicate requests

---

## 📦 Dependencies Overview

| Package                  | Version | Purpose           |
|--------------------------|---------|-------------------|
| `provider`               | 6.1.2   | State management  |
| `http`                   | 1.2.2   | HTTP requests     |
| `carousel_slider`        | 5.0.0   | Image carousels   |
| `youtube_player_flutter` | 9.1.3   | Video playback    |
| `flutter_native_splash`  | 2.4.1   | App splash screen |
| `shared_preferences`     | 2.3.2   | Local storage     |
| `sqflite`                | 2.3.3+1 | Database support  |
| `flutter_inappwebview`   | 6.0.0   | Web content       |
| `flutter_dotenv`         | 6.0.0   | Environment vars  |

---

## 🚧 Future Enhancements

- [ ] **Search Functionality** - Search for specific movies or series
- **Persistent Favorites** - Save favorites using SharedPreferences or SQLite
- **User Reviews** - Read and write user reviews
- **Rating & Sorting** - Filter content by rating or release date
- **Watchlist** - "Want to Watch" list alongside favorites
- **Dark/Light Theme Toggle** - Dynamic theme switching
- **Multiple Languages** - Localization support
- **Cast Information** - Display actor and crew details
- **Similar Recommendations** - Suggest similar movies/shows
---

## 📝 Recent Updates

### Version Updates
- **YouTube Player Flutter** - Updated to 9.1.3 for improved video playback
- **Flutter SDK** - Minimum version updated to 3.24.0
- **Dart SDK** - Minimum version updated to 3.5.0

### Security Improvements
- **Added `flutter_dotenv` 6.0.0** - Secure environment variable management
- **Removed hardcoded API key** - Now uses `.env` file for sensitive data
- **Added INTERNET permission** - Android manifest now explicitly includes internet permission

### Code Quality
- **Improved code formatting** - Better readability and adherence to Dart style guide
- **Dynamic API URL construction** - URL builders now use getters for better integration with dotenv
- **Async main initialization** - App properly initializes dotenv before running

### Dependencies
- **flutter_inappwebview** - Upgraded and properly configured as direct dependency
- **YouTube Player Flutter** - Updated to latest stable version for better compatibility
---

## 🤝 Contributing

Contributions are welcome! We appreciate any improvements, bug fixes, or new features.

### How to Contribute

1. **Fork the repository** - Create your own copy
2. **Create a feature branch** - `git checkout -b feature/amazing-feature`
3. **Make your changes** - Implement your improvements
4. **Commit your changes** - `git commit -m 'Add amazing feature'`
5. **Push to the branch** - `git push origin feature/amazing-feature`
6. **Open a Pull Request** - Submit your changes for review

### Code Style

- Follow [Dart style guide](https://dart.dev/guides/language/effective-dart/style)
- Use meaningful variable and function names
- Add comments for complex logic
- Keep methods focused and small

---

## 📞 Support & Feedback

If you encounter any issues or have suggestions:

- Open an [Issue](https://github.com/AritraC1/Showtime/issues) on GitHub
- Check existing issues before creating new ones
- Provide detailed information about your problem

---
