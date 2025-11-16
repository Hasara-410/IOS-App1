import SwiftUI

struct ExamMenuView: View {
    @Environment(\.colorScheme) var colorScheme // Get the current color scheme (dark/light)

    var body: some View {
        NavigationView { // Wrap the entire view in a NavigationView for navigation support
            VStack(spacing: 20) {
                // Header with dynamic text color based on dark/light mode
                HStack {
                    Text("Exam Menu")
                        .font(.title3)
                        .fontWeight(.bold)
                        .foregroundColor(colorScheme == .dark ? .white : .black) // Dynamic text color
                        .padding(.leading)

                    Spacer() // Push any content to the left if needed
                }
                .padding(.vertical)

                // Buttons for Camera, Lens, Lights, Others
                VStack(spacing: 16) {
                    NavigationLink(destination: QuestionView()) { // Navigate to QuestionLensView on tap
                        ExamButtonView(imageName: "Camera", title: "Camera")
                    }

                    NavigationLink(destination: QuestionLensView()) { // Navigate to QuestionLensView when "Lens" is tapped
                        ExamButtonView(imageName: "Lens", title: "Lens")
                    }

                    // Modify the Lights button to navigate to the QuestionLightingView
                    NavigationLink(destination: QuestionLightingView()) { // Navigate to QuestionLightingView when "Lights" is tapped
                        ExamButtonView(imageName: "Light", title: "Lights")
                    }

                    // Wrap the "Others" button in a NavigationLink to navigate to QuestionCompositionView
                    NavigationLink(destination: QuestionCompositionView()) { // Navigate to QuestionCompositionView when "Others" is tapped
                        ExamButtonView(imageName: "Other", title: "Others")
                    }
                }
                .padding(.top, 20)

                Spacer()
            }
            .padding(.vertical, 20)
            .background(colorScheme == .dark ? Color.black.edgesIgnoringSafeArea(.all) : Color.white.edgesIgnoringSafeArea(.all)) // Background based on mode
        }
    }
}

struct ExamButtonView: View {
    let imageName: String
    let title: String

    var body: some View {
        ZStack {
            Image(imageName) // Replace with your custom image name in Assets
                .resizable()
                .scaledToFill()
                .frame(maxWidth: 300, maxHeight: 160) // Adjusted size
                .clipped()
                .cornerRadius(12)
                .blur(radius: 5) // Apply a slight blur

            Text(title)
                .font(.title2) // Slightly smaller font size
                .foregroundColor(.white) // Text color for readability
                .fontWeight(.bold)
        }
        .frame(maxWidth: 300, minHeight: 160) // Adjusted size
        .background(Color.blue)
        .cornerRadius(12)
        .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 5)
        .padding(.horizontal)
    }
}

struct ExamMenuView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ExamMenuView()
                .previewDevice("iPhone 14")
                .preferredColorScheme(.light)

            ExamMenuView()
                .previewDevice("iPhone 14")
                .preferredColorScheme(.dark)
        }
    }
}
