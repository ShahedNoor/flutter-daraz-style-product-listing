# Flutter Daraz Style Product Listing

A Flutter app replicating a complex e-commerce product listing UI, focusing specifically on scroll architecture and gesture coordination.

**Note on the codebase:** This project is built on top of my standard daily boilerplate template. It uses a Feature-Based Clean Architecture pattern with RxDart and GetIt. Because of this, there are a bunch of extra folders and files (like networking, auth, common helpers, etc.) that are just boilerplate. You can safely ignore them and focus on the `product_listing` feature folder. The app uses the required/mentioned Mock API (Fake Store API) for data.

## How to Run

1. Clone the repository or extract the zip.
2. Open a terminal in the project root.
3. Run the following commands:
```bash
flutter clean && flutter pub get
flutter run
```

## Test Credentials
After opening the app for the first time, login with these credentials to access the app:
- **Username:** `mor_2314`
- **Password:** `83r5^_`

## How Horizontal Swipe was Implemented

I implemented horizontal swiping using Flutter's native `TabBarView` linked directly to a `TabController`. `TabBarView` handles horizontal drag gestures smoothly right out of the box. It manages the page transitions natively, preventing any weird conflicts with vertical dragging.

## Who Owns the Vertical Scroll and Why

The vertical scroll is primarily owned and coordinated by a parent `NestedScrollView`.

**Why:** The requirement was a single vertical scrollable behavior where the top header collapses, and tabs maintain their individual scroll states without jumping or jittering. 
- The outer `NestedScrollView` holds the dynamic collapsing header (the logo fading into a search bar).
- The inner body holds the `TabBarView`.
- Inside each tab, there is a `CustomScrollView` with a `SliverGrid`.

`NestedScrollView` natively passes scroll notifications between the inner lists and the outer header. It handles collapsing the header first. Crucially, by giving each tab's inner `CustomScrollView` a unique `PageStorageKey`, Flutter automatically remembers their exact scroll offsets. When you switch back and forth between tabs, you return to the exact pixel you left off at.

## Trade-offs and Limitations

- **Sliver Constraints:** `NestedScrollView` can be rigid. It demands that the inner body provides actual scrollable extents. To ensure that tabs with very few products can still push the header up to collapse it, I had to inject a `SliverToBoxAdapter` with a blank `SizedBox` at the bottom of the lists as a scroll buffer.
- **Complex Header Animations:** Fading between the Daraz logo and the search bar based on scroll offset required a custom `LayoutBuilder` checking the scroll constraints manually, since standard `SliverAppBar.flexibleSpace` doesn't support complex widget swapping cleanly based on pinned states.
