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

class FeedVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    
    
    @IBOutlet weak var tabelView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tabelView.delegate = self
        tabelView.dataSource = self

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
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return tabelView.dequeueReusableCell(withIdentifier: "CellItem")!
    }

}
