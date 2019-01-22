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
        
        
//        userDefaults.set("yamamoto", forKey: "hogehoge")
//        let hoge =  userDefaults.string(forKey: "hogehoge")
//        print(hoge)
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
    
    /*
     // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
     if editingStyle == .delete {
     // Delete the row from the data source
     tableView.deleteRows(at: [indexPath], with: .fade)
     } else if editingStyle == .insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
     */
    
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
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
