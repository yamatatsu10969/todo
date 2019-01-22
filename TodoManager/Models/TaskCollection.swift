//
//  TaskCollection.swift
//  TodoManager
//
//  Created by 山本竜也 on 2019/1/19.
//  Copyright © 2019 山本竜也. All rights reserved.
//

import Foundation

// protocol は interface とか abstract 見たなもの
// 以下では必ずsaved ()を実装してください！となる。
protocol TaskCollectionDelegate: class {
    func saved()
}

class TaskCollection {
    
    
    let userDefaults = UserDefaults.standard
    
    // weak はメモリ管理に役立つ
    weak var delegate: TaskCollectionDelegate?
    
    // デザパタのシングルトンパターンを使うためにこの記述を行う
    // 自分自身に作っておけば、他に作成できないようになる？
    static let shared = TaskCollection()
    //厳格にやる場合はこれを使う？
    //priveta in
    
    init(){
        self.load()
    }
    
    var tasks: [Task] = []
    
    func addTask(title: String) {
        let task = Task()
        task.title = title
        //task.descriptin = description
        self.tasks.append(task)
        save()
    }
    
    func save() {
        //シリアル化 → 配列を文字列にするもの　よくあるのはJsonにして、DBに送る
        let data = try! PropertyListEncoder().encode(tasks)
        userDefaults.set(data, forKey:"tasks")
        print("test")
        delegate?.saved()
        
    }
    
    func load(){
        if let data = userDefaults.data(forKey: "tasks") {
            // タスクのクラスの配列の名前　→ [Task].self はselfを後ろに書いている
            let tasks = try! PropertyListDecoder().decode([Task].self, from: data)
            self.tasks = tasks
        }
    }
    
}
