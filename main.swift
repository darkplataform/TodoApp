import Foundation

// * Create the `Todo` struct.
// * Ensure it has properties: id (UUID), title (String), and isCompleted (Bool).
struct Todo: CustomStringConvertible, Codable {
    var id: UUID
    var title: String
    var isCompleted: Bool

    init(title: String){
        self.id = UUID()
        self.title = title
        self.isCompleted = false
    }

    var description: String {
        return "\(title) - \(isCompleted ? "✅" : "❌")"
    }

}

// Create the `Cache` protocol that defines the following method signatures:
//  `func save(todos: [Todo])`: Persists the given todos.
//  `func load() -> [Todo]?`: Retrieves and returns the saved todos, or nil if none exist.
protocol Cache {
    func save(todos: [Todo]) -> Bool

    func load() -> [Todo]?
}

// `FileSystemCache`: This implementation should utilize the file system 
// to persist and retrieve the list of todos. 
// Utilize Swift's `FileManager` to handle file operations.
final class JSONFileManagerCache: Cache {
    private let fileName: String
    private var fileURL: URL {
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        return documentsDirectory.appendingPathComponent(fileName)
    }
    
    init(fileName: String) {
        self.fileName = fileName
        createDirectoryIfNeeded()
        createFileIfNeeded()
    }

    func save(todos: [Todo]) -> Bool {
        do {
            let jsonData = try JSONEncoder().encode(todos)
            try jsonData.write(to: fileURL)
            return true
        } catch {
            print("❗Error saving todos: \(error)")
            return false
        }
    }

    func load() -> [Todo]? {
        do {
            let jsonData = try Data(contentsOf: fileURL)
            let todos = try JSONDecoder().decode([Todo].self, from: jsonData)
            return todos
        } catch {
            print(" ❗ Error loading todos: \(error)")
            return nil
        }
    }

    private func createDirectoryIfNeeded() { 
        print("File URL: \(fileURL)")
        let directory = fileURL.deletingLastPathComponent()
        if !FileManager.default.fileExists(atPath: directory.path) {
            do{
                try FileManager.default.createDirectory(at: directory, withIntermediateDirectories: true, attributes: nil)
            } catch {
                print("❗Error creating directory: \(error)")
            }
        }
    }

    private func createFileIfNeeded() {
        let fileManager = FileManager.default
        if !fileManager.fileExists(atPath: fileURL.path) {
            let emptyArray : [Todo] = []
            do{
                let data = try JSONEncoder().encode(emptyArray)
                try data.write(to: fileURL)
                print("File created at : \(fileURL.path)")
            } catch {
                print("❗error creating file: \(error)")
            }
        } else {
            print(" File already exits at: \(fileURL.path)")
        }
    }

}

// `InMemoryCache`: : Keeps todos in an array or similar structure during the session. 
// This won't retain todos across different app launches, 
// but serves as a quick in-session cache.
final class InMemoryCache: Cache {
    private var todos: [Todo] = []

    func save(todos: [Todo]) -> Bool {
        self.todos = todos
        return true
    }

    func load() -> [Todo]? {
        return todos.isEmpty ? nil : todos
    }
}

// The `TodosManager` class should have:
// * A function `func listTodos()` to display all todos.
// * A function named `func addTodo(with title: String)` to insert a new todo.
// * A function named `func toggleCompletion(forTodoAtIndex index: Int)` 
//   to alter the completion status of a specific todo using its index.
// * A function named `func deleteTodo(atIndex index: Int)` to remove a todo using its index.
final class TodosManager {
    private var todos: [Todo] = []

    private let cache: Cache

    init(cache: Cache) {
        self.cache = cache
        if let loadedTodos = cache.load() {
            self.todos = loadedTodos
        }
    }

    func listTodos() {
        for (index, todo) in todos.enumerated() {
            print("📝 \(index+1): \(todo)")
        }
    }

    func addTodo(with title: String) {
        let newTodo = Todo(title: title)
        todos.append(newTodo)
        _ = cache.save(todos: todos)
    }

    func toggleCompletion(forTodoAtIndex index: Int) {
        guard index >= 0 && index < todos.count else {
            return
        }
        todos[index].isCompleted.toggle()
        _ = cache.save(todos: todos)
    }

    func deleteTodo(atIndex index: Int){
        guard index >= 0 && index < todos.count else { 
            return
        }
        todos.remove(at: index)
        _ = cache.save(todos: todos)
    }


}


// * The `App` class should have a `func run()` method, this method should perpetually 
//   await user input and execute commands.
//  * Implement a `Command` enum to specify user commands. Include cases 
//    such as `add`, `list`, `toggle`, `delete`, and `exit`.
//  * The enum should be nested inside the definition of the `App` class
final class App {
    
    private let todosManager: TodosManager

    init(cache: Cache) {
        self.todosManager = TodosManager(cache: cache)
    }



    func run() {
        while true{
            print("Enter a command (add, list toggle, delete, exit):")
            if let input = readLine() {
                let command = parseCommand(input)
                executeCommand(command)
            }
        }
    }

    private func parseCommand(_ input: String) -> Command {
        let components = input.split(separator: " ")
        guard let action = components.first else {
            return .exit
        }

        switch action {
        case "add":
            let title = components.dropFirst().joined(separator: " ")
            return .add(title)
        case "list":
            return .list
        case "toggle":
            if let index = Int(components[1]) {
                return .toggle(index-1)
            }
        case "delete":
            if let index =  Int(components[1]){
                return .delete(index-1)
            }
        case "exit":
            return .exit
        default:
            return .exit
        }
        return .exit
    }

    private func executeCommand(_ command: Command){
        switch command {
            case .add(let title):
                todosManager.addTodo(with: title)
                print("📌 Added todo: \(title)")
            case .list:
                todosManager.listTodos()
            case .toggle(let index):
                todosManager.toggleCompletion(forTodoAtIndex: index)
                print("Toggled completion for todo at index \(index+1)")
            case .delete(let index):
                todosManager.deleteTodo(atIndex: index)
                print("🗑️ Deleted todo at index \(index+1)")
            case .exit:
                print("Exiting the app 👋 ")
                exit(0)
        }
    }

    enum Command {
        case add(String)
        case list
        case toggle(Int)
        case delete(Int)
        case exit
    }

}


// TODO: Write code to set up and run the app.
let jsonCache = JSONFileManagerCache(fileName: "/workspace/todos.json")
let app = App(cache: jsonCache)
app.run()
