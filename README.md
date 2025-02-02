# Flutter To-Do App
A simple and elegant To-Do application built with Flutter and Hive for local data storage. This app allows users to create, update, and delete tasks efficiently. It features a clean and user-friendly interface with a dark theme.

## Features
- Add Tasks: Easily add new tasks with a title.

- **Update Tasks**: Modify existing tasks.

- **Delete Tasks**: Remove tasks you no longer need.

- **Local Storage**: Uses Hive for fast and efficient local data storage.

- **Dark Theme**: A visually appealing dark theme for better user experience.

- **Responsive Design**: Works seamlessly on mobile devices.

## Prerequisites
Before running the project, ensure you have the following installed:

- [Flutter SDK](https://docs.flutter.dev/get-started/install)

- [Dart SDK](https://dart.dev/get-dart)

- A code editor like [VS Code](https://code.visualstudio.com/) or [Android Studio](https://developer.android.com/studio)

## Installation and Setup
1. **Clone the repository**:
```
git clone https://github.com/MohammadAminar/ToDo.git
```

2. **Navigate to the project directory**:
```
cd ToDo
```

3. **Install dependencies**:
```
flutter pub get
```

4. **Run the app**:
```
flutter run
```
----
## Project Structure
The project is organized as follows:
```
├── android
├── ios
├── lib
│   ├── constants.dart
│   ├── main.dart
│   ├── models
│   │   └── todo_model.dart
│   └── screens
│       ├── home_screen.dart
│       └── todo_screen.dart
├── linux
├── macos
├── test
│   └── widget_test.dart
├── web
└── windows
```


## Dependencies
This project uses the following packages:
- **hive**: A lightweight and fast NoSQL database for local storage.

- **hive_flutter**: Flutter integration for Hive.

- **flutter/material.dart**: Flutter's Material Design widgets for building the UI.

For a complete list of dependencies, check the `pubspec.yaml` file.
----
## How It Works
**Main Components**
1. **`main.dart`**:

Initializes Hive and registers the Todo model adapter.

Sets up the app theme and launches the HomeScreen.

2. **`constants.dart`**:

Defines app-wide constants like colors.

3. **`todo_model.dart`**:

Defines the Todo model using Hive annotations.

4. **`home_screen.dart`**:

Displays the list of tasks.

Allows users to add, update, or delete tasks.

5. **`todo_screen.dart`**:

Provides a form for adding or updating tasks.

----


## Code Examples
**Adding a Task**
```
void add(String text) async {
  var box = await Hive.openBox('todo');
  Todo todo = Todo(text);
  box.add(todo);
}
```

**Updating a Task**
```
void update(String text) async {
  var box = await Hive.openBox('todo');
  Todo todo = Todo(text);
  box.putAt(index, todo);
}
```


**Deleting a Task**
```
void remove() {
  Box box = Hive.box('todo');
  box.deleteAt(index);
}
```

---

## Contributing
Contributions are welcome! If you'd like to contribute, follow these steps:

1. Fork the repository.

2. Create a new branch:
```
git checkout -b feature/your-feature-name
```

3. Commit your changes:
```
git commit -m "Add some feature"
```

4. Push your changes:
```
git push origin feature/your-feature-name

```

5. Open a Pull Request.
---


## License
This project is licensed under the MIT License. See the LICENSE file for details.
