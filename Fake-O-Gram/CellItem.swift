//
//  CellItem.swift
//  Fake-O-Gram
//
//  Created by Akshay Laghate on 23/12/16.
//  Copyright © 2016 INdCODERS. All rights reserved.
//

import UIKit

class CellItem: UITableViewCell {
    
    
    @IBOutlet weak var userImage: CircularImage!
    @IBOutlet weak var userLabel: UILabel!
    @IBOutlet weak var likeImage: UIImageView!
    @IBOutlet weak var postImage: UIImageView!
    @IBOutlet weak var postText: UITextView!
    @IBOutlet weak var likesCountLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func updateCell(post: Post){
        self.postText.text = post.text
        self.likesCountLabel.text = "\(post.likes)"
        
    }
    
}
