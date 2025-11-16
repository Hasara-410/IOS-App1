import SwiftUI

struct QuestionView: View {
    @State private var currentQuestionIndex = 0 // Track the current question
    @State private var selectedAnswer: Int? = nil // Track the selected answer
    @State private var correctAnswers = 0 // Count correct answers
    @State private var incorrectAnswers = 0 // Count incorrect answers
    @State private var showResult = false // Show results at the end
    @State private var improvementSuggestions: [String] = [] // Suggestions for improvement
    
    // Updated question data
    let questions = [
        Question(
            text: "What does ISO control in photography?",
            options: [
                "The camera's white balance",
                "The sensitivity of the sensor to light",
                "The focal length of the lens",
                "The sharpness of the image",
                "The exposure time"
            ],
            correctAnswer: 1
        ),
        Question(
            text: "What is shutter speed measured in?",
            options: [
                "Pixels",
                "Fractions of a second",
                "ISO values",
                "Stops",
                "Depth of field"
            ],
            correctAnswer: 1
        ),
        Question(
            text: "What does aperture primarily affect in a photo?",
            options: [
                "The sharpness of the entire frame",
                "The brightness of the image and depth of field",
                "The shutter speed required",
                "The ISO sensitivity",
                "The white balance of the photo"
            ],
            correctAnswer: 1
        ),
        Question(
            text: "What is the purpose of white balance in photography?",
            options: [
                "To adjust brightness",
                "To remove color casts for accurate colors",
                "To set the focus of the camera",
                "To control depth of field",
                "To increase the sensor sensitivity"
            ],
            correctAnswer: 1
        ),
        Question(
            text: "What does exposure determine in a photograph?",
            options: [
                "The sharpness of the image",
                "The amount of light captured in the photo",
                "The focal length of the lens",
                "The color balance",
                "The sensor's sensitivity"
            ],
            correctAnswer: 1
        ),
        Question(
            text: "What is the function of focus in a camera?",
            options: [
                "To adjust ISO levels",
                "To control the depth of field",
                "To make the subject sharp and clear",
                "To increase the exposure",
                "To stabilize the image"
            ],
            correctAnswer: 2
        ),
        Question(
            text: "How does aperture size affect depth of field?",
            options: [
                "Smaller apertures result in a shallower depth of field",
                "Larger apertures create a deeper depth of field",
                "Larger apertures create a shallower depth of field",
                "Aperture size does not affect depth of field",
                "It depends on the shutter speed"
            ],
            correctAnswer: 2
        ),
        Question(
            text: "What does a fast shutter speed do?",
            options: [
                "Freezes motion in the frame",
                "Makes the image brighter",
                "Increases depth of field",
                "Creates motion blur",
                "Adjusts the white balance"
            ],
            correctAnswer: 0
        ),
        Question(
            text: "What is the primary purpose of adjusting exposure?",
            options: [
                "To change the white balance",
                "To achieve a well-lit photo",
                "To adjust the focal length",
                "To stabilize the image",
                "To increase the ISO"
            ],
            correctAnswer: 1
        ),
        Question(
            text: "What does depth of field refer to?",
            options: [
                "The distance between the nearest and farthest objects in focus",
                "The amount of light entering the lens",
                "The sharpness of the subject",
                "The focal length of the lens",
                "The brightness of the photo"
            ],
            correctAnswer: 0
        )
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
                    
                    HStack {
                        Button("Retry") {
                            restartQuiz()
                        }
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        
                        Spacer()
                        
                        // NavigationLink to ExamMenuView
                        NavigationLink(destination: ExamMenuView()) {
                            Button("Done") {
                                // Navigate to Exam Menu
                            }
                            .padding()
                            .background(Color.gray)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                        }
                    }
                    .padding()
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
        .navigationTitle("Quiz") // Title for navigation bar
        .navigationBarTitleDisplayMode(.inline) // Title display mode
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
        // Reset all values for retry
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
            improvementSuggestions.append("Review the basic principles of exposure, aperture, ISO, and shutter speed.")
            improvementSuggestions.append("Pay more attention to understanding how camera settings interact for better exposure.")
            improvementSuggestions.append("Test different settings in practice to better understand depth of field and focus.")
        } else {
            improvementSuggestions.append("Great job! Keep practicing to maintain your knowledge!")
        }
    }
}

struct Question: Identifiable {
    let id = UUID()
    let text: String
    let options: [String]
    let correctAnswer: Int
}

struct QuestionView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            QuestionView()
        }
    }
}
