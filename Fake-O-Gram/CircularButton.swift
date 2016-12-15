//
//  RoundedCorner.swift
//  Fake-O-Gram
//
//  Created by Akshay Laghate on 15/12/16.
//  Copyright © 2016 INdCODERS. All rights reserved.
//

import UIKit

class CircularButton: UIButton {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        //layer.cornerRadius = 10.0
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        layer.cornerRadius = self.frame.width / 2
    }

}
