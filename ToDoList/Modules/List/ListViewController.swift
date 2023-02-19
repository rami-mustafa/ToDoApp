//
//  ListViewController.swift
//  ToDoList
//
//  Created by Ghaiath Alhereh on 17.02.23.
//

import UIKit

class ListViewController: UITableViewController {
    
    private lazy var newTodoButton: UIButton = {
        var configuration = UIButton.Configuration.filled()
        configuration.image = UIImage(systemName: "plus")
        configuration.cornerStyle = .capsule
        configuration.buttonSize = .large
        let button = UIButton(configuration: configuration, primaryAction: addNewTodo())
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
        configTableView()
    }
    
    
    private func configUI() {
        view.backgroundColor = .white
        title = "Todo List"
        guard let nav = navigationController else {return}
        nav.view.addSubview(newTodoButton)
        newTodoButton.rightAnchor.constraint(equalTo: nav.view.rightAnchor, constant: -20).isActive = true
        newTodoButton.bottomAnchor.constraint(equalTo: nav.view.bottomAnchor, constant: -20).isActive = true
        nav.navigationBar.prefersLargeTitles = true
    }
    
    private func configTableView(){
        tableView.register(ListCell.self, forCellReuseIdentifier: ListCell.identifier)
        tableView.separatorStyle = .none
    }
    
    private func addNewTodo() -> UIAction {
        let action = UIAction { _ in
            print("selam")
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
        cell.titleLabel.text = "hola"
        return cell
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
}
