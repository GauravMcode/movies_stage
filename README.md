# 🎬 Stage Movies App

[![App Demo](https://img.shields.io/badge/Watch%20App%20Demo-Click%20Here-blue?style=for-the-badge)](https://drive.google.com/file/d/18qV9gBqZvFh2VR1wbCivpn-tAJogq0aY/view)

The App has been built with  w **Flutter** and **BLoC**, it follows clean layered architecture, error handling, offline support, and fluid user interface interactions.  
The app uses a **Supabase serverless function** as a proxy to retrieve movie data because of TMDB API limitations in India.

---

## Features

- As TMDB wasn't accessible directly due to restrictions in India by some ISPs, Therefore I deployed a server less function in supabase that fetches TMDB data for us
- for local caching of Favorite movies, isar database is used which saves the fav movie data along with images locally. Thus, providing offline access.
- Toggle to view fav movies, search movie functionality, tap movie to view details  has been added as well
- API errors have been handled, showing toast whenever unable to connect to internet.
- Integration tests have been added as well

---

## Tech Stack 🧰

**Flutter** - **BLoC (flutter_bloc)** - **Isar Database** - **Supabase Serverless Functions** - **HTTP for network** - **Flutter Toast for feedback** - **Integration Testing Framework**

---