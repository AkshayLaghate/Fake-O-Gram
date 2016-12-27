//
//  FeedVC.swift
//  Fake-O-Gram
//
//  Created by Akshay Laghate on 17/12/16.
//  Copyright © 2016 INdCODERS. All rights reserved.
//

import UIKit
import SwiftKeychainWrapper
import Firebase

class FeedVC: UIViewController, UITableViewDelegate, UITableViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    
    @IBOutlet weak var tabelView: UITableView!
    @IBOutlet weak var imagePickerButton: UIImageView!
    
    static var imageCache: NSCache<NSString, UIImage> = NSCache()
    
    var posts = [Post]()
    
    var imagePicker: UIImagePickerController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tabelView.delegate = self
        tabelView.dataSource = self
        
        imagePicker = UIImagePickerController()
        imagePicker.allowsEditing = true
        imagePicker.delegate = self
        
        DataService.ds.REF_POSTS.observe(.value, with: { (snapShot) in
            
            if let snapshots = snapShot.children.allObjects as? [FIRDataSnapshot] {
                self.posts.removeAll()
                for snap in snapshots{
                    print("Snap: \(snap)")
                    
                    if let postDict = snap.value as? Dictionary<String,AnyObject>{
                        let key = snap.key
                        let post = Post(postId: key, postData: postDict)
                        self.posts.append(post)
                    }
                }
                
            }
            self.tabelView.reloadData()
            
        })

                // Do any additional setup after loading the view.
    }
    
    @IBAction func signOut(_ sender: Any) {
        let result = KeychainWrapper.standard.removeObject(forKey: "uid")
        print("Removal from keychaiv completed = \(result)")
        
        do{
            try FIRAuth.auth()?.signOut()
        } catch{
            
        }
        
        dismiss(animated: true, completion: nil)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tabelView.dequeueReusableCell(withIdentifier: "CellItem") as? CellItem{
            
            if let image = FeedVC.imageCache.object(forKey: posts[indexPath.row].imageUrl as NSString){
                cell.updateCell(post: posts[indexPath.row], img: image)
                return cell
            }else{
                cell.updateCell(post: posts[indexPath.row], img: nil)
                return cell
            }

        }else{
            return CellItem()
        }
    }
    
    
    @IBAction func addImageTapped(_ sender: Any) {
                present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        if let image = info[UIImagePickerControllerEditedImage] as? UIImage{
            imagePickerButton.image = image
        }
        
        imagePicker.dismiss(animated: true, completion: nil)
    }

}
