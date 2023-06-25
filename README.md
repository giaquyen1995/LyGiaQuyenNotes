# LyGiaQuyenNotes

# Introduction

LyGiaQuyenNotes is a simple iOS application developed using SwiftUI. It allows users to register, sign in, save notes, and retrieve their own or others' notes from a Google Firebase real-time database.

In this project I apply MVVM.

#MVVM (Model–View–ViewModel)
MVVM is one of the most favored patterns currently, as it has had ample time to mature. The web community adopted this pattern after it was formalized by Microsoft team in 2005. It has since been incorporated into every UI-based framework. One of the key advantages of MVVM is that it offers an optimal level of decoupling. Another positive aspect is that the learning curve is similar to other patterns.

MVVM has three main components: Model, View, and ViewModel.

![MVVM](https://github.com/giaquyen1995/LyGiaQuyenNotes/assets/31946572/0f8f8503-d5c4-4a58-8fea-c1f35991a696)


- **Model**: Represents the data and business logic of the app. The models are the data structures used to work with the notes in the Firebase database.

- **View**:  The View represents the UI of the app. In SwiftUI, views are a function of their state and are updated automatically when their state changes. The views in this app include the screens for register, signin, creating notes, and home to displaying the list of notes.

- **ViewModel**: The ViewModel serves as a bridge between the Model and the View. It exposes the data and commands that the View can use to perform actions. This means that the View doesn't need to know anything about the Model, which helps to keep the UI code clean and simple. The ViewModels in this app handle operations such as saving and retrieving notes from Firebase.

#Why MVVM with Clean Architecture?
MVVM separates our view from our business logic. MVVM is sufficient for small projects, but when our codebase becomes large, our ViewModels start bloating. Separating responsibilities becomes challenging.

MVVM with Clean Architecture is a good solution in such cases. It goes a step further in segregating the responsibilities of our codebase. It clearly abstracts the logic of the actions that can be performed in our app.

## Approach

The approach taken to develop this application involves:

1. **Firebase Setup**: The Firebase real-time database is used for storing and retrieving notes. 

2. **UI Design**: The user interface components have been developed using SwiftUI for a modern, intuitive and user-friendly experience.

3. **User Interface**: The application comprises separate screens for register, signin, home , creating and update notes, displaying a list of user notes, and viewing all notes from different users.

4. **Data Management**: Integration of Firebase real-time database for saving and fetching notes. The database structure has been designed to store notes against the respective usernames.


## Time Spent

The following is an approximation of the time spent during the development:

1. Understanding and setting up Firebase: [2 hours]
2. UI Design using SwiftUI: [8 hours]
3. Integrating Firebase for data operations: [2 hours]
5. Create UnitTest: [2 hours]
4. Testing and debugging: [2 hours]

## Known Issues or Limitations

1. User Authentication: Currently, there is no mechanism for authenticating users. Therefore, anyone can use any username to save and retrieve notes, which could lead to data privacy issues.

2. Offline Functionality: The app does not support offline functionality. If the user is not connected to the internet, they will not be able to save or retrieve notes.

3. Rate Limiting: Firebase free tier has limitations on the number of reads and writes per day. If the quota is exceeded, the app might not function as expected.

4. Data Validation: The application currently doesn't validate the input data, which could lead to saving of inappropriate content.

## Running the Application

1. Clone the repo
2. Open the project in Xcode
3. Run the app on a simulator or an actual device

Please ensure that you have the latest versions of SwiftUI and Firebase installed in your Xcode.
