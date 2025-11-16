import SwiftUI

struct SplashScreenNewUser: View {
    @State private var fadeIn = false
    @State private var showNextScreen = false
    var name: String // Accept name as a parameter

    var body: some View {
        NavigationStack {
            VStack {
                VStack {
                    // App Logo with animation
                    Image("SplashAnupa") // Replace with your image name
                        .resizable()
                        .scaledToFit()
                        .frame(width: 200, height: 200) // Large size for visibility
                        .padding(.bottom, 50)
                        .opacity(fadeIn ? 1.0 : 0.0)
                        .scaleEffect(fadeIn ? 1.0 : 0.5)
                        .animation(.easeOut(duration: 1.0), value: fadeIn)

                    // Welcome Messages with animations
                    VStack(alignment: .center, spacing: 15) {
                        Text("Hello...")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .foregroundColor(.primary)
                            .opacity(fadeIn ? 1.0 : 0.0)
                            .animation(.easeIn(duration: 1.0).delay(0.5), value: fadeIn)

                        Text("Welcome \(name)...") // Display user's name here
                            .font(.title)
                            .foregroundColor(.secondary)
                            .opacity(fadeIn ? 1.0 : 0.0)
                            .animation(.easeIn(duration: 1.0).delay(1.0), value: fadeIn)

                        Text("Let's get started!")
                            .font(.title2)
                            .fontWeight(.semibold)
                            .foregroundColor(.blue)
                            .opacity(fadeIn ? 1.0 : 0.0)
                            .animation(.easeIn(duration: 1.0).delay(1.5), value: fadeIn)
                    }
                }
                .onAppear {
                    fadeIn = true
                    // After 3 seconds, transition to next screen (you can modify the delay as needed)
                    DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                        showNextScreen = true
                    }
                }

                // Navigation to HomeView when showNextScreen is true
                NavigationLink(destination: HomeView(), isActive: $showNextScreen) {
                    EmptyView() // No visible UI element, just trigger navigation
                }
            }
            .background(Color.white.edgesIgnoringSafeArea(.all))
        }
    }
}

struct SplashScreenNewUser_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreenNewUser(name: "New User")
    }
}
