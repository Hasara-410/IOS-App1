import SwiftUI

struct SignUpView: View {
    @State private var name: String = ""
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var confirmPassword: String = ""
    @State private var errorMessage: String? = nil
    @State private var imageScale: CGFloat = 1.0
    @State private var showSuccessMessage = false
    @State private var showSplashScreen = false
    
    // For navigation link
    @State private var navigateToSplashScreen = false

    var body: some View {
        NavigationView {
            VStack {
                // App Logo with Animation
                Image("LensImg")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 120, height: 120)
                    .padding(.top, 50)
                    .scaleEffect(imageScale)
                    .onAppear {
                        withAnimation(
                            Animation.easeInOut(duration: 2.0)
                                .repeatForever(autoreverses: true)
                        ) {
                            imageScale = 1.1
                        }
                    }

                // Header
                Text("Create an Account!")
                    .font(.title)
                    .fontWeight(.semibold)
                    .foregroundColor(.primary)
                    .padding(.top, 20)

                // Name Input
                TextField("Enter your name", text: $name)
                    .padding(.horizontal)
                    .padding(.vertical, 12)
                    .background(Color.clear)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(name.isEmpty ? Color.gray : Color.blue, lineWidth: 1)
                    )
                    .cornerRadius(10)
                    .padding(.horizontal)
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
                    .padding(.top, 10)

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

                // Confirm Password Input
                SecureField("Confirm your password", text: $confirmPassword)
                    .padding(.horizontal)
                    .padding(.vertical, 12)
                    .background(Color.clear)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(confirmPassword.isEmpty ? Color.gray : Color.blue, lineWidth: 1)
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

                // Success Message
                if showSuccessMessage {
                    Text("Account created successfully!")
                        .foregroundColor(.green)
                        .fontWeight(.bold)
                        .padding(.top, 10)
                        .transition(.opacity)
                        .animation(.easeInOut(duration: 1.0))
                }

                // Sign Up Button
                Button(action: {
                    signUpUser()
                }) {
                    Text("Sign Up")
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
                .padding(.top, 20)

                Spacer()

                // Navigation to LoginView
                HStack {
                    Text("Already have an account?")
                    NavigationLink(destination: LoginView()) {
                        Text("Login")
                            .fontWeight(.bold)
                            .foregroundColor(.blue)
                    }
                }
                .padding(.bottom, 30)
                
                // Navigate to SplashScreenNewUser after successful sign-up
                NavigationLink(
                    destination: SplashScreenNewUser(name: name),
                    isActive: $navigateToSplashScreen,
                    label: { EmptyView() }
                )
            }
            .background(Color.white.edgesIgnoringSafeArea(.all))
        }
    }

    private func signUpUser() {
        // Validate inputs
        guard !name.isEmpty else {
            errorMessage = "Name is required."
            return
        }

        guard !email.isEmpty else {
            errorMessage = "Email is required."
            return
        }

        guard !password.isEmpty else {
            errorMessage = "Password is required."
            return
        }

        guard password == confirmPassword else {
            errorMessage = "Passwords do not match."
            return
        }

        errorMessage = nil
        showSuccessMessage = true
        // After successful account creation, navigate to the splash screen after a short delay
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            navigateToSplashScreen = true
        }
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}
