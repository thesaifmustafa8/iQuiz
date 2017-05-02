//
//  ViewController.swift
//  iQuiz
//
//  Created by Saif Mustafa on 5/1/17.
//  Copyright © 2017 saifm. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    
    // arrays to store icons, subjects, and their descriptions
    let iconsArray = ["1.jpg", "2.jpg", "3.jpg"];
    let subjectArray = ["Mathematics", "Marvel Super Heroes", "Science"];
    let descArray = ["Study of numbers", "Comic book super heroes", "Everything around you"];
    
    // settings button
    @IBAction func settingsButton(_ sender: Any) {
        
        let popup = UIAlertController(title: "Settings", message: "Settings Go Here!", preferredStyle: .alert);
        
        popup.addAction(UIAlertAction(title: "Cancel", style: .default, handler: nil));
        
        self.present(popup, animated: true, completion: nil);
        
    }
    
    // putting content into table view controller
    override func tableView(_ tableView: UITableView, numberOfRowsInSection selection: Int) -> Int {
        
        return self.subjectArray.count;
        
    }
    
    // getting table view contents from our arrays
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let option = UITableViewCell(style: .subtitle, reuseIdentifier: "option");
        
        option.textLabel!.text = self.subjectArray[indexPath.row];
        option.detailTextLabel!.text = self.descArray[indexPath.row];
        option.imageView!.image = UIImage(named: self.iconsArray[indexPath.row]);
        
        return option;
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

