

import UIKit
import Combine
 
final class TodoViewController: UIViewController {
    
    private let descriptionTask: UITextField = {
       let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.backgroundColor = .tertiarySystemBackground
        textField.layer.cornerRadius = 15
        textField.leftView = UIView(frame: .init(x: 0, y: 0, width: 0, height: 0))
        textField.leftViewMode = .always
        textField.placeholder = "buraya yaz"
        textField.font = UIFont.boldSystemFont(ofSize: 20)
        textField.returnKeyType = .done
        return textField
    }()
    
    private let savaEditButton: UIButton = {
        var configuration = UIButton.Configuration.tinted()
        configuration.cornerStyle = .large
        var container = AttributeContainer()
        container.font = UIFont.boldSystemFont(ofSize: 20)
        configuration.attributedTitle = AttributedString("Save" , attributes:  container)
        let button = UIButton(configuration: configuration, primaryAction: nil)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let newTodo = PassthroughSubject<String, Never>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
    }
    
    private func configUI(){
        view.backgroundColor = .systemGroupedBackground
        title = "yeni not"
        
        view.addSubview(descriptionTask)
        descriptionTask.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        descriptionTask.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
        descriptionTask.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10).isActive = true
        descriptionTask.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
        view.addSubview(savaEditButton)
        savaEditButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        savaEditButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
        savaEditButton.topAnchor.constraint(equalTo: descriptionTask.bottomAnchor, constant: 20).isActive = true
        savaEditButton.heightAnchor.constraint(equalToConstant: 60).isActive = true
        descriptionTask.becomeFirstResponder()
        descriptionTask.delegate = self
 
    }
}

extension TodoViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard let safeText = descriptionTask.text , safeText != "" else {return true}
        newTodo.send(safeText)
        dismiss(animated: true, completion: nil)
        return true
    }
}
