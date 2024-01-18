# OOTD Fashion App

This app, coded entirely in Swift, serves as a virtual closet allowing users to upload pictures of their clothing and make outfits with them.

## User Interface
![ootd](https://github.com/kyshu11027/OOTD/assets/96274909/5d1ad45b-c4ca-42b9-8d7f-b771b120a519 | width=250)
![Simulator Screen Shot - iPhone 14 Pro - 2024-01-17 at 21 30 37](https://github.com/kyshu11027/OOTD/assets/96274909/2c71460a-424c-4464-aee9-4f497b5659a1 | width=250)
![Simulator Screen Shot - iPhone 14 Pro - 2024-01-17 at 21 30 22](https://github.com/kyshu11027/OOTD/assets/96274909/2afb5288-3cbd-421f-8ea3-636e97ff8346 | width=250)
![Simulator Screen Shot - iPhone 14 Pro - 2024-01-17 at 21 30 45](https://github.com/kyshu11027/OOTD/assets/96274909/7a5da2d4-cdc7-4684-b6ae-03a3507a4d8f | width=250)
![Simulator Screen Shot - iPhone 14 Pro - 2024-01-17 at 21 31 00](https://github.com/kyshu11027/OOTD/assets/96274909/2cbebba7-e7f3-42f0-940d-e9fcb936d1ff | width=250)

## Data Model
Users had to be able to create accounts, access their saved clothing items, and access their saved outfits. Clothing items consisted of strings and an image.

# Firebase Auth
Used to store user login data in a secure and efficient manner

# Firebase Storage
Used to store image data that was linked to the clothing object it belonged to

# Firestore Database
Used to store clothing item data and outfit data linked to the proper user to be queried and accessed upon login.
