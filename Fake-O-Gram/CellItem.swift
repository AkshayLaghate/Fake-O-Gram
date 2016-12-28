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
    
    var post: Post!
    var likesRef : FIRDatabaseReference!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(likeTapped))
        tap.numberOfTapsRequired = 1
        likeImage.addGestureRecognizer(tap)
        likeImage.isUserInteractionEnabled = true
        
    }

    func updateCell(post: Post, img: UIImage?){
        self.post = post
        self.likesRef = DataService.ds.REF_CURRENTUSER.child("liked").child(post.postId)
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
        
        
        likesRef.observeSingleEvent(of: .value, with: { (snapshot) in
            
            if let _ = snapshot.value as? NSNull{
                self.likeImage.image = UIImage(named: "empty-heart")
            } else{
                self.likeImage.image = UIImage(named: "filled-heart")
            }
        }, withCancel: nil)
    }
    
    func likeTapped(sender: UITapGestureRecognizer){
        
        likesRef.observeSingleEvent(of: .value, with: { (snapshot) in
            
            if let _ = snapshot.value as? NSNull{
                self.likeImage.image = UIImage(named: "filled-heart")
                self.post.adjustLikes(addLike: true)
                self.likesRef.setValue(true)
            } else{
                self.likeImage.image = UIImage(named: "empty-heart")
                self.post.adjustLikes(addLike: false)
                self.likesRef.removeValue()
            }
            
        }, withCancel: nil)
    }
    
}
