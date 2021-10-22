//
//  QuestionListScreen.swift
//  QuizApp
//
//  Created by Mohammad Azam on 10/22/21.
//

import SwiftUI

struct QuestionListScreen: View {
    
    let quiz: QuizViewModel
    @StateObject private var questionListVM = QuestionListViewModel()
    @State var quizSubmission: QuizSubmission
    @State private var gradeQuiz: Bool = false

    var body: some View {
                
                VStack {
                    List(quiz.questions.indices) { index in
                        
                        let question = quiz.questions[index]
                        
                        VStack(alignment: .leading) {
                            HStack {
                                Text("\(index + 1)")
                                    .padding(10)
                                    .foregroundColor(.white)
                                    .background(Color.blue)
                                .clipShape(Circle())
                                
                                Text(question.text)
                                    .font(.system(size: 22))
                            }
                            
                            ForEach(question.choices) { choice in
                                HStack {
                                    Image(systemName: quizSubmission.isSelected(questionId: question.questionId, choiceId: choice.choiceId) ? "checkmark.square": "square")
                                        .onTapGesture {
                                            quizSubmission.addChoice(questionId: question.questionId, choiceId: choice.choiceId)
                                        }
                                    Text(choice.text)
                                }
                            }
                        }
                        
                    }.listStyle(.plain)
                    .buttonStyle(.plain)
                    
                    
                    NavigationLink(isActive: $gradeQuiz) {
                        QuizGradeScreen()
                    } label: {
                        Button("Submit") {
                           gradeQuiz = true
                        }
                        .frame(maxWidth: .infinity, maxHeight: 44)
                        .foregroundColor(.white)
                        .background(Color.blue)
                        .clipShape(RoundedRectangle(cornerRadius: 10.0, style: .continuous))
                        .padding()
                    }
                    
                    Spacer()
                    
                    
                }.onAppear(perform: {
                    quizSubmission = QuizSubmission(quizId: quiz.quizId)
                })
    }
}

struct QuestionListScreen_Previews: PreviewProvider {
    static var previews: some View {
        
        let quiz = QuizData.loadQuizes()[0]
        NavigationView {
            QuestionListScreen(quiz: quiz, quizSubmission: QuizSubmission(quizId: quiz.quizId))
                .navigationTitle(quiz.title)
        }
    }
}
