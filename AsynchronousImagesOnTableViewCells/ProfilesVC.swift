//
//  ViewController.swift
//  AsynchronousImagesOnTableViewCells
//
//  Created by Flávio Silvério on 7/21/16.
//  Copyright © 2016 Flavio Silverio. All rights reserved.
//

import UIKit

class ProfilesVC: UITableViewController {

    let APIManager = APIConnection()
    var array = [UIImage]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 200;
    }
    

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("cell")!
        
        while array.count < indexPath.row + 1 {
            array.append(UIImage())
        }
        
        let image = array[indexPath.row]
        (cell.viewWithTag(101) as! UIImageView).image = image
        
        //if image == UIImage() {
            
            APIManager.loadImage(indexPath) { [weak self] (success, image, imageIndexPath)  in
                
                if success == true {
                    
                    self?.array.insert(image!, atIndex: indexPath.row)
                    
                    if indexPath.row == imageIndexPath.row {
                        
                        let imageView = cell.viewWithTag(101) as! UIImageView
                        dispatch_async(dispatch_get_main_queue(), {
                            
                            imageView.image = image
                            
                        })
                        
                    }
                }
                
            //}
            
        }
        
        return cell;
    }

}

