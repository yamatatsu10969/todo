//
//  taskViewController.swift
//  TodoManager
//
//  Created by 山本竜也 on 2019/1/19.
//  Copyright © 2019 山本竜也. All rights reserved.
//

import UIKit

class taskViewController: UIViewController , UITextViewDelegate{

    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var descriptionTextView: UITextView!
    
    var editTask:Task?
    var indexPath:Int?
    
    //書き方を省略するためだけ 
    let taskCollection = TaskCollection.shared
    
    //
    @IBAction func showActivityView(_ sender: UIBarButtonItem) {
        let controller = UIActivityViewController(activityItems: [descriptionTextView.text!], applicationActivities: nil)
        self.present(controller, animated: true, completion: nil)
    }
    
    @IBOutlet weak var countLabel: UILabel!
    
    func textViewDidChange(_ descriptionTextView:UITextView){
        let beforeStr: String = descriptionTextView.text // 文字列をあらかじめ取得しておく
        //文字数制限は140字まで　twitterの仕様　英語はもっと多いらしい。
        if descriptionTextView.text.count > 139 { // 139字を超えた時
            // 以下，範囲指定する
            let zero = beforeStr.startIndex
            let start = beforeStr.index(zero, offsetBy: 0)
            let end = beforeStr.index(zero, offsetBy: 139)
            descriptionTextView.text = String(beforeStr[start...end])
        }
        
        showCountText()
        //countLabel.text = String(descriptionTextView.text.count)
    }
    
    func showCountText(){
        countLabel.text = String(descriptionTextView.text.count)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        showCountText()
        
        //文字数制限のため
        descriptionTextView.delegate = self
        
        countLabel.font = UIFont.monospacedDigitSystemFont(ofSize: 18, weight: UIFont.Weight.regular)
        
        if let tmpTitle = self.editTask?.title {
            self .titleTextField.text = tmpTitle
            if let tmpDescription = self.editTask?.description {
                self.descriptionTextView.text = tmpDescription
            }
            //navigationItem を編集する
            self.navigationItem.title = "Edit Task"
        }

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
        
        //編集かどうかの判断
        if let selectedIndexPath = self.indexPath {
            //taskCollection.tasks[selectedIndexPath] = title
            if let task = editTask {
                task.title = title
                if let description = descriptionTextView.text {
                    task.description = description
                }
                    taskCollection.editTask(task: task, indexPath: selectedIndexPath)
                
            }
            
        } else {
            if let description = descriptionTextView.text {
                taskCollection.addTask(title: title,description: description)
            } else {
                taskCollection.addTask(title: title)
            }
        }
        
        
        self.navigationController?.popViewController(animated: true)
    }
    
    //textView以外を触ったら、キーボードを消す
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
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
