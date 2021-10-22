//
//  QuizData.swift
//  QuizApp
//
//  Created by Mohammad Azam on 10/22/21.
//

import Foundation

class QuizData {
    
    static func loadQuizes() -> [QuizViewModel] {
        
        // read the json file
        guard let path = Bundle.main.path(forResource: "quizes", ofType: "json") else {
            fatalError("Path for quizes.json was not found")
        }
        
        guard let data = try? Data(contentsOf: URL(fileURLWithPath: path)) else {
            fatalError("Unable to load data!")
        }
        
        guard let quizesDTO = try? JSONDecoder().decode([QuizDTO].self, from: data) else {
            fatalError("Unable to decode data!")
        }
        
        return quizesDTO.map(Quiz.init)
            .map(QuizViewModel.init)
    }
    
}
