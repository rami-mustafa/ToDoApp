

import UIKit
import Combine
 
final class TodoViewController: UIViewController {
    
    private let descriptionTask: UITextField = {
       let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.backgroundColor = .tertiarySystemBackground
        textField.layer.cornerRadius = ViewValues.defaultRadius
        textField.leftView = UIView(frame: .init(
            x: ViewValues.zero,
            y: ViewValues.zero,
            width: Int(ViewValues.defaultPadding),
            height: ViewValues.zero))
        textField.leftViewMode = .always
        textField.placeholder = TextValue.descriptionPlaceHolder
        textField.font = UIFont.boldSystemFont(ofSize: ViewValues.defaultSizeText)
        textField.returnKeyType = .done
        return textField
    }()
    
    private lazy var savaEditButton: UIButton = {
        var configuration = UIButton.Configuration.tinted()
        configuration.cornerStyle = .large
        var container = AttributeContainer()
        container.font = UIFont.boldSystemFont(ofSize: ViewValues.defaultSizeText)
        configuration.attributedTitle = AttributedString(TextValue.saveButton , attributes:  container)
        let button = UIButton(configuration: configuration, primaryAction: saveTodoAction())
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
        title = TextValue.TitleNewTodo
        
        view.addSubview(descriptionTask)
        descriptionTask.leftAnchor.constraint(equalTo: view.leftAnchor, constant: ViewValues.defaultPadding).isActive = true
        descriptionTask.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -ViewValues.defaultPadding).isActive = true
        descriptionTask.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: ViewValues.topPadding).isActive = true
        descriptionTask.heightAnchor.constraint(equalToConstant: ViewValues.defaultHeight).isActive = true
        
        view.addSubview(savaEditButton)
        savaEditButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: ViewValues.defaultPadding).isActive = true
        savaEditButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -ViewValues.defaultPadding).isActive = true
        savaEditButton.topAnchor.constraint(equalTo: descriptionTask.bottomAnchor, constant: ViewValues.defaultPadding).isActive = true
        savaEditButton.heightAnchor.constraint(equalToConstant: ViewValues.defaultHeight).isActive = true
        descriptionTask.becomeFirstResponder()
        descriptionTask.delegate = self
 
    }
    
    func saveTodoAction() -> UIAction {
        let action = UIAction { [weak self] _ in
            guard let self = self else { return  }
            self.saveTodo()
        }
        return action
    
    }
    private func saveTodo(){
        guard let safeText = descriptionTask.text , safeText != "" else {return}
        newTodo.send(safeText)
        dismiss(animated: true, completion: nil)    }
}

extension TodoViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.saveTodo()
        return true
    }
}
