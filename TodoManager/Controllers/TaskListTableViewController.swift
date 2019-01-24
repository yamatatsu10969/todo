//
//  TaskListTableViewController.swift
//  TodoManager
//
//  Created by 山本竜也 on 2019/1/19.
//  Copyright © 2019 山本竜也. All rights reserved.
//

import UIKit

class TaskListTableViewController: UITableViewController, TaskCollectionDelegate {
    
    //protocol のTaskCollectionDelegate が　saved() を持ってるから！書かなきゃエラー
    func saved() {
        print("保存し終わった")
        self.tableView.reloadData()
    }
    
    //書き方を省略するためだけ
    let taskCollection = TaskCollection.shared
    
    let userDefaults = UserDefaults.standard
    
    @IBOutlet weak var addButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // taskCollection の中の　delegateを　ここに入れる
        taskCollection.delegate = self
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    @IBAction func didTouchAddButton(_ sender: Any) {
        //        tasks.append("aaaaaa")
        //        self.tableView.reloadData()
        performSegue(withIdentifier: "taskAddSegue", sender: nil)
    }
    // MARK: - Table view data source
    
    //セクションの数
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    // 行の数
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return taskCollection.tasks.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        // Configure the cell...
        cell.textLabel?.text = taskCollection.tasks[indexPath.row].title
        
        
        return cell
    }
    
    // view
    //    override func viewWillAppear(_ animated: Bool) {
    //        self.tableView.reloadData()
    //    }
    
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            taskCollection.deleteTask(taskNum: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
        guard let identifier = segue.identifier else {
            return
        }
        if identifier == "editTodoSegue" {
            let taskVC = segue.destination as! taskViewController
            if let indexPathRow = self.tableView.indexPathForSelectedRow?.row{
                taskVC.indexPath = indexPathRow
                taskVC.editTask = taskCollection.tasks[indexPathRow]
            }
//            let tmpTask = taskCollection.tasks[(self.tableView.indexPathForSelectedRow?.row)!]
//            taskVC.editText = tmpTask.title
        }
        
     }
    
    
}
