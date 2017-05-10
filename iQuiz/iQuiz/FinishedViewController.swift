//
//  FinishedViewController.swift
//  iQuiz
//
//  Created by Saif Mustafa on 5/9/17.
//  Copyright © 2017 saifm. All rights reserved.
//

import UIKit

class FinishedViewController: UIViewController {
    
    public static var gotWrong = 0;
    
    @IBOutlet weak var results: UILabel!
    
    @IBAction func finishQuiz(_ sender: UIButton) {
        
        FinishedViewController.gotWrong = 0;
        self.navigationController?.popToRootViewController(animated: false);
        
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad();
        
        self.navigationItem.hidesBackButton = true;
        
        self.results.text = "You answered \(QuestionViewController.numberOfQuestions - FinishedViewController.gotWrong) of \(QuestionViewController.numberOfQuestions) Questions Correct!";
        
    }
    
    
    override func didReceiveMemoryWarning() {
        
        super.didReceiveMemoryWarning();
        
    }
    
}
