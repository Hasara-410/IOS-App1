import SwiftUI

struct SplashScreen: View {
    @State private var isActive = false
    @State private var logoScale: CGFloat = 0.5 // Start small
    @State private var opacity: Double = 0.0 // Start with invisible text

    var body: some View {
        if isActive {
            LoginView() // Navigate to HomeView instead of LoginView
        } else {
            ZStack {
                // Background Color (Gradient)
                LinearGradient(
                    colors: [Color.blue, Color.purple],
                    startPoint: .top,
                    endPoint: .bottom
                )
                .edgesIgnoringSafeArea(.all)

                // Logo and App Name
                VStack(spacing: 20) {
                    // Animated Logo
                    Image("AppLogo1") // Make sure 'AppLogo' is added to Assets.xcassets
                        .resizable()
                        .scaledToFit()
                        .frame(width: 250, height: 250)
                        .scaleEffect(logoScale) // Apply scaling effect
                        .onAppear {
                            // Animate logo scaling
                            withAnimation(.easeOut(duration: 1.5)) {
                                logoScale = 1.0
                            }
                        }

                    // Animated Text (App Name)
                    Text("Cine Learn")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .opacity(opacity) // Control opacity for fade-in effect
                        .onAppear {
                            // Animate text fade-in
                            withAnimation(.easeIn(duration: 1.0).delay(0.5)) {
                                opacity = 1.0
                            }
                        }
                }
            }
            .onAppear {
                // Transition after 2 seconds
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    withAnimation {
                        isActive = true // Navigate to HomeView
                    }
                }
            }
        }
    }
}

struct SplashScreen_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreen()
    }
}
