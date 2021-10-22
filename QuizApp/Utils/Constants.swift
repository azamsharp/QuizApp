//
//  Constants.swift
//  QuizApp
//
//  Created by Mohammad Azam on 10/21/21.
//

import Foundation

struct Constants {
    struct Urls {
        
        static let allQuizes = URL(string: "https://warp-wiry-rugby.glitch.me/all-quizes")!
        static func quizById(_ quizId: Int) -> URL {
            return URL(string: "https://warp-wiry-rugby.glitch.me/quizes/\(quizId)")!
        }
    }
}
