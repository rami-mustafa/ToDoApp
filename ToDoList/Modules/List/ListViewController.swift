//
//  ListViewController.swift
//  ToDoList
//
//  Created by Ghaiath Alhereh on 17.02.23.
//

import UIKit

class ListViewController: UIViewController {
    
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
    }
    
    
    private func configUI() {
        view.backgroundColor = .white
        title = "Todo List"
        guard let nav = navigationController else {return}
        nav.view.addSubview(newTodoButton)
        newTodoButton.rightAnchor.constraint(equalTo: nav.view.rightAnchor, constant: -20).isActive = true
        newTodoButton.bottomAnchor.constraint(equalTo: nav.view.bottomAnchor, constant: -20).isActive = true
        
    }
    
    private func addNewTodo() -> UIAction {
        let action = UIAction { _ in
            print("selam")
        }
        return action
    }
}
