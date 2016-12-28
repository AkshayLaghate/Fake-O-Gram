//
//  Post.swift
//  Fake-O-Gram
//
//  Created by Akshay Laghate on 27/12/16.
//  Copyright © 2016 INdCODERS. All rights reserved.
//

import Foundation
import Firebase

class Post {
    
    private var _text: String!
    private var _imageUrl: String!
    private var _likes: Int!
    private var _postId: String!
    private var _POST_REF: FIRDatabaseReference!
    
    
    var text: String{
        return _text
    }
    
    var imageUrl: String{
        return _imageUrl
    }
    
    var likes: Int{
        return _likes
    }
    
    var postId: String{
        return _postId
    }
    
    init(text: String, imageUrl: String, likes: Int) {
        self._text = text
        self._imageUrl = imageUrl
        self._likes = likes
    }
    
    init(postId: String, postData: Dictionary<String,AnyObject>){
        self._postId = postId
        
        if let text = postData["text"] as? String{
            self._text = text
        }
        
        if let imageUrl = postData["imageUrl"] as? String{
            self._imageUrl = imageUrl
        }
        
        if let likes = postData["likes"] as? Int{
            self._likes = likes
        }
        
        _POST_REF = DataService.ds.REF_POSTS.child(_postId)
    }
    
    func adjustLikes(addLike: Bool){
        if addLike{
            _likes = _likes + 1
        }else{
            _likes = likes - 1
        }
        
        _POST_REF.child("likes").setValue(_likes)
    }

}
