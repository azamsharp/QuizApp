//
//  QuestionListViewModel.swift
//  QuizApp
//
//  Created by Mohammad Azam on 10/21/21.
//

import Foundation

class QuestionListViewModel: ObservableObject {
    
    
}

struct QuestionViewModel: Identifiable {
    
    var id: Int {
        question.questionId
    }
    
    private let question: Question
    
    init(question: Question) {
        self.question = question
    }
    
    var questionId: Int {
        question.questionId
    }
    
    var text: String {
        question.text
    }
    
    var point: Int {
        question.point
    }
    
    var choices: [ChoiceViewModel] {
        question.choices.map(ChoiceViewModel.init)
    }
}

struct ChoiceViewModel: Identifiable {
    
    var id: Int {
        choice.choiceId
    }
    
    private var isSelected: Bool = false
    private let choice: Choice
    
    init(choice: Choice) {
        self.choice = choice
    }
    
    var choiceId: Int {
        choice.choiceId 
    }
    
    var text: String {
        choice.text
    }
    
    mutating func setSelected() {
        isSelected = true 
    }
}

struct GradeViewModel {
    
    private let grade: Grade
    
    init(grade: Grade) {
        self.grade = grade
    }
    
    var letter: String {
        grade.letter.uppercased()
    }
    
    var score: Int {
        grade.score
    }
    
}

