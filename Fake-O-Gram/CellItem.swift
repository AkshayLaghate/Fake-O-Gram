//
//  CellItem.swift
//  Fake-O-Gram
//
//  Created by Akshay Laghate on 23/12/16.
//  Copyright © 2016 INdCODERS. All rights reserved.
//

import UIKit
import Firebase

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

    func updateCell(post: Post, img: UIImage?){
        self.postText.text = post.text
        self.likesCountLabel.text = "\(post.likes)"
        
        if img != nil{
            self.postImage.image = img
        }
        else{
            let ref = FIRStorage.storage().reference(forURL: post.imageUrl)
            ref.data(withMaxSize: 2 * 1024 * 1024, completion: { (data, error) in
                
                if error != nil{
                    //handle error
                }
                else{
                    
                    print("image downloaded from storage")
                    if let imageData = data{
                        if let image = UIImage(data: imageData){
                            self.postImage.image = image
                            FeedVC.imageCache.setObject(image, forKey: post.imageUrl as NSString)
                        }
                    }
                }
                
            })
        }
        
    }
    
}
