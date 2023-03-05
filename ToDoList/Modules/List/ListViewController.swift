

import UIKit
import Combine

class ListViewController: UITableViewController {
    private var store = Set<AnyCancellable>()
    
    private lazy var newTodoButton: UIButton = {
        var configuration = UIButton.Configuration.filled()
        configuration.image = UIImage(systemName: "plus")
        configuration.cornerStyle = .capsule
        configuration.buttonSize = .large
        let button = UIButton(configuration: configuration, primaryAction: addNewTodo())
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let dataManager: DataManagerCRUD
    private var listTodo = [Todo]().self
    
    init(dataManager: DataManager){
        self.dataManager = dataManager
        super.init(style: .insetGrouped)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
        configTableView()
        listTodo = dataManager.allTodo()
    }
    
    
    private func configUI() {
        view.backgroundColor = .white
        title = "Todo List"
        guard let nav = navigationController else {return}
        nav.view.addSubview(newTodoButton)
        newTodoButton.rightAnchor.constraint(equalTo: nav.view.rightAnchor, constant: -20).isActive = true
        newTodoButton.bottomAnchor.constraint(equalTo: nav.view.bottomAnchor, constant: -20).isActive = true
//        newTodoButton.topAnchor.constraint(equalTo: nav.view.topAnchor, constant: 75).isActive = true
        nav.navigationBar.prefersLargeTitles = true
    }
    
    private func configTableView(){
        tableView.register(ListCell.self, forCellReuseIdentifier: ListCell.identifier)
        tableView.separatorStyle = .none
    }
    
    private func addNewTodo() -> UIAction {
        let action = UIAction { _ in
        let controller = TodoViewController()
            controller.newTodo.sink { [weak self]todoDescription in
                guard let self = self else {return}
                self.dataManager.savaTodo(description: todoDescription)
                self.listTodo = self.dataManager.allTodo()
                self.tableView.reloadData()
                    

            }.store(in: &self.store)
            let nav = UINavigationController(rootViewController: controller)
            self.present(nav, animated: true, completion: nil)
            //            self.navigationController?.pushViewController(controller, animated: true)
            
        }
        return action
    }
}

extension ListViewController {
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       guard let cell = tableView.dequeueReusableCell(withIdentifier: ListCell.identifier, for: indexPath) as?
                ListCell else {
           return UITableViewCell()
       }
        let todo = listTodo[indexPath.section]
        cell.titleLabel.text = todo.title
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
            if editingStyle == .delete {
                let todo = listTodo[indexPath.section]
                let id = todo.id?.uuidString ?? ""
                dataManager.deleteTodo(uuid: id)
                listTodo.remove(at: indexPath.section)
                
                let indexSet = IndexSet(arrayLiteral: indexPath.section)
                tableView.beginUpdates()
                tableView.deleteSections(indexSet, with: .left)
                tableView.endUpdates()
            }
        }
    
     override func numberOfSections(in tableView: UITableView) -> Int {
        listTodo.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        20
    }
    
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return nil
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        0
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return nil
    }
}
