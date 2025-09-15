# DuniMovie
## What is this project?
A Flutter app to browse movies, search (via API), view details, manage a local Watchlist (favorites), and show a simple profile screen.
- Only the Search feature connects to the API.
- Watchlist and search history are stored locally.
  
<img width="1600" height="1200" alt="Mockup 2" src="https://github.com/user-attachments/assets/5a3dc0c3-4b14-4d47-8453-8ee9c96c54d8" />

## Tech Stack
- Flutter 3 + Dart
- Riverpod 2 (state management)
- Dio 5 (HTTP client)
- SharedPreferences 2 (local storage)
- Navigator + custom Bottom Navigation
- Dark theme + custom Status Overlay

## Architecture
- Layered (Clean-ish) + MVVM in the UI layer:
  - core: shared code (network, utils, base widgets)
  - features: each capability isolated (movies, search, watchlist, profile)
    - data: models, data sources, repository implementations
    - domain: entities, repository contracts, use cases
    - presentation: pages, widgets, controllers/providers
- Data flow: UI → Provider/UseCase → Repository → DataSource → API/Local → UI

## State Management (Riverpod)
- Search: FutureProvider.family(query) with Async states (loading/data/error) and AutoDispose to cancel stale requests.
- Watchlist: AsyncNotifier<List<MovieLite>> + a Set<int> of ids for quick exists(id).
  - Methods: load, add, remove, toggle, clear.

## API (Search only)
- Service: https://moviesapi.ir
- Endpoint:
    - GET /api/v1/movies?q=QUERY&page=1
- Maps response fields: id, title, poster, year, imdb_rating for list display.
- Web CORS: poster URLs are proxied through images.weserv.nl (web_image_proxy) to avoid CORS/mixed content issues.
- Errors/timeout: reasonable Dio timeouts + user-friendly states (loading/error/empty).

## Watchlist (Local only)
- Storage: SharedPreferences (key: watchlist_v1) as a JSON array of MovieLite:
  - Fields: id, title, poster, year, imdbRating, genres?, runtimeMinutes?
- Global provider:
 - exists(id) to render heart filled/outline
- toggle(movieLite) to add/remove instantly (optimistic UI) + persist to local storage
Watchlist page:
  - Data source is only the local provider
  - Remove via swipe or delete action
  - Empty state per design

## Theme & UI
- Dark theme: primary background #34324A
- Bottom Navigation: #26253A, persistent across pages
- Status Overlay (STATUS.png): global by default; on certain pages (e.g., Detail) it’s drawn inside the header so it scrolls with content
- Cross-device stability: ui_scale helpers (sw/sh/sp) + Wrap to avoid overflows on chip/cast rows

## Setup & Run
- pubspec.yaml (key deps): dio, flutter_riverpod, shared_preferences
- Commands:
  - flutter clean
  - flutter pub get
  - flutter run
- Android: AndroidManifest should include INTERNET permission
- iOS: posters are https; ATS exceptions typically not needed (for http you’d add exceptions)
- Web: posters proxied via web_image_proxy → images.weserv.nl

## Future Enhancements (optional)
- Search pagination (infinite scroll)
- Debounced live search (no explicit submit)
- Movie detail from API by id
- Result caching
- Migrate Watchlist to Hive for larger datasets or local filtering/sorting

## Summary
- API is used only by the Search feature; other parts (especially Watchlist) are fully local.
- Modular architecture + Riverpod keeps state predictable and testable.
- UI remains robust across devices using scaling helpers and Wrap to prevent overflow.
