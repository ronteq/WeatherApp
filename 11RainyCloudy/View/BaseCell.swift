//
//  BaseCell.swift
//  11RainyCloudy
//
//  Created by Daniel Fernandez on 6/11/17.
//  Copyright © 2017 Ronteq. All rights reserved.
//

import UIKit

class BaseCell: UITableViewCell{
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews(){
        
    }
}
