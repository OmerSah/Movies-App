# **Movies-App**
- A four-paged movie list app
- The first appearing screen is the splash screen
- The data is fetched from the [TMDb API](https://developers.themoviedb.org/3/getting-started/introduction)
- The first screen inside the app lists all of the movies with different sections(endpoints) and supporting search and filter 
- Search by the name of the movie and filter by the category
- By tapping one of the movies, the movie detail screen appears
- Can able to add the movie into the bookmarks via bookmark button
- The last screen is the bookmarks which have the bookmarked movies
</br>

<div align="center">

| Splash Screen  | List | Category | 
| ------------- | ------------- | ------------- |
| <img src="Images/SplashScreen.png" alt="ss" width="220"/> | <img src="Images/StartingPage.png" alt="ss" width="220"/>  | <img src="Images/Filtering.png" alt="ss" width="220"/>  |


| Search  | Detail | 
| ------------- | ------------- |
| <img src="Images/SearchPage.png" alt="ss" width="220"/> | <img src="Images/DetailPage.png" alt="ss" width="220"/> | 

</div>

# **How It Works?**
- Bookmark or delete from bookmarks any movie with bookmark button on the right corner of the movie poster
- If a movie exists more than one section it bookmarks automatically all of the occurences of that movie 
- Can use tab bar to see all bookmarked movies
- Can see detail page with selecting specified row
</br>

<div align="center">

| Bookmark  | Searching | Filtering  | Bookmark All |
| ------------- | ------------- | ------------- | ------------- |
| <img src="Images/Bookmark.gif" alt="drawing" width="220"/> | <img src="Images/Searching.gif" alt="drawing" width="220"/>  | <img src="Images/Filtering.gif" alt="drawing" width="220"/>  | <img src="Images/BookmarkMultiple.gif" alt="drawing" width="220"/>  |

</div>

# **Technical Keywords**
- MVVM
- Table view
- Codable
- SPM
- SnapKit
- Kingfisher
- Generic network layer
- Delegation
- Closures
- URLSession
- Singleton
- UserDefaults
