//
//  Quiz.swift
//  QuizApp
//
//  Created by Mohammad Azam on 10/21/21.
//

import Foundation

enum GradingError: Error {
    case unableToGrade
}

struct Grade {
    let letter: String
    let score: Int
}

class Quiz {
    
    let quizId: Int
    let title: String
    let questions: [Question]
    
    init(quizDTO: QuizDTO) {
        self.quizId = quizDTO.quizId
        self.title = quizDTO.title 
        self.questions = quizDTO.questions.map(Question.init)
    }
    
    var totalPoints: Int {
        self.questions.reduce(0) { next, question in
            next + question.point
        }
    }
    
    static func submit(submission: QuizSubmission, completion: @escaping (Result<Grade, Error>) -> Void) {
        
        // get an updated copy of the quiz
        Webservice().getQuizById(url: Constants.Urls.quizById(submission.quizId)) { result in
            switch result {
                case .success(let quizDTO):
                    let quiz = Quiz(quizDTO: quizDTO)
                    let userGrade = grade(quiz: quiz, submission: submission)
                    completion(.success(userGrade))
                case .failure(let error):
                    print(error)
            }
        }
    }
    
    static func grade(quiz: Quiz, submission: QuizSubmission) -> Grade {
        
        var submissionTotal = 0
        
        quiz.questions.forEach { question in
            let correctChoice = question.choices.first { $0.isCorrect == true }
            let userChoice = submission.selectedChoices[question.questionId]
            
            if let correctChoice = correctChoice, let userChoice = userChoice {
                if correctChoice.choiceId == userChoice {
                    submissionTotal += question.point
                }
            }
        }
        
        let score = submissionTotal/quiz.totalPoints
        let letterGrade = calculateLetterGrade(score: score)
       
        return Grade(letter: letterGrade, score: score)
    }
    
    static private func calculateLetterGrade(score: Int) -> String {
        
        switch score {
            case 1...40:
                return "D"
            case 41...70:
                return "C"
            case 71...89:
                return "B"
            case 90...100:
                return "A"
            default:
                return "N/A"
        }
        
    }
    
    static func getAll(completion: @escaping (Result<[Quiz], NetworkError>) -> Void) {
        
        Webservice().getAllQuizes(url: Constants.Urls.allQuizes) { result in
            switch result {
                case .success(let quizesDTO):
                    completion(.success(quizesDTO.map(Quiz.init)))
                case .failure(let error):
                    completion(.failure(error))
            }
        }
        
    }
}

class Question {
    
    let questionId: Int
    let text: String
    let point: Int
    let choices: [Choice]
    
    init(questionDTO: QuestionDTO) {
        self.questionId = questionDTO.questionId
        self.text = questionDTO.text
        self.point = questionDTO.point
        self.choices = questionDTO.choices.map(Choice.init)
    }
}

class Choice {
    
    let choiceId: Int
    let text: String
    let isCorrect: Bool
    
    init(choiceDTO: ChoiceDTO) {
        self.choiceId = choiceDTO.choiceId
        self.text = choiceDTO.text
        self.isCorrect = choiceDTO.isCorrect
    }
    
}
