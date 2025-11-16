import SwiftUI

// Define the QuestionLens struct to store lens-related questions
struct QuestionLens {
    let text: String
    let options: [String]
    let correctAnswer: Int
    
    // Explicit initializer
    init(text: String, options: [String], correctAnswer: Int) {
        self.text = text
        self.options = options
        self.correctAnswer = correctAnswer
    }
}

struct QuestionLensView: View {
    @State private var currentQuestionIndex = 0 // Track the current question
    @State private var selectedAnswer: Int? = nil // Track the selected answer
    @State private var correctAnswers = 0 // Count correct answers
    @State private var incorrectAnswers = 0 // Count incorrect answers
    @State private var showResult = false // Show results at the end
    @State private var improvementSuggestions: [String] = [] // Suggestions for improvement
    
    // Define lens-related questions
    let questions = [
        QuestionLens(text: "What is a Prime Lens known for?", options: [
            "Variable focal length",
            "Fixed focal length with sharp image quality",
            "Wide-angle capabilities",
            "Close-up photography",
            "Adjustable zoom features"], correctAnswer: 1),
        
        QuestionLens(text: "What advantage do Zoom Lenses offer?", options: [
            "Lightweight and compact design",
            "Ability to change focal lengths",
            "Superior image quality at all ranges",
            "Specialized for close-up shots",
            "Capturing ultra-wide images"], correctAnswer: 1),
        
        QuestionLens(text: "What are Wide-Angle Lenses typically used for?", options: [
            "Portrait photography",
            "Capturing landscapes and large scenes",
            "Shooting distant subjects",
            "Close-up details",
            "Creating fisheye effects"], correctAnswer: 1),
        
        QuestionLens(text: "What is the primary use of Telephoto Lenses?", options: [
            "Capturing distant subjects with high detail",
            "Creating wide-angle perspectives",
            "Shooting extreme close-ups",
            "Adjusting white balance",
            "Focusing on sharpness"], correctAnswer: 0),
        
        QuestionLens(text: "What makes Macro Lenses unique?", options: [
            "Capturing distant objects",
            "Ability to photograph small details at close range",
            "Wide-angle views",
            "Fixed focal length for portraits",
            "Creating fisheye distortions"], correctAnswer: 1),
        
        QuestionLens(text: "What effect is characteristic of Fisheye Lenses?", options: [
            "Wide-angle distortion and circular images",
            "Close-up photography with no distortion",
            "Capturing distant subjects",
            "Balanced and natural perspectives",
            "Zoom capabilities"], correctAnswer: 0),
        
        QuestionLens(text: "What is the purpose of Standard Lenses?", options: [
            "Extreme close-up photography",
            "Balanced perspectives and versatility",
            "Wide-angle landscapes",
            "Capturing distant subjects",
            "Creating fisheye distortions"], correctAnswer: 1),
        
        QuestionLens(text: "Which lens is best for capturing expansive landscapes?", options: [
            "Wide-Angle Lens",
            "Telephoto Lens",
            "Prime Lens",
            "Macro Lens",
            "Standard Lens"], correctAnswer: 0),
        
        QuestionLens(text: "Which lens is ideal for wildlife photography?", options: [
            "Wide-Angle Lens",
            "Macro Lens",
            "Telephoto Lens",
            "Standard Lens",
            "Fisheye Lens"], correctAnswer: 2),
        
        QuestionLens(text: "What is a primary drawback of Zoom Lenses compared to Prime Lenses?", options: [
            "Higher weight and complexity",
            "Inability to change focal lengths",
            "Limited sharpness and quality",
            "No close-up capabilities",
            "Lack of distortion"], correctAnswer: 0)
    ]
    
    var body: some View {
        VStack {
            if showResult {
                // Show results after all questions are answered
                VStack {
                    Text("Results")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    
                    Text("Correct Answers: \(correctAnswers)")
                        .font(.title2)
                        .foregroundColor(.green)
                    
                    Text("Incorrect Answers: \(incorrectAnswers)")
                        .font(.title2)
                        .foregroundColor(.red)
                    
                    Text("Marks: \(correctAnswers * 10)/100")
                        .font(.title)
                        .fontWeight(.bold)
                        .padding(.top, 10)
                    
                    Text("Improvement Suggestions:")
                        .font(.headline)
                        .padding(.top, 10)
                    
                    ForEach(improvementSuggestions, id: \.self) { suggestion in
                        Text("• \(suggestion)")
                            .padding(.vertical, 2)
                    }
                    
                    Button("Retry") {
                        restartQuiz()
                    }
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                }
                .padding()
            } else {
                // Display the current question
                VStack {
                    Text("Question \(currentQuestionIndex + 1) of \(questions.count)")
                        .font(.headline)
                        .padding(.bottom, 10)
                    
                    Text(questions[currentQuestionIndex].text)
                        .font(.title2)
                        .fontWeight(.semibold)
                        .padding()
                    
                    Spacer()
                    
                    // Display answer options
                    ForEach(0..<questions[currentQuestionIndex].options.count, id: \.self) { index in
                        Button(action: {
                            selectedAnswer = index
                        }) {
                            HStack {
                                Text(questions[currentQuestionIndex].options[index])
                                    .foregroundColor(.white)
                                    .padding()
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .background(selectedAnswer == index ? Color.blue : Color.gray)
                            .cornerRadius(10)
                            .padding(.horizontal)
                        }
                    }
                    
                    Spacer()
                    
                    // Next button
                    Button(action: {
                        processAnswer()
                    }) {
                        Text(currentQuestionIndex == questions.count - 1 ? "Finish" : "Next")
                            .font(.headline)
                            .padding()
                            .background(Color.green)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                    .padding()
                    .disabled(selectedAnswer == nil) // Disable if no answer selected
                }
                .padding()
            }
        }
        .animation(.easeInOut, value: currentQuestionIndex) // Smooth transition
    }
    
    func processAnswer() {
        // Check if the selected answer is correct
        if selectedAnswer == questions[currentQuestionIndex].correctAnswer {
            correctAnswers += 1
        } else {
            incorrectAnswers += 1
        }
        
        // Move to the next question or show results
        if currentQuestionIndex == questions.count - 1 {
            showResult = true
            generateImprovementSuggestions() // Generate suggestions after quiz ends
        } else {
            currentQuestionIndex += 1
            selectedAnswer = nil // Reset the selected answer
        }
    }
    
    func restartQuiz() {
        // Reset all values
        currentQuestionIndex = 0
        correctAnswers = 0
        incorrectAnswers = 0
        selectedAnswer = nil
        showResult = false
        improvementSuggestions = [] // Clear previous suggestions
    }
    
    func generateImprovementSuggestions() {
        // Generate improvement suggestions based on incorrect answers
        improvementSuggestions = []
        
        if incorrectAnswers > 0 {
            improvementSuggestions.append("Review the different types of lenses and their applications.")
            improvementSuggestions.append("Focus on the benefits and drawbacks of each type of lens.")
            improvementSuggestions.append("Study the specific uses of wide-angle, telephoto, and macro lenses.")
        } else {
            improvementSuggestions.append("Great job! Keep practicing to maintain your knowledge!")
        }
    }
}

struct QuestionLensView_Previews: PreviewProvider {
    static var previews: some View {
        QuestionLensView()
    }
}
