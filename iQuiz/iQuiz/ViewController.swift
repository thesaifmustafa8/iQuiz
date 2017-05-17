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
    let subjectArray = ["Mathematics", "Marvel Super Heroes", "Science!"];
    let descArray = ["Study of numbers", "Comic book super heroes", "Everything around you"];
    
    
    
    // settings button
    @IBAction func settingsButton(_ sender: Any) {
        
        let popup = UIAlertController(title: "Settings", message: nil, preferredStyle: .alert);
        
        popup.addTextField {
            
            (newURL) in newURL.placeholder = "Enter new URL";
            
        }
        
        let prev = UIAlertAction(title: "Update the Quiz", style: .default, handler: {
            
            alert -> Void in
            let new : String = popup.textFields![0].text!;
            print(new);
            self.currentQuiz = [];
            
            if new != "" {
                
                self.getJsonFile(URLString: new);
                
            }
            
        })
        
        popup.addAction(prev);
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
    
    var currentQuiz = [Quiz]();
    var defaultURL : String = "http://tednewardsandbox.site44.com/questions.json";
    
    func getJsonFile(URLString: String = "http://tednewardsandbox.site44.com/questions.json") {
        
        var url = URL(string: URLString);
        self.defaultURL = URLString;
        let sessionConfig = URLSessionConfiguration.default;
        let session = URLSession(configuration: sessionConfig);
    
        if url == nil {
            
            url = URL(string: "Not a valid URL!");
            
        }
    
        let task = session.dataTask(with: url!) {(data, response, err) in
                
            if err != nil {
                    
                    print ("ERROR");
                    let localJSON = UserDefaults.standard;
                
                    if(localJSON.value(forKey: "localJsonFile") != nil) {
                        
                        let jsonFile = localJSON.value(forKey: "localJsonFile") as! NSArray;
                        
                        for quiz in jsonFile {
                            
                            let oneQuiz = quiz as! [String : Any];
                            let title = oneQuiz["title"] as! String;
                            let desc = oneQuiz["desc"] as! String;
                            let questions : [Dictionary<String, Any>] = oneQuiz["questions"] as! Array;
                            
                            self.currentQuiz.append(Quiz (title: title, desc: desc, questions: questions));
                            
                        }
                        
                        DispatchQueue.main.sync {
                            
                            self.tableView.reloadData();
                            
                        }
                        
                    }
                
                } else {
                    
                    if let content = data {
                        
                        do {
    
                            let myJson = try JSONSerialization.jsonObject(with: content, options: JSONSerialization.ReadingOptions.mutableContainers) as! NSArray;
                            
                            for eachQuizFromData in myJson {
                                
                                let eachQuiz = eachQuizFromData as! [String : Any];
                                let title = eachQuiz["title"] as! String;
                                let desc = eachQuiz["desc"] as! String;
                                let questions : [Dictionary<String,Any>] = eachQuiz["questions"] as! Array;
                                self.currentQuiz.append(Quiz(title: title, desc: desc, questions: questions));
                                
                            }
                            
                            DispatchQueue.main.sync {
                                
                                self.tableView.reloadData();
                                
                            }
                            
                        }
                            
                        catch {
                            
                        }
                    }
                }
                
            }
    
            task.resume();
            
            DispatchQueue.main.async {
                
                //self.jsonArray = myJson;
                
            }
    
    }
    
    func pullDown(refreshControl: UIRefreshControl) {
        
        self.currentQuiz = [];
        getJsonFile(URLString: defaultURL);
        refreshControl.endRefreshing();
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let cell : UITableViewCell = tableView.cellForRow(at: indexPath)!;
        
        QuestionViewController.cell = (cell.textLabel?.text!)!;
        QuestionViewController.fetchedQuizOnQuestionViewController = currentQuiz;
        
        for i in 0...currentQuiz.count - 1 {
            
            if currentQuiz[i].Title == cell.textLabel?.text {
                
                QuestionViewController.numberOfQuestions = currentQuiz[i].Questions.count;
                QuestionViewController.currentQuestion = currentQuiz[i].Questions.count;
                
            }
            
        }
        
        let viewController = storyboard?.instantiateViewController(withIdentifier: "questionVC");
        self.navigationController?.pushViewController(viewController!, animated: true);
        
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1;
        
    }
    
    let pullToRefresh = UIRefreshControl();
    
    override func viewDidLoad() {
        
        super.viewDidLoad();
        tableView.addSubview(pullToRefresh);
        pullToRefresh.addTarget(self, action: #selector(pullDown), for: .valueChanged);
  
        DispatchQueue.global().async {
            
            self.getJsonFile();
            
            DispatchQueue.main.async {
                
                self.tableView.reloadData();
                
            }
            
        }

        tableView.tableFooterView = UIView();
        
    }

    override func didReceiveMemoryWarning() {
        
        super.didReceiveMemoryWarning();
        
    }


}

class Quiz {
    
    var Title : String;
    var Description : String;
    var Questions : [Dictionary<String, Any>];
    
    
    init(title : String,
         desc : String,
         questions : [Dictionary<String, Any>]) {
        
        self.Title = title;
        self.Description = desc;
        self.Questions = questions;
        
    }
    
}

