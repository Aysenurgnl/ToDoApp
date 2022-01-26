//
//  HomeViewController.swift
//  ToDoApp
//
//  Created by Ayşenur on 21.01.2022.
//

import UIKit
import CoreData

let appDelegate = UIApplication.shared.delegate as! AppDelegate

class HomeViewController: UIViewController {

    @IBOutlet weak var taskTableView: UITableView!
    @IBOutlet weak var dateLabel: UILabel!
    
    let context = appDelegate.persistentContainer.viewContext //veritabanı işlemlerini gerçekleştirmek için
    var taskList = [Tasks]()
    let date = Date()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM ,d"
        dateLabel.text = dateFormatter.string(from: date)
        
    }
    override func viewWillAppear(_ animated: Bool) {
        getTask() //tüm taskları almak için
        taskTableView.reloadData()
    }
    
    @IBAction func addNewTaskButton(_ sender: Any) {
        performSegue(withIdentifier: "homeToAdd", sender: nil)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let index = sender as? Int
        if segue.identifier == "homeToUpdate"{
            let destVC =  segue.destination as! UpdateTaskViewController
            destVC.task = taskList[index!]
        }
    }
    func getTask(){
        do{
            taskList =  try context.fetch(Tasks.fetchRequest())
        }catch{
            print(error)
        }
    }
}
extension HomeViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        taskList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let task = taskList[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "taskCell",for: indexPath) as! TaskTableViewCell
        cell.titleLabel.text = task.title
        cell.briefDescriptionLabel.text = task.brief_description
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "homeToUpdate", sender: indexPath.row)
    }
 
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { contextualAction, view, boolValue in
            let task = self.taskList[indexPath.row]
            self.context.delete(task)
            appDelegate.saveContext()  //sildikten sonra değişiklikleri kaydediyoruz
            
            //sildikten sonra arayüzü güncellemek için
            self.getTask()
            self.taskTableView.reloadData()
            
        }
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
    
    
}
