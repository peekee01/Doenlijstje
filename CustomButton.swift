//
//  MaterialView.swift
//  DreamLister
//
//  Created by Pieter Kuijsten on 30/12/2016.
//  Copyright © 2016 Pieter Kuijsten. All rights reserved.
//

import UIKit


private var custom = false

extension UIView {
    
    @IBInspectable var customButton: Bool {
        get {
            return custom
        }
        set {
            
            custom = newValue
            
            if custom {
                
                self.layer.masksToBounds = false
                self.layer.cornerRadius = 3.0
                
                
            } else {
                self.layer.cornerRadius = 0.0
            }
        }
    }
}
