//
//  taskViewController.swift
//  TodoManager
//
//  Created by 山本竜也 on 2019/1/19.
//  Copyright © 2019 山本竜也. All rights reserved.
//

import UIKit

class taskViewController: UIViewController {

    @IBOutlet weak var titleTextField: UITextField!
    
    //書き方を省略するためだけ 
    let taskCollection = TaskCollection.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func didTouchedSaveButton(_ sender: Any) {
        guard let title = titleTextField.text else {
            return
        }
        if title.isEmpty {
            showAlert("タイトルを入力してください。")
            return
        }
        
        taskCollection.addTask(title: title)
        self.navigationController?.popViewController(animated: true)
    }
    
    func showAlert(_ text: String){
        //UIViewControllerを作成しているだけ！
        let alertController = UIAlertController(title: text, message: nil , preferredStyle: UIAlertController.Style.alert)
        let action = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) { (action) -> Void in
        }
        alertController.addAction(action)
        self.present(alertController, animated: true, completion: nil)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
