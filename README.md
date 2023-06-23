# LyGiaQuyenNotes

## Introduction

LyGiaQuyenNotes is a simple iOS application developed using SwiftUI. It allows users to set a username, save notes, and retrieve their own or others' notes from a Google Firebase real-time database.

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
