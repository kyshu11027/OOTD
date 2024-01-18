# OOTD Fashion App

This app, coded entirely in Swift, serves as a virtual closet allowing users to upload pictures of their clothing and make outfits with them.

## User Interface
<img src="https://github.com/kyshu11027/OOTD/assets/96274909/f76e9e3f-44f8-4ea6-b605-06a994b766fa" width="250">
<img src="https://github.com/kyshu11027/OOTD/assets/96274909/d689343a-20c5-431b-aa9d-e15482d925b1" width="250">
<img src="https://github.com/kyshu11027/OOTD/assets/96274909/f8cfd43a-a911-4393-ad13-59800191f831" width="250">
<img src="https://github.com/kyshu11027/OOTD/assets/96274909/f8cfd43a-a911-4393-ad13-59800191f831" width="250">
<img src="https://github.com/kyshu11027/OOTD/assets/96274909/f8cfd43a-a911-4393-ad13-59800191f831" width="250">

![Simulator Screen Shot - iPhone 14 Pro - 2024-01-17 at 21 49 08]()




## Data Model
Users had to be able to create accounts, access their saved clothing items, and access their saved outfits. Clothing items consisted of strings and an image.

# Firebase Auth
Used to store user login data in a secure and efficient manner

# Firebase Storage
Used to store image data that was linked to the clothing object it belonged to

# Firestore Database
Used to store clothing item data and outfit data linked to the proper user to be queried and accessed upon login.
