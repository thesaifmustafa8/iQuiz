//
//  QuestionViewController.swift
//  iQuiz
//
//  Created by Saif Mustafa on 5/9/17.
//  Copyright © 2017 saifm. All rights reserved.
//

import UIKit

class QuestionViewController: UIViewController {
    
    @IBOutlet weak var theQuestion: UILabel!
    
    public static var numberOfQuestions = 0;
    public static var currentQuestion = 0;

    @IBOutlet weak var option1: UIButton!
    @IBOutlet weak var option2: UIButton!
    @IBOutlet weak var option3: UIButton!
    @IBOutlet weak var option4: UIButton!
    
    public static var buttonsArray : [UIButton] = [];
    
    public static var optionTapped : String? = nil;
    
    @IBAction func allOptions(_ sender: UIButton) {
        
        let title = sender.title(for: .normal);
        
        for i in QuestionViewController.buttonsArray {
            
            if i.title(for: .normal) == title {
                
                i.backgroundColor = UIColor.lightGray;
                QuestionViewController.optionTapped = i.title(for: .normal);
                
            } else {
                
                i.backgroundColor = UIColor.white;
                
            }
        }
        
    }
    
    var recievedQuestions = [Questions]();
    public static var fetchedQuizOnQuestionViewController = [Quiz]();
    
    
    @IBAction func submit(_ sender: UIButton) {
        
        if QuestionViewController.optionTapped != nil {
            
            AnswerViewController.fetchedQuestionsOnAnswerViewController = recievedQuestions;
            
            QuestionViewController.currentQuestion = QuestionViewController.currentQuestion - 1;
            
            AnswerViewController.allQuestions = recievedQuestions;
            
            let viewController = storyboard?.instantiateViewController(withIdentifier: "answerVC");
            
            self.navigationController?.pushViewController(viewController!, animated: true);
            
        } else {
            
            let warningAlert = UIAlertController(title: "Sorry", message: "Please Choose an Option!", preferredStyle: UIAlertControllerStyle.alert);
            
            warningAlert.addAction(UIAlertAction(title: "OK", style: .default, handler:nil));
            
            present(warningAlert, animated: true, completion: nil);
            
        }

    }
    
    public static var cell : String = "";
    
    override func viewDidLoad() {
        
        super.viewDidLoad();
        
        self.navigationItem.hidesBackButton = true;
        
        QuestionViewController.buttonsArray = [];
        
        for subject in QuestionViewController.fetchedQuizOnQuestionViewController {
            
            if (subject.Title == QuestionViewController.cell) {
                
                let questions: [Dictionary<String, Any>] = subject.Questions;
                
                for questionsItems in questions {
                    
                    let text = questionsItems["text"] as! String;
                    let answers : [String] = questionsItems["answers"] as! Array;
                    let answer = questionsItems["answer"] as! String;
                    
                    self.recievedQuestions.append(Questions(Question: text, Answer: answer, AnswersList: answers));
                }
            }
        }
        
        QuestionViewController.buttonsArray.append(option1);
        QuestionViewController.buttonsArray.append(option2);
        QuestionViewController.buttonsArray.append(option3);
        QuestionViewController.buttonsArray.append(option4);
        
        self.theQuestion.text = self.recievedQuestions[QuestionViewController.numberOfQuestions - QuestionViewController.currentQuestion].Question;
        
        for i in 0...recievedQuestions[QuestionViewController.numberOfQuestions - QuestionViewController.currentQuestion].AnswersList.count - 1{
            QuestionViewController.buttonsArray[i].setTitle(recievedQuestions[QuestionViewController.numberOfQuestions - QuestionViewController.currentQuestion].AnswersList[i], for: .normal)
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        
        super.didReceiveMemoryWarning();
       
    }
    
}

class Questions {
    
    var Question : String;
    var Answer : String;
    var AnswersList : [String];
    
    init(Question : String,
         Answer : String,
         AnswersList : [String]) {
        
        self.Question = Question;
        self.Answer = Answer;
        self.AnswersList = AnswersList;
        
    }
    
}
