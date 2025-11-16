import SwiftUI

struct LoginView: View {
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var errorMessage: String? = nil
    @State private var imageScale: CGFloat = 1.0 // For animation
    @State private var navigateToSplash = false // State variable to trigger navigation

    var body: some View {
        NavigationStack { // Use NavigationStack for iOS 16+
            VStack {
                // App Logo with Animation
                Image("LensImg") // Replace with your image name
                    .resizable()
                    .scaledToFit()
                    .frame(width: 120, height: 120)
                    .padding(.top, 50)
                    .scaleEffect(imageScale) // Apply scale effect
                    .onAppear {
                        withAnimation(
                            Animation.easeInOut(duration: 2.0)
                                .repeatForever(autoreverses: true)
                        ) {
                            imageScale = 1.1 // Slightly enlarge
                        }
                    }

                // Header
                Text("Welcome Back!")
                    .font(.title)
                    .fontWeight(.semibold)
                    .foregroundColor(.primary)
                    .padding(.top, 20)

                // Email Input
                TextField("Enter your email", text: $email)
                    .keyboardType(.emailAddress)
                    .padding(.horizontal)
                    .padding(.vertical, 12)
                    .background(Color.clear)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(email.isEmpty ? Color.gray : Color.blue, lineWidth: 1)
                    )
                    .cornerRadius(10)
                    .padding(.horizontal)
                    .padding(.top, 20)

                // Password Input
                SecureField("Enter your password", text: $password)
                    .padding(.horizontal)
                    .padding(.vertical, 12)
                    .background(Color.clear)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(password.isEmpty ? Color.gray : Color.blue, lineWidth: 1)
                    )
                    .cornerRadius(10)
                    .padding(.horizontal)
                    .padding(.top, 10)

                // Error message display
                if let errorMessage = errorMessage {
                    Text(errorMessage)
                        .foregroundColor(.red)
                        .padding(.top, 10)
                }

                // Login Button
                Button(action: {
                    loginUser()
                }) {
                    Text("Login")
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(LinearGradient(gradient: Gradient(colors: [Color.blue, Color.purple]), startPoint: .leading, endPoint: .trailing))
                        .cornerRadius(15)
                        .shadow(color: Color.blue.opacity(0.3), radius: 5, x: 0, y: 5)
                        .padding(.horizontal)
                        .padding(.top, 20)
                }

                Spacer()

                // SignUp Navigation
                HStack {
                    Text("Don't have an account?")
                    NavigationLink(destination: SignUpView()) {
                        Text("Sign Up")
                            .fontWeight(.bold)
                            .foregroundColor(.blue)
                    }
                }
                .padding(.bottom, 30)
            }
            .background(Color.white.edgesIgnoringSafeArea(.all))
            
            // Using navigationDestination to handle navigation to SplashScreenAnupa
            .navigationDestination(isPresented: $navigateToSplash) {
                SplashScreenHasara() // Destination view
            }
        }
    }

    private func loginUser() {
        // Hardcoded credentials check
        if email == "Hasara@gmail.com" && password == "hasara123" {
            errorMessage = nil
            navigateToSplash = true // Trigger navigation to the splash screen
        } else {
            errorMessage = "Invalid email or password."
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
            .previewLayout(.sizeThatFits)
            .padding()
            .previewDevice("iPhone 15")
            .environment(\.colorScheme, .light)
    }
}
