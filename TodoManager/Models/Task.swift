//
//  Task.swift
//  TodoManager
//
//  Created by 山本竜也 on 2019/1/19.
//  Copyright © 2019 山本竜也. All rights reserved.
//

import Foundation



//Task にcodableを継承している
class Task:Codable {
    var title: String = ""
    var description: String = ""

    enum CodingKeys: String, CodingKey {
        case title
    }
    
    // init はオブジェクトが作成された時に実行される関数
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.title = try container.decode(String.self, forKey: .title)
    }
    
    // overroad
    init (){
        
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(title, forKey: .title)
    }
}
