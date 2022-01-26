//
//  UpdateTaskViewController.swift
//  ToDoApp
//
//  Created by Ayşenur on 21.01.2022.
//

import UIKit

class UpdateTaskViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var briefDescriptionTextField: UITextField!
    @IBOutlet weak var detailTextView: UITextView!
    
    let context = appDelegate.persistentContainer.viewContext
    var task:Tasks?
    
    var maxLength:Int = 15 //150
    
    override func viewDidLoad() {
        super.viewDidLoad()
        briefDescriptionTextField.delegate = self
        initView()
        
        if let t = task{
            titleTextField.text = t.title
            briefDescriptionTextField.text = t.brief_description
            detailTextView.text = t.detail
        }

    }
    func initView(){
        detailTextView.layer.cornerRadius = 10
        detailTextView.layer.borderWidth = 0.5
        detailTextView.layer.borderColor = UIColor.lightGray.cgColor
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if (textField == briefDescriptionTextField){
            let currentText = briefDescriptionTextField.text! + string
            return currentText.count < maxLength
        }
        return true
    }

    @IBAction func updateTaskButton(_ sender: Any) {
        
        if let t = task ,let title = titleTextField.text, let description = briefDescriptionTextField.text, let detail = detailTextView.text{
            t.title = title
            t.brief_description = description
            t.detail = detail
        
            appDelegate.saveContext() //kayıt edebilmek için
        }
         
    }
    
}
