# OOTD Fashion App

This app, coded entirely in Swift, serves as a virtual closet allowing users to upload pictures of their clothing and make outfits with them.

## User Interface
<img src="https://github.com/kyshu11027/OOTD/assets/96274909/f76e9e3f-44f8-4ea6-b605-06a994b766fa" width="250">
<img src="https://github.com/kyshu11027/OOTD/assets/96274909/d689343a-20c5-431b-aa9d-e15482d925b1" width="250">
<img src="https://github.com/kyshu11027/OOTD/assets/96274909/9b91dca2-4977-47f9-8900-f958a51aea79" width="250">
<img src="https://github.com/kyshu11027/OOTD/assets/96274909/b91f3c43-5251-44a9-9df3-dd7f35a6aa56" width="250">
<img src="https://github.com/kyshu11027/OOTD/assets/96274909/62220b4e-19e2-4fbf-8056-6e8a313fed1d" width="250">

## Data Model
Users had to be able to create accounts, access their saved clothing items, and access their saved outfits. Clothing items consisted of strings and an image.

# Firebase Auth
Used to store user login data in a secure and efficient manner

# Firebase Storage
Used to store image data that was linked to the clothing object it belonged to

# Firestore Database
Used to store clothing item data and outfit data linked to the proper user to be queried and accessed upon login.
