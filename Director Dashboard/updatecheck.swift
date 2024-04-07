import SwiftUI

struct Question: Identifiable {
    let id: UUID
    let text: String
    // Other properties like image, etc.
}

class PaperQuestionViewModel: ObservableObject {
    @Published var questions: [Question]
    @Published var selectedQuestion: Question?

    init(questions: [Question]) {
        self.questions = questions
    }
    
    func didSelectQuestion(_ question: Question) {
        selectedQuestion = question
    }
}

class AdditionalQuestionViewModel: ObservableObject {
    @Published var questions: [Question]

    init(questions: [Question]) {
        self.questions = questions
    }
    
    func swapQuestion(with question: Question) {
        if let selectedIndex = questions.firstIndex(where: { $0.id == question.id }) {
            questions[selectedIndex] = question
        }
    }
}

struct PaperQuestionView: View {
    @ObservedObject var viewModel: PaperQuestionViewModel

    var body: some View {
        NavigationView {
            List(viewModel.questions) { question in
                NavigationLink(destination: AdditionalQuestionView(viewModel: AdditionalQuestionViewModel(questions: viewModel.questions))) {
                    Text(question.text)
                        .onTapGesture {
                            viewModel.didSelectQuestion(question)
                        }
                }
            }
            .navigationBarTitle("Paper Questions")
        }
    }
}

struct AdditionalQuestionView: View {
    @ObservedObject var viewModel: AdditionalQuestionViewModel

    var body: some View {
        NavigationView {
            List(viewModel.questions) { question in
                HStack {
                    Text(question.text)
                    Spacer()
                    Button(action: {
                        viewModel.swapQuestion(with: question)
                    }) {
                        Image(systemName: "arrow.right.arrow.left")
                    }
                }
            }
            .navigationBarTitle("Additional Questions")
        }
    }
}

// Initialize your view models with separate data for each screen
let paperQuestionViewModel = PaperQuestionViewModel(questions: [
    Question(id: UUID(), text: "Paper Question 1"),
    Question(id: UUID(), text: "Paper Question 2"),
    // Add more questions as needed
])

let additionalQuestionViewModel = AdditionalQuestionViewModel(questions: [
    Question(id: UUID(), text: "Additional Question 1"),
    Question(id: UUID(), text: "Additional Question 2"),
    // Add more questions as needed
])

struct ContentView: View {
    var body: some View {
        PaperQuestionView(viewModel: paperQuestionViewModel)
    }
}

struct Coew_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
