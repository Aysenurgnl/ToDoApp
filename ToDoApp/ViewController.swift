//
//  ViewController.swift
//  ToDoApp
//
//  Created by Ayşenur on 21.01.2022.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    
    @IBOutlet weak var bottomView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
       
    }
    func initView(){
        bottomView.layer.cornerRadius = 20
        bottomView.layer.masksToBounds = true
        bottomView.layer.maskedCorners = [ .layerMinXMinYCorner,.layerMaxXMinYCorner]
    }

    @IBAction func skipButton(_ sender: Any) {
        performSegue(withIdentifier: "toHome", sender: nil)
        
    }
    
}


