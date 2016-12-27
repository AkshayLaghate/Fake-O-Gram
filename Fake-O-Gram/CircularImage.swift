//
//  CircularImage.swift
//  Fake-O-Gram
//
//  Created by Akshay Laghate on 23/12/16.
//  Copyright © 2016 INdCODERS. All rights reserved.
//

import UIKit

class CircularImage: UIImageView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
//    override func draw(_ rect: CGRect) {
//        super.draw(rect)
//        layer.cornerRadius = self.frame.width / 2
//    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        layer.cornerRadius = self.frame.width / 2
    }

}
