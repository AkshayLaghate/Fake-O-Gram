//
//  DataService.swift
//  Fake-O-Gram
//
//  Created by Akshay Laghate on 27/12/16.
//  Copyright © 2016 INdCODERS. All rights reserved.
//

import Foundation
import Firebase
import SwiftKeychainWrapper

let DB_BASE = FIRDatabase.database().reference()
let STORAGE_BASE = FIRStorage.storage().reference()

class DataService {
    
    static let ds = DataService()
    
    private var _REF_BASE = DB_BASE
    private var _REF_POSTS = DB_BASE.child("Posts")
    private var _REF_USERS = DB_BASE.child("Users")
    
    private var _REF_STORAGE = STORAGE_BASE
    private var _REF_POST_STORAGE = STORAGE_BASE.child("post-pics")
    
    var REF_BASE: FIRDatabaseReference{
        return _REF_BASE
    }
    
    var REF_POSTS: FIRDatabaseReference{
        return _REF_POSTS
    }
    
    var REF_USERS: FIRDatabaseReference{
        return _REF_USERS
    }
    
    var REF_CURRENTUSER: FIRDatabaseReference{
        let uid = KeychainWrapper.standard.string(forKey: "uid")
        let user = REF_USERS.child(uid!)
        return user
    }
    
    var REF_STORAGE: FIRStorageReference{
        return _REF_STORAGE
    }
    
    var REF_POST_STOREGE: FIRStorageReference{
        return _REF_POST_STORAGE
    }
    
    
    func createFirebaseDBUser(uid: String, userData: Dictionary<String,String>){
        
        REF_USERS.child(uid).updateChildValues(userData)
        
    }
    
}
