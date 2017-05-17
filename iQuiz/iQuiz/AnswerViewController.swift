//
//  AnswerViewController.swift
//  iQuiz
//
//  Created by Saif Mustafa on 5/9/17.
//  Copyright © 2017 saifm. All rights reserved.
//

import UIKit

class AnswerViewController: UIViewController {
    
    public static var allQuestions = [Questions]();
    
    @IBOutlet weak var option1: UIButton!
    @IBOutlet weak var option2: UIButton!
    @IBOutlet weak var option3: UIButton!
    @IBOutlet weak var option4: UIButton!
    
    @IBOutlet weak var theQuestion: UILabel!
    
    var allAnswers : [UIButton] = [];
    
    public static var fetchedQuestionsOnAnswerViewController = [Questions]();
    
    @IBAction func nextButton(_ sender: UIButton) {
        
        if QuestionViewController.currentQuestion == 0 {
            
            QuestionViewController.optionTapped = nil;
            let viewController = storyboard?.instantiateViewController(withIdentifier: "finishedVC");
            self.navigationController?.pushViewController(viewController!, animated: true);
            
        } else {
            
            QuestionViewController.optionTapped = nil;
            let viewController = storyboard?.instantiateViewController(withIdentifier: "questionVC");
            self.navigationController?.pushViewController(viewController!, animated: true);
            
        }
        
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad();
        self.navigationItem.hidesBackButton = true;
        
        allAnswers = [];
        allAnswers.append(option1);
        allAnswers.append(option2);
        allAnswers.append(option3);
        allAnswers.append(option4);
        
        
        let answerValue = Int (AnswerViewController.allQuestions[QuestionViewController.numberOfQuestions - (QuestionViewController.currentQuestion + 1)].Answer);
        
        var answerRawText = "";
        
        theQuestion.text = AnswerViewController.allQuestions[QuestionViewController.numberOfQuestions - (QuestionViewController.currentQuestion + 1)].Question;
        
        answerRawText = AnswerViewController.allQuestions[QuestionViewController.numberOfQuestions - (QuestionViewController.currentQuestion + 1)].AnswersList[answerValue! - 1];
        
        for i in 0...QuestionViewController.buttonsArray.count - 1 {
            
            allAnswers[i].setTitle(QuestionViewController.buttonsArray[i].title(for: .normal), for: .normal);
            
            if allAnswers[i].title(for: .normal) == answerRawText {
                
                allAnswers[i].backgroundColor = UIColor.green;
                
            }
            
        }
        
        if QuestionViewController.optionTapped != answerRawText {
            
            FinishedViewController.gotWrong = FinishedViewController.gotWrong + 1;
            
            for i in 0...QuestionViewController.buttonsArray.count - 1 {
                
                if allAnswers[i].title(for: .normal) == QuestionViewController.optionTapped {
                    
                    allAnswers[i].backgroundColor = UIColor.red;
                    
                }
            }
            
        }
    }
    
    override func didReceiveMemoryWarning() {
        
        super.didReceiveMemoryWarning();
        
    }
    
}
