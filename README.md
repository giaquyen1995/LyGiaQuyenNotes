# LyGiaQuyenNotes

## Introduction

LyGiaQuyenNotes is a simple iOS application developed using SwiftUI. It allows users to set a username, save notes, and retrieve their own or others' notes from a Google Firebase real-time database.

## Approach

The approach taken to develop this application involves:

1. **Firebase Setup**: The Firebase real-time database is used for storing and retrieving notes. 

2. **UI Design**: The user interface components have been developed using SwiftUI for a modern, intuitive and user-friendly experience.

3. **User Interface**: The application comprises separate screens for register, signin, home , creating and update notes, displaying a list of user notes, and viewing all notes from different users.

4. **Data Management**: Integration of Firebase real-time database for saving and fetching notes. The database structure has been designed to store notes against the respective usernames.

5. **Architecture**: The application follows the MVVM (Model-View-ViewModel) architectural pattern. This architecture is ideal for SwiftUI applications because it supports two-way data binding, which automatically ensures that the UI is kept in sync with updates to the underlying data. Moreover, by separating concerns, it makes the code more maintainable and testable:
   
   - **Model**: Represents the data and business logic of the app. The models are the data structures used to work with the notes in the Firebase database.
   - **View**:  The View represents the UI of the app. In SwiftUI, views are a function of their state and are updated automatically when their state changes. The views in this app include the screens for register, signin, creating notes, and home to displaying the list of notes.
   - **ViewModel**: The ViewModel serves as a bridge between the Model and the View. It exposes the data and commands that the View can use to perform actions. This means that the View doesn't need to know anything about the Model, which helps to keep the UI code clean and simple. The ViewModels in this app handle operations such as saving and retrieving notes from Firebase.
   
   By using the MVVM pattern, the application can achieve a clean, modular design where it's easy to understand how different parts of the code interact, making the codebase easier to maintain and evolve over time.



## Time Spent

The following is an approximation of the time spent during the development:

1. Understanding and setting up Firebase: [2 hours]
2. UI Design using SwiftUI: [8 hours]
3. Integrating Firebase for data operations: [2 hours]
4. Testing and debugging: [4 hours]

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
