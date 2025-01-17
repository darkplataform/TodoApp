Swift Todo App
-----

# Project Instructions
## What am I building?

In this course, you're set to build the "**Todos CLI**" app - a user-friendly command-line tool to manage tasks. This isn't just any to-do list; it's your playground to explore the depth of Swift programming.

At the heart of this application are tasks. You can add them, mark them as done or pending, and sweep them away when they're no longer needed. Swift's object-oriented features shine here. You'll work with classes, structures, and arrays, diving deep into how they operate.

But there's more! Ever wondered how apps remember data after they're closed? That's where our caching mechanism comes into play. Through the Cache protocol, you'll get hands-on experience in data storage, choosing between saving data temporarily in memory or more permanently on your computer's file system.

Throughout this journey, not only will you hone your coding skills, but you'll also get a taste of designing intuitive software, all while immersing yourself in Swift's elegant syntax and capabilities.

## Why am I building this?
You're building this command-line task management application for several compelling reasons. Firstly, it's a practical way to understand the fundamental principles of Swift. Rather than diving into abstract concepts, you'll be applying what you learn immediately, seeing the real-world impact of your code.

Secondly, by working on this project, you'll grasp the significance of functions and Object-Oriented Programming in Swift. These aren't just theoretical concepts; they are the very essence of most modern applications.

Additionally, the use of protocols in this project showcases how to write modular and adaptable Swift code. It's not about just building an app; it's about understanding the best practices that professional Swift developers use daily in the apps that we rely on everyday.

In conclusion, while you'll end up with a fully functional Todo application, the real takeaway is the deeper understanding and appreciation of Swift as a robust programming language, preparing you for more advanced coding adventures.

## How should I build this?
### Starter Project - A simple empty project to start with

In this project, you will start with a "Starter Project," which lays the groundwork for your Swift application. This method allows for a structured approach, making it easier to build your application in manageable steps and simplifying the testing process.

To run and test the application refer to information on its README file.

### Designing Your Data - The Todo Struct
* Create the `Todo` struct.
* Ensure it has properties: id (UUID), title (String), and isCompleted (Bool).

### Managing Your Data - TodosManager Class
* Build the `TodosManager` class.
* Design methods to add a todo, list todos, toggle a todo's completion status, and delete a todo.

### Interacting with Your App - The App Class
* Create the `App` class with a run method:
  * Use an infinite loop to keep the app active.
  * Listen for user commands and execute respective actions.
* Implement the `Command` enum to define user commands:
  * **add**: Add a todo.
  * **list**: Show todos.
  * **toggle**: Change a todo's completion status.
  * **delete**: Remove a todo.
  * **exit**: Close the app.

In the run method, utilize the Command enum to process user input and provide feedback.

### Refining Data Representation
* Enhance the `Todo` struct by conforming to the `CustomStringConvertible` [protocol](https://developer.apple.com/documentation/swift/customstringconvertible). This helps customize how a todo is displayed.
* Conform `Todo` to the `Codable` [protocol](https://developer.apple.com/documentation/swift/codable) to ease the process of encoding and decoding for caching.

### Introducing Persistence - Caching with Protocols
* Design the `Cache` protocol to outline essential functionalities for data persistence.
* Create two classes based on the Cache protocol: `FileSystemCache` for file-based storage and `InMemoryCache` for in-session storage.

### Enhancing User Experience
Improve your app's command-line outputs using emojis to make interactions more engaging.
Emojis like ✅ for completed todos or 🗑️ to signify deletion can make the CLI more lively!

### Going Beyond - Testing (Optional but Recommended)
* Add an extra layer of reliability by writing tests.
* Ensure that core functionalities like adding, toggling, and deleting todos work seamlessly.

### Embrace the Journey
Learning to code is both a fascinating journey and a rewarding skill. Remember, it's completely natural to face challenges, experience moments of frustration, and encounter "gotcha" situations along the way. These are all part of the learning curve. Don't let them discourage you; instead, view them as opportunities to grow and understand the subject matter deeply.

In this project, we introduced several programming concepts and patterns. If you ever find yourself puzzled or curious about a specific topic, we've provided a lot of resources for you to explore. Dive into them, expand your understanding, and most importantly, have fun. After all, every challenge you overcome is a step forward in your programming journey. Keep the enthusiasm alive, and happy coding!

## What are the requirements?
### Todo Structure
The `Todo` struct should have these attributes:
* `id`: A unique identifier using `UUID`.
* `title`: A string that describes the todo.
* `isCompleted`: A boolean to track if the todo is done.

### Managing Todos
The `TodosManager` class should offer:
* A function `func listTodos()` to display all todos.
* A function named `func addTodo(with title: String)` to insert a new todo.
* A function named `func toggleCompletion(forTodoAtIndex index: Int)` to alter the completion status of a specific todo using its index.
* A function named `func deleteTodo(atIndex index: Int)` to remove a todo using its index.

### App Interaction
* The `App` class should have a `func run()` method, this method should perpetually await user input and execute commands.
* Implement a `Command` enum to specify user commands. Include cases such as `add`, `list`, `toggle`, `delete`, and `exit`.
  * The enum should be nested inside the definition of the `App` class

### Enhancements with Protocols
* The `Todo` struct should conform to the `CustomStringConvertible` protocol to provide a custom string representation.
* The `Todo` struct should also conform to the `Codable` protocol for encoding and decoding purposes.

### Persisting Todos
* A `Cache` protocol with the following methods should be created:
  * `func save(todos: [Todo])`: Persists the given todos.
  * `func load() -> [Todo]?`: Retrieves and returns the saved todos, or nil if none exist.
* Two class implementations of this protocol should be offered:
  * `FileSystemCache`: This implementation should utilize the file system to persist and retrieve the list of todos. Utilize Swift's `FileManager` to handle file operations.
  * `InMemoryCache`: Keeps todos in an array or similar structure during the session. This won't retain todos across different app launches, but serves as a quick in-session cache.
* Integrating the cache into TodosManager:
  * The `TodosManager` class should incorporate caching.
  * Upon initialization, one caching strategy (`FileSystemCache` or `InMemoryCache`) should be employed based on the student's preference.
  * Adding, toggling, and deleting todos, should also save the changes in the chosen cache.
  * Any existing todos should be populated in the current list when initializing the `TodosManager`.

### Going Above and Beyond (Optional)
These steps are meant to take your app from being functional to being delightful and robust:

**Embellishing with Emojis**
Level up the command-line interface by using emojis to offer a visually engaging user experience.
* Use emojis like ✅ for completed todos, ❌ for incomplete ones.
* Decorate feedback messages with emojis such as 📝 for listing, 📌 for adding a todo, 🗑️ for deletion, 🌟 for a highlighted notice, ❗ for errors, 👋 for the exit message, and so on.

**Writing Tests for Your App**
Create unit tests to validate the functionality of key components:
* Test the `Todo` struct to ensure proper string representation.
* Test the `TodosManager` to confirm accurate adding, toggling, and deleting functionalities, as well as cache interactions.
* Test both `FileSystemCache` and `InMemoryCache` implementations to ensure proper saving and loading of todos.

By adding these enhancements, not only do you make the app more pleasant for users, but also ensure its reliability through testing!

## Resources

|Resource Description|Link|
|---|---|
|CustomStringConvertible \| Apple documentation|[https://developer.apple.com/documentation/swift/customstringconvertible](https://developer.apple.com/documentation/swift/customstringconvertible)|
|Codable \| Apple documentation|[https://developer.apple.com/documentation/swift/codable](https://developer.apple.com/documentation/swift/codable)|
|Codable Basics|[https://www.swiftbysundell.com/basics/codable/](https://www.swiftbysundell.com/basics/codable/)|
|FileManager \| Apple documentation|[https://developer.apple.com/documentation/foundation/filemanager](https://developer.apple.com/documentation/foundation/filemanager)|
|Writing data to the documents directory|[https://www.hackingwithswift.com/books/ios-swiftui/writing-data-to-the-documents-directory](https://www.hackingwithswift.com/books/ios-swiftui/writing-data-to-the-documents-directory)|
|Getting started with Unit Tests in Swift|[https://www.avanderlee.com/swift/unit-tests-best-practices/](https://www.avanderlee.com/swift/unit-tests-best-practices/)|
|How do you read from the command line?|[https://www.hackingwithswift.com/example-code/system/how-do-you-read-from-the-command-line](https://www.hackingwithswift.com/example-code/system/how-do-you-read-from-the-command-line)|
|Swift readLine(), Swift print()|[https://www.digitalocean.com/community/tutorials/swift-readline-swift-print](https://www.digitalocean.com/community/tutorials/swift-readline-swift-print)|
