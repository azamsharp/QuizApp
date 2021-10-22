//
//  GradeViewModel.swift
//  QuizApp
//
//  Created by Mohammad Azam on 10/22/21.
//

import Foundation

class QuizGradeViewModel: ObservableObject {
    
    @Published var gradeVM: GradeViewModel?
    
    func submitQuiz(submission: QuizSubmission) {
        Quiz.submit(submission: submission) { result in
            
            switch result {
                case .success(let grade):
                    DispatchQueue.main.async {
                        self.gradeVM = GradeViewModel(grade: grade)
                    }

                case .failure(let error):
                    print(error)
            }
        }
    }
    
}
