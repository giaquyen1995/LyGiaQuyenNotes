# LyGiaQuyenNotes

# Introduction

LyGiaQuyenNotes is a simple iOS application developed using SwiftUI. It allows users to register, sign in, save notes, and retrieve their own or others' notes from a Google Firebase real-time database.

In this project I apply MVVM.

# MVVM (Model–View–ViewModel)

MVVM is one of the most favored patterns currently, as it has had ample time to mature. The web community adopted this pattern after it was formalized by Microsoft team in 2005. It has since been incorporated into every UI-based framework. One of the key advantages of MVVM is that it offers an optimal level of decoupling. Another positive aspect is that the learning curve is similar to other patterns.

MVVM has three main components: Model, View, and ViewModel.

![MVVM](https://github.com/giaquyen1995/LyGiaQuyenNotes/assets/31946572/0f8f8503-d5c4-4a58-8fea-c1f35991a696)


- **Model**: Represents the data and business logic of the app. The models are the data structures used to work with the notes in the Firebase database.

- **View**:  The View represents the UI of the app. In SwiftUI, views are a function of their state and are updated automatically when their state changes. The views in this app include the screens for register, signin, creating notes, and home to displaying the list of notes.

- **ViewModel**: The ViewModel serves as a bridge between the Model and the View. It exposes the data and commands that the View can use to perform actions. This means that the View doesn't need to know anything about the Model, which helps to keep the UI code clean and simple. The ViewModels in this app handle operations such as saving and retrieving notes from Firebase.

# Why MVVM with Clean Architecture?

- MVVM separates our view from our business logic. By using the MVVM pattern, the application can achieve a clean, modular design where it's easy to understand how different parts of the code interact, making the codebase easier to maintain and evolve over time.

# Detail Overview

#### Model 

Represents the data and business logic of the app

```swift
public struct NoteResponse: Codable {
public let userId: String
public let notes: [Note] 
}
```

#### View 

The View represents the UI of the app Text, Tabview...

```swift
    NavigationView {
            TabView(selection: $selection) {
                NotesListView(reloadNote: $reloadNote, useOtherNotes: false, notes: viewModel.myNotes)
                    .tabItem {
                        Label("My Notes", systemImage: "1.square.fill")
                    }
                    .tag(0)
                
                NotesListView(reloadNote: $reloadNote, useOtherNotes: true, notes: viewModel.othersNotes)
                    .tabItem {
                        Label("Other's Notes", systemImage: "2.square.fill")
                    }
                    .tag(1)
            }
    }
```

#### ViewModel

* ViewModel is the main point of MVVM application. The primary responsibility of the ViewModel is to provide data to the view, so that view can put that data on the screen.
* It also allows the user to interact with data and change the data.
* The other key responsibility of a ViewModel is to encapsulate the interaction logic for a view, but it does not mean that all of the logic of the application should go into ViewModel.
* It should be able to handle the appropriate sequencing of calls to make the right thing happen based on user or any changes on the view.
* ViewModel should also manage any navigation logic like deciding when it is time to navigate to a different view.
[Source](https://www.tutorialspoint.com/mvvm/mvvm_responsibilities.htm)

ViewModel performs pure transformation of a user Input to the Output:

```swift
    @MainActor class HomeViewModel: BaseObservableObject {
        @Published var myNotes:[Note] = []
        @Published var othersNotes:[Note] = []

        func fetchNotes() {}
    }
    
```

```swift
    struct HomeView: View { 
        @StateObject var viewModel = HomeViewModel()
    }
```

A ViewModel can be injected into a View. In the current example, this is done by HomeView.

```swift
    .onChange(of: reloadNote) { _ in
    viewModel.fetchNotes()
    reloadNote = false
    }
```
The user interacts with the model view through the view. In the current example, call the api to get the list of notes

```swift
    func fetchNotes() {
        let task =  Task {
            do {
            let myNotes = try await API.getMyNotes(forUser: FireBaseManager.shared.userId)
            let othersNotes = try await API.getOthersNotes()

            } catch {
            print("Error fetching notes: \(error)")
            }
        }
        addTasks([task])
    }
```
ViewModel interacts with Model to request and receive data. In current example, call api list to firebase server

```swift 
    @MainActor class HomeViewModel: BaseObservableObject {
        @Published var myNotes:[Note] = []
        @Published var othersNotes:[Note] = []

        func fetchNotes() {
        ///
        self.myNotes = myNotes.sorted(by: { $0.date > $1.date })
        self.othersNotes = othersNotes.sorted(by: { $0.date > $1.date })
        ///
        }
    }
```   
ViewModel returns data on View through binding. In the current example, when model update data for myNotes and otherNotes, the data return via @ObservableObject

```swift
        .onReceive(viewModel.$myNotes.combineLatest(viewModel.$othersNotes), perform: { (myNotes,otherNotes) in
            self.myNotes = myNotes
            self.othersNotes = otherNotes
        })
```

```swift
    NavigationView {
        TabView(selection: $selection) {
            NotesListView(reloadNote: $reloadNote, useOtherNotes: false, notes: myNotes)
            .tabItem {
            Label("My Notes", systemImage: "1.square.fill")
            }
            .tag(0)

            NotesListView(reloadNote: $reloadNote, useOtherNotes: true, notes: othersNotes)
            .tabItem {
            Label("Other's Notes", systemImage: "2.square.fill")
            }
            .tag(1)
        }
    }
```
View UI updates when a data update signal is received from the ViewModel via the @StateObject listener mechanism
# Approach

The approach taken to develop this application involves:

1. **Firebase Setup**: The Firebase real-time database is used for storing and retrieving notes. 

2. **UI Design**: The user interface components have been developed using SwiftUI for a modern, intuitive and user-friendly experience.

3. **User Interface**: The application comprises separate screens for register, signin, home , creating and update notes, displaying a list of user notes, and viewing all notes from different users.

4. **Data Management**: Integration of Firebase real-time database for saving and fetching notes. The database structure has been designed to store notes against the respective usernames.


# Time Spent

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

# Check list
1. As a user (of the application) I can set my username ✔

2. As a user, I can save a short note to the Firebase database. ✔

3. As a user, I can see a list of my saved notes. ✔

4. As a user, I can see all the notes from other users. ✔

# Running the Application

1. Clone the repo
2. Open the project in Xcode
3. Run the app on a simulator or an actual device

Please ensure that you have the latest versions of SwiftUI and Firebase installed in your Xcode.

