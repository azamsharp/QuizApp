//
//  QuizListViewModel.swift
//  QuizApp
//
//  Created by Mohammad Azam on 10/21/21.
//

import Foundation

class QuizListViewModel: ObservableObject {
    
    @Published var quizes: [QuizViewModel] = []
    
    func populateAllQuizes() {
        
        Quiz.getAll { result in
            switch result {
                case .success(let quizes):
                    DispatchQueue.main.async {
                        self.quizes = quizes.map(QuizViewModel.init)
                    }
                case .failure(let error):
                    print(error)
            }
        }
    }
    
}

struct QuizViewModel: Identifiable {
    
    let id = UUID() 
    
    private let quiz: Quiz
    
    init(quiz: Quiz) {
        self.quiz = quiz
    }
    
    var quizId: Int {
        quiz.quizId
    }
    
    var title: String {
        quiz.title
    }
    
    var questions: [QuestionViewModel] {
        quiz.questions.map(QuestionViewModel.init)
    }
    
}
