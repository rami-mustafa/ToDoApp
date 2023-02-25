
 import CoreData

protocol DataManagerCRUD {
    func savaTodo(description: String)
    func allTodo() -> [Todo]
    func deleteTodo(uuid: String)
    func updateTodo(uuid: String , title: String)
}

extension DataManager: DataManagerCRUD{
    func savaTodo(description: String) {
        let todo = Todo(context: context)
        todo.title = description
        todo.id = UUID()
        do{
            try context.save()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func allTodo() -> [Todo] {
        let fetchListRequest: NSFetchRequest<Todo> = Todo.fetchRequest()
        var lists = [Todo]()
        do{
           lists =  try context.fetch(fetchListRequest)
        } catch {
            print(error.localizedDescription)
        }
        return lists
    }
    
    func deleteTodo(uuid: String) {
        searchTodo(uuid: uuid) { todo in
            do {
                self.context.delete(todo)
                try self.context.save()
            }  catch {
                print(error.localizedDescription)
            }
        }
        
    }
    
    func updateTodo(uuid: String, title: String) {
        searchTodo(uuid: uuid) { todo in
            do {
                todo.title = title
                try self.context.save()
            }  catch {
                print(error.localizedDescription)
            }
        }
    }
    
    private func searchTodo(uuid: String, completion: @escaping(Todo) -> Void ) {
        let fetchListRequest: NSFetchRequest<Todo> = Todo.fetchRequest()
        let predicate: NSPredicate = NSPredicate(format: "id == %@", uuid)
        fetchListRequest.predicate = predicate
        do {
            let objects = try context.fetch(fetchListRequest)
            guard let todo = objects.first else { return }
            completion(todo)
        } catch {
            print(error.localizedDescription)
        }
    }

}
