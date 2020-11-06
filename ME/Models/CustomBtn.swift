//
//  CurrencyButton.swift
//  ME
//
//  Created by Veranika Razdabudzka on 11/4/20.
//

import UIKit

class CustomBtn: UIButton {
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        customizeBtn()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        customizeBtn()
    }
    
    func customizeBtn() {
        clipsToBounds = true
        layer.cornerRadius = 5.0
        layer.borderWidth = 3.0
        layer.borderColor = #colorLiteral(red: 0.7934994102, green: 0.6018143296, blue: 0.5339533687, alpha: 1)
        
    }
   
}
