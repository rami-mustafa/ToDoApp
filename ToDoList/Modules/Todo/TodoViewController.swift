

import UIKit

class TodoViewController: UIViewController {
    
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
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
    }
    
    private func configUI(){
        view.backgroundColor = .systemBackground
        title = "yeni not"
        
        view.addSubview(descriptionTask)
        descriptionTask.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        descriptionTask.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 20).isActive = true
        descriptionTask.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
        descriptionTask.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
    }
}
