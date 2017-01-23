//
//  TableContent.swift
//  Doenlijstje
//
//  Created by Pieter Kuijsten on 22/01/2017.
//  Copyright © 2017 Pieter Kuijsten. All rights reserved.
//

import UIKit

class TableContent: UITableViewCell {
    
    @IBOutlet weak var todoLbl: UILabel!
    var Todo: Todo?
    
    func configureCell(todo: Todo) {
        todoLbl.text = todo.title
        Todo = todo
    }
    
    
    @IBAction func deleteBtn(_ sender: UIButton) {
        
        let todoItem = Todo
        context.delete(todoItem!)
        ad.saveContext()
    }
    
}
