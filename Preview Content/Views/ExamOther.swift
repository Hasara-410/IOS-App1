import SwiftUI

// Define the QuestionComposition struct to store composition-related questions
struct QuestionComposition {
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

struct QuestionCompositionView: View {
    @State private var currentQuestionIndex = 0 // Track the current question
    @State private var selectedAnswer: Int? = nil // Track the selected answer
    @State private var correctAnswers = 0 // Count correct answers
    @State private var incorrectAnswers = 0 // Count incorrect answers
    @State private var showResult = false // Show results at the end
    @State private var improvementSuggestions: [String] = [] // Suggestions for improvement
    
    // Define composition-related questions
    let questions = [
        QuestionComposition(text: "What is the Rule of Thirds?", options: [
            "A rule for lighting setup",
            "A composition technique dividing the frame into thirds",
            "A rule about camera settings",
            "A guideline for video resolution",
            "A lens selection rule"], correctAnswer: 1),
        
        QuestionComposition(text: "What is the purpose of Leading Lines?", options: [
            "Guiding the viewer's attention",
            "Selecting a focal length",
            "Choosing the correct ISO",
            "Adjusting aperture settings",
            "Setting shutter speed"], correctAnswer: 0),
        
        QuestionComposition(text: "What is Framing in photography?", options: [
            "Using objects within the scene to surround the subject",
            "Choosing the right lens",
            "Adjusting ISO for better exposure",
            "Ensuring focus on the background",
            "Changing the color balance"], correctAnswer: 0),
        
        QuestionComposition(text: "What does Depth of Field refer to?", options: [
            "The range of distance within a shot that appears in focus",
            "The quality of light in a photograph",
            "The focal length of the lens used",
            "The aperture settings used",
            "The resolution of the image"], correctAnswer: 0),
        
        QuestionComposition(text: "What is the Golden Hour?", options: [
            "The time of day when the sun is directly overhead",
            "The time of day with soft, warm light just after sunrise or before sunset",
            "The time when the sun is high in the sky and shadows are minimal",
            "The time when the sun is low and shadows are harsh",
            "The time when the moonlight is soft and blue"], correctAnswer: 1),
        
        QuestionComposition(text: "What is the Rule of Odds?", options: [
            "Using even numbers to create symmetry",
            "Using odd numbers of elements in a composition for balance",
            "Using numbers to determine the aperture size",
            "Using the number 3 for the Rule of Thirds",
            "Balancing light and dark areas equally"], correctAnswer: 1),
        
        QuestionComposition(text: "What does Negative Space do in composition?", options: [
            "Adds clutter to the image",
            "Simplifies and emphasizes the subject",
            "Creates high contrast",
            "Ensures proper focus",
            "Improves resolution"], correctAnswer: 1),
        
        QuestionComposition(text: "What is the best way to use Backlight in a photo?", options: [
            "Shoot with the light source behind the subject to create silhouettes",
            "Use backlighting to add contrast to the subject",
            "Backlight is used only in dark scenes",
            "Use backlight to illuminate the background",
            "Avoid backlight in any photo"], correctAnswer: 0),
        
        QuestionComposition(text: "What effect does Framing have on a photo?", options: [
            "It isolates the subject and provides focus",
            "It creates harsh contrasts",
            "It adds too much visual noise",
            "It is used only in nature photography",
            "It helps in balancing brightness"], correctAnswer: 0),
        
        QuestionComposition(text: "What role does the Rule of Thirds play in composition?", options: [
            "Divides the image into three sections vertically",
            "Guides the placement of key elements to enhance balance",
            "Determines the color palette of the image",
            "Sets the brightness levels in the composition",
            "Decides the image’s ISO settings"], correctAnswer: 1)
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
            improvementSuggestions.append("Review the basic principles of composition techniques such as Rule of Thirds, Leading Lines, and Framing.")
            improvementSuggestions.append("Understand how to use Depth of Field and Negative Space to improve visual impact.")
            improvementSuggestions.append("Practice applying the Golden Hour and Rule of Odds in your compositions.")
        } else {
            improvementSuggestions.append("Great job! Keep practicing to maintain your composition skills!")
        }
    }
}

struct QuestionCompositionView_Previews: PreviewProvider {
    static var previews: some View {
        QuestionCompositionView()
    }
}
