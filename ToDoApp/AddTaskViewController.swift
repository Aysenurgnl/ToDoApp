//
//  AddTaskViewController.swift
//  ToDoApp
//
//  Created by Ayşenur on 21.01.2022.
//

import UIKit

class AddTaskViewController: UIViewController ,UITextFieldDelegate{

    @IBOutlet weak var titleTexField: UITextField!
    @IBOutlet weak var briefDescriptionTextField: UITextField!
    @IBOutlet weak var detailTextView: UITextView!
    
    @IBOutlet weak var textFieldCountLabel: UILabel!
    
    let context = appDelegate.persistentContainer.viewContext
    var maxLength:Int = 15 //150
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
        briefDescriptionTextField.delegate = self
        
    }
    func initView(){
        detailTextView.layer.cornerRadius = 10
        detailTextView.layer.borderWidth = 0.5
        detailTextView.layer.borderColor = UIColor.lightGray.cgColor
        
        textFieldCountLabel.text = "0"
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if (textField == briefDescriptionTextField){
            let currentText = briefDescriptionTextField.text! + string
            textFieldCountLabel.text = String(currentText.count)
            return currentText.count < maxLength
        }
        return true
    }
    
    
    @IBAction func addNewTaskButton(_ sender: Any) {
        let task = Tasks(context: context)
        if let title = titleTexField.text, let description = briefDescriptionTextField.text, let detail = detailTextView.text{
            task.title = title
            task.brief_description = description
            task.detail = detail
            appDelegate.saveContext() //kayıt edebilmek için
        }
    }
}
