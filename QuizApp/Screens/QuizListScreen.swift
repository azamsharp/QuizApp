//
//  QuizListScreen.swift
//  QuizApp
//
//  Created by Mohammad Azam on 10/21/21.
//

import SwiftUI

struct QuizListScreen: View {
    
    @StateObject private var quizListVM = QuizListViewModel()
    
    var body: some View {
        
        NavigationView {
            
            List(quizListVM.quizes) { quiz in
                NavigationLink(destination: QuestionListScreen(quiz: quiz, quizSubmission: QuizSubmission(quizId: quiz.quizId)).navigationTitle(quiz.title)) {
                    Text(quiz.title)
                }
            }.onAppear {
                quizListVM.populateAllQuizes()
            }
            
            .navigationTitle("Quizes")
        }
    }
}

struct QuizListScreen_Previews: PreviewProvider {
    static var previews: some View {
        QuizListScreen()
    }
}
