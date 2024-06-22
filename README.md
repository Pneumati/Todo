 Todo
 Mpedigree Assesment

This project is a Todo application built with Flutter for the frontend and Node.js with Express for the backend. The app allows users to create, view, update, and manage their todos, including setting deadlines, priorities, and marking tasks as completed.

 Table of Contents
- [Features](features)
- [Getting Started](getting-started)
  - [Prerequisites](prerequisites)
  - [Backend Setup](backend-setup)
  - [Frontend Setup](frontend-setup)
- [Running the Application](running-the-application)
  - [Running the Backend](running-the-backend)
  - [Running the Frontend](running-the-frontend)
- [Testing](testing)
- [Project Structure](project-structure)
- [Architectural Considerations](architectural-considerations)

 Features
- Create Todos: Users can create new todo items with a title, description, time, deadline, priority, and completion status.
- View Todos: Users can view a list of their todos.
- Update Todos: Users can update the completion status of their todos.
- Set Deadlines: Users can set deadlines for their tasks.
- Set Priority: Users can set the priority of their tasks (Low, Medium, High).
- Mark as Complete: Users can mark tasks as complete.

 Getting Started

 Prerequisites
- Node.js and npm installed on your machine.
- Flutter installed on your machine.
- MongoDB setup (either locally or using a service like MongoDB Atlas).

 Backend Setup
1. Navigate to the backend directory:
    cd todo_api

2. Initialize a new Node.js project:
    npm init -y

3. Install the required packages:
    npm install express body-parser cors mongoose

4. Create a new file named `index.js` and add the backend code provided earlier.

5. Ensure MongoDB is running and update the MongoDB connection string in `index.js` if necessary.

 Frontend Setup
1. Navigate to the frontend directory:
    ```sh
    cd flutter_todo_app
    ```

2. Install Flutter dependencies:
    flutter pub get

3. Ensure you have added the `intl` package to your `pubspec.yaml`:
    dependencies:
      flutter:
        sdk: flutter
      intl: ^0.17.0

 Running the Application

 Running the Backend
1. Ensure you are in the `todo_api` directory:
    cd todo_api

2. Start the Node.js server:
    node index.js

 Running the Frontend
1. Ensure you are in the `flutter_todo_app` directory:
    cd flutter_todo_app

2. Run the Flutter application:
    flutter run


 Frontend
1. Flutter has a built-in test framework. You can create test files in the `test` directory and write your tests.

2. Run the Flutter tests:
    flutter test

 Project Structure
 Backend (`todo_api`)

todo_api/
├── index.js
├── models/
│   └── todo.js
├── routes/
│   └── todos.js
└── package.json


 Frontend (`flutter_todo_app`)

flutter_todo_app/
├── lib/
│   ├── main.dart
│   ├── models/
│   │   └── todo.dart
│   ├── services/
│   │   └── todo_service.dart
│   └── pages/
│       └── todo_list_page.dart
├── pubspec.yaml
└── test/
    └── widget_test.dart

 Architectural Considerations
 Backend
- Node.js with Express: A popular choice for building RESTful APIs due to its asynchronous nature and wide adoption.
- MongoDB: A NoSQL database chosen for its flexibility in handling JSON-like documents, making it a good fit for a Todo application.

 Frontend
- Flutter: Chosen for its ability to create natively compiled applications for mobile from a single codebase. It provides a rich set of pre-designed widgets and tools.
- Separation of Concerns: The code is structured to separate the UI (pages) from the business logic (services) and data models (models). This makes the codebase more maintainable and scalable.

