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
    
    func configureCell(todo: Todo) {
        todoLbl.text = todo.title?.localizedCapitalized
    }
    

    
}
