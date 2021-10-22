//
//  Webservice.swift
//  QuizApp
//
//  Created by Mohammad Azam on 10/21/21.
//

import Foundation

enum NetworkError: Error {
    case badRequest
    case decodingError
}

class Webservice {
    
    func getAllQuizes(url: URL, completion: @escaping (Result<[QuizDTO], NetworkError>) -> Void) {
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            guard let data = data, error == nil,
                  (response as? HTTPURLResponse)?.statusCode == 200
            else {
                completion(.failure(.badRequest))
                return
            }
            
            let quizes = try? JSONDecoder().decode([QuizDTO].self, from: data)
            completion(.success(quizes ?? []))
            
        }.resume()
    }
    
    func getQuizById(url: URL, completion: @escaping (Result<QuizDTO, NetworkError>) -> Void) {
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            guard let data = data, error == nil,
                  (response as? HTTPURLResponse)?.statusCode == 200
            else {
                completion(.failure(.badRequest))
                return
            }
            
            let quiz = try? JSONDecoder().decode(QuizDTO.self, from: data)
            if let quiz = quiz {
                completion(.success(quiz))
            } else {
                completion(.failure(.decodingError))
            }
            
        }.resume()
        
        
    }
    
}
