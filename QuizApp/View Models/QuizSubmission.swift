//
//  QuizSubmission.swift
//  QuizApp
//
//  Created by Mohammad Azam on 10/22/21.
//

import Foundation

struct QuizSubmission {
    
    let quizId: Int
    private (set) var selectedChoices: [Int: Int] = [:]
    var grade: Grade?
    
    init(quizId: Int) {
        self.quizId = quizId
    }
    
    func isSelected(questionId: Int, choiceId: Int) -> Bool {
        
        if let persistedChoiceId = selectedChoices[questionId] {
            return choiceId == persistedChoiceId
        }
        
        return false
    }
    
    mutating func addChoice(questionId: Int, choiceId: Int) {
        self.selectedChoices[questionId] = choiceId
    }
}

