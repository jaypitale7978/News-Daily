# News Daily

A Flutter news application built as part of a Flutter technical assignment. The app fetches news from a public news API and provides users with a simple way to browse, search, read, and save news articles.

## Features

* View latest news on the home screen
* Browse news by category
* Search for news articles and topics
* Trending search topics
* Recent searches
* Open full articles using WebView
* Save/bookmark articles
* View saved articles
* Remove saved articles
* Clear all saved articles
* Pagination while scrolling
* Pull to refresh
* Loading states while fetching data
* Error handling for failed API requests
* "No news found" state for empty searches
* Back navigation from search and article screens
* Local storage for saved articles and recent data

## Screens

### Home

The home screen shows the latest news along with different news categories and trending content.

### Search

Users can search for a specific topic, source, or keyword.

The search screen also includes:

* Trending searches
* Recent searches
* Clear search option
* Pagination
* Loading state
* Error state
* No results state

### Article

When a user taps on an article, the original article is opened inside a WebView.

A loading animation is displayed while the article is loading.

### Saved

Users can save articles using the bookmark button available on news cards.

Saved articles are stored locally so they can be accessed later.

## API

The application uses a custom API server which acts as a wrapper around the news API.

Base API:

```text
https://news-project-six-tau.vercel.app/api/news
```

Examples:

```text
/api/news/top-headlines?country=us

/api/news/top-headlines?country=us&category=business

/api/news/everything?q=bitcoin
```

The API is used for fetching headlines, categories, and search results.

## Tech Stack

* Flutter
* Dart
* GetX
* HTTP
* WebView Flutter
* Lottie
* SharedPreferences
* News API

## 📁 Project Structure

lib/
├── app/
│   └── styles/
│       ├── app_colors.dart
│       ├── app_size.dart
│       └── app_text_style.dart
│
├── core/
│   ├── const/
│   │   └── animations/
│   │       └── animations.dart
│   │
│   ├── network/
│   │   ├── api_client.dart
│   │   └── api_services.dart
│   │
│   ├── storage/
│   │   └── storage_service/
│   │       └── storage_service.dart
│   │
│   └── utils/
│
└── features/
    ├── home/
    │   ├── view/
    │   │   └── home_page.dart
    │   │
    │   └── widgets/
    │       ├── browse_topics.dart
    │       ├── hero_article.dart
    │       ├── home_header.dart
    │       ├── latest_section.dart
    │       ├── news_card.dart
    │       ├── news_divider.dart
    │       └── topic_chip.dart
    │
    ├── article/
    │   └── view/
    │       └── article_webview.dart
    │
    ├── news/
    │   ├── bindings/
    │   │   └── news_bindings.dart
    │   │
    │   ├── controller/
    │   │   └── news_controller.dart
    │   │
    │   ├── model/
    │   │   ├── article_model.dart
    │   │   └── news_category.dart
    │   │
    │   └── service/
    │       └── news_service.dart
    │
    ├── search/
    │   ├── controller/
    │   │   └── search_news_controller.dart
    │   │
    │   ├── model/
    │   │
    │   ├── view/
    │   │   └── search_page.dart
    │   │
    │   └── widget/
    │       ├── article_divider.dart
    │       ├── search_article.dart
    │       └── trending_chip.dart
    │
    ├── saved/
    │   ├── controller/
    │   │   └── saved_news_controller.dart
    │   │
    │   └── view/
    │       └── saved_page.dart
    │
    ├── bottomNavigation/
    │   ├── controller/
    │   │   └── navigation_controller.dart
    │   │
    │   └── view/
    │       ├── bottom_navigationBar.dart
    │       └── navigation_page.dart
    │
    └── splash/
        ├── controller/
        │   └── splash_controller.dart
        │
        └── view/
            └── splash_page.dart

### State Management

GetX is used for state management.

Controllers are responsible for handling:

* API calls
* Loading states
* Error states
* Pagination
* Search state
* Saved article state
* Navigation state

The UI uses reactive `Obx` widgets where required so that only the relevant parts of the UI update when the state changes.

## Local Storage

SharedPreferences is used to store data that should remain available after the application is closed.

It is mainly used for saved/bookmarked news and local search-related data.

## Loading and Error Handling

The application handles different API states:

* Initial loading
* Pagination loading
* API/network errors
* Empty search results
* Image loading failures

A loading indicator is shown while data is being fetched, and users are given a retry option when an API request fails.

## Pagination

News lists support pagination.

When the user reaches the end of the current list, the next page is requested from the API and added to the existing articles.

This avoids loading a large number of articles at once.

## Running the Project

### Requirements

Make sure Flutter is installed and configured correctly.

Check your Flutter installation with:

```bash
flutter doctor
```

### Clone the repository

```bash
git clone git@github.com:jaypitale7978/News-Daily.git
```

Go to the project:

```bash
cd News-Daily
```

### Install dependencies

```bash
flutter pub get
```

### Run the application

```bash
flutter run
```

## Main Dependencies

The project uses the following Flutter packages:

```yaml
get:
http:
shared_preferences:
webview_flutter:
lottie:
```

Run the following command if dependencies need to be downloaded:

```bash
flutter pub get
```

## Assignment Requirements Covered

| Requirement             | Status |
| ----------------------- | ------ |
| Public news API         | Done   |
| News categories         | Done   |
| Home screen             | Done   |
| Category/news browsing  | Done   |
| Article screen          | Done   |
| WebView article reading | Done   |
| State management        | Done   |
| Pagination              | Done   |
| Pull to refresh         | Done   |
| Loading states          | Done   |
| Error handling          | Done   |
| Search                  | Done   |
| Bookmark/save articles  | Done   |
| Local storage           | Done   |
| Smooth navigation       | Done   |

## Notes

The article content provided by the news API is limited, so the application opens the original article URL in a WebView when the user selects an article. This allows the user to read the complete article from the original source.
