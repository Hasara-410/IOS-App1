import SwiftUI

// Define the QuestionLighting struct to store lighting-related questions
struct QuestionLighting {
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

struct QuestionLightingView: View {
    @State private var currentQuestionIndex = 0 // Track the current question
    @State private var selectedAnswer: Int? = nil // Track the selected answer
    @State private var correctAnswers = 0 // Count correct answers
    @State private var incorrectAnswers = 0 // Count incorrect answers
    @State private var showResult = false // Show results at the end
    @State private var improvementSuggestions: [String] = [] // Suggestions for improvement
    
    // Define lighting-related questions
    let questions = [
        QuestionLighting(text: "What is the purpose of Key Light?", options: [
            "To add highlights and shadows",
            "To create a strong, focused light on the subject",
            "To provide fill light for a softer look",
            "To emphasize the background",
            "To reflect light onto the subject"], correctAnswer: 1),
        
        QuestionLighting(text: "What is Rim Light used for?", options: [
            "To illuminate the subject from behind and create a silhouette",
            "To create hard shadows on the subject",
            "To add contrast to the background",
            "To highlight the subject's contours",
            "To soften the subject's features"], correctAnswer: 3),
        
        QuestionLighting(text: "What is Fill Light typically used for?", options: [
            "To add contrast to the background",
            "To balance shadows created by the key light",
            "To add a soft glow around the subject",
            "To create hard shadows",
            "To focus light on specific details"], correctAnswer: 1),
        
        QuestionLighting(text: "What is the purpose of Backlight?", options: [
            "To illuminate the subject from behind, creating a silhouette effect",
            "To add a soft halo around the subject",
            "To create a high contrast between the subject and the background",
            "To soften the key light and fill light",
            "To enhance the details of the background"], correctAnswer: 0),
        
        QuestionLighting(text: "What is the purpose of a Hair Light?", options: [
            "To highlight the subject's hair and add dimension",
            "To create dramatic shadows on the subject's face",
            "To fill in the background with light",
            "To create lens flares",
            "To diffuse the main light source"], correctAnswer: 0),
        
        QuestionLighting(text: "What is the effect of hard light?", options: [
            "Soft shadows and smooth transitions",
            "Sharp, well-defined shadows",
            "Even and diffused lighting across the subject",
            "Flattering light on the face",
            "Creates a balanced and natural look"], correctAnswer: 1),
        
        QuestionLighting(text: "Which lighting setup is best for creating a dramatic mood?", options: [
            "High key lighting",
            "Low key lighting",
            "Natural lighting",
            "Soft lighting",
            "Flat lighting"], correctAnswer: 1),
        
        QuestionLighting(text: "What does the term 'three-point lighting' refer to?", options: [
            "A lighting setup that includes key, fill, and backlight",
            "A setup with three lights aimed at a subject's face",
            "A lighting technique for outdoor photography",
            "A method to balance the exposure of a subject",
            "A technique for photographing with three cameras"], correctAnswer: 0),
        
        QuestionLighting(text: "What type of light is used to minimize harsh shadows on the subject?", options: [
            "Key light",
            "Fill light",
            "Backlight",
            "Rim light",
            "Hair light"], correctAnswer: 1),
        
        QuestionLighting(text: "What does 'white balance' in lighting do?", options: [
            "Adjusts the contrast in the image",
            "Balances the exposure between light and dark areas",
            "Ensures that white objects appear white in the photograph",
            "Increases the intensity of the key light",
            "Reduces shadows from the light source"], correctAnswer: 2),
        
        QuestionLighting(text: "Which light is used to illuminate the background?", options: [
            "Key light",
            "Backlight",
            "Background light",
            "Fill light",
            "Rim light"], correctAnswer: 2),
        
        QuestionLighting(text: "What does a soft light source create in a scene?", options: [
            "Sharp, distinct shadows",
            "Soft, gradual shadows",
            "High contrast",
            "Dramatic mood",
            "Strong highlights and low contrast"], correctAnswer: 1),
        
        QuestionLighting(text: "What effect is commonly associated with a high-key lighting setup?", options: [
            "Bright, even lighting with little contrast",
            "Low, moody lighting with deep shadows",
            "Bright contrast with sharp shadows",
            "Dramatic, dark contrast",
            "Backlit, silhouette effect"], correctAnswer: 0)
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
            improvementSuggestions.append("Review lighting techniques such as Key Light, Rim Light, and Fill Light.")
            improvementSuggestions.append("Focus on understanding the purpose and placement of different lights in photography.")
            improvementSuggestions.append("Study lighting setups for different shooting environments.")
        } else {
            improvementSuggestions.append("Great job! Keep practicing to maintain your knowledge!")
        }
    }
}

struct QuestionLightingView_Previews: PreviewProvider {
    static var previews: some View {
        QuestionLightingView()
    }
}
