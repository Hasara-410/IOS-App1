import SwiftUI

struct LearnMenuView: View {
    @Environment(\.colorScheme) var colorScheme // Get the current color scheme (dark/light)

    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                // Header with dynamic text color based on dark/light mode
                HStack {
                    Text("Learn Menu")
                        .font(.title3)
                        .fontWeight(.bold)
                        .foregroundColor(colorScheme == .dark ? .white : .black) // Dynamic text color
                        .padding(.leading)

                    Spacer() // Push any content to the left if needed
                }
                .padding(.vertical)

                // Buttons for Camera, Lens, Lights, Others
                VStack(spacing: 16) {
                    NavigationLink(destination: LearnCameraView()) {
                        LearnButtonView(imageName: "Camera", title: "Camera")
                    }
                    
                    NavigationLink(destination: LearnLensesView()) {
                        LearnButtonView(imageName: "Lens", title: "Lens")
                    }
                    
                    NavigationLink(destination: LearnLightsView()) {
                        LearnButtonView(imageName: "Light", title: "Lights")
                    }

                    NavigationLink(destination: LearnOtherView()) {
                        LearnButtonView(imageName: "Other", title: "Others")
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

struct LearnButtonView: View {
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

// Placeholder Views for Navigation
struct learnCameraView: View {
    var body: some View {
        Text("Learn Camera View")
            .font(.largeTitle)
    }
}

struct learnLensesView: View {
    var body: some View {
        Text("Learn Lenses View")
            .font(.largeTitle)
    }
}

struct learnLightsView: View {
    var body: some View {
        Text("Learn Lights View")
            .font(.largeTitle)
    }
}

struct learnOtherView: View {
    var body: some View {
        Text("Learn Other View")
            .font(.largeTitle)
    }
}

struct LearnMenuView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            LearnMenuView()
                .previewDevice("iPhone 14")
                .preferredColorScheme(.light)

            LearnMenuView()
                .previewDevice("iPhone 14")
                .preferredColorScheme(.dark)
        }
    }
}
