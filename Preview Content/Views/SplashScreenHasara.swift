import SwiftUI

struct SplashScreenHasara: View {
    @State private var fadeIn = false
    @State private var showNextScreen = false

    var body: some View {
        NavigationStack {
            VStack {
                // Use NavigationLink with isActive binding to programmatically trigger the navigation
                NavigationLink(
                    destination: HomeView(),
                    isActive: $showNextScreen
                ) {
                    EmptyView() // You don't need any visible content here
                }

                if !showNextScreen {
                    VStack {
                        // App Logo
                        Image("SplashHasara") // image
                            .resizable()
                            .scaledToFit()
                            .frame(width: 200, height: 200)
                            .padding(.bottom, 50)
                            .opacity(fadeIn ? 1.0 : 0.0)
                            .scaleEffect(fadeIn ? 1.0 : 0.5)
                            .animation(.easeOut(duration: 1.0), value: fadeIn)

                        // Welcome Messages
                        VStack(alignment: .center, spacing: 15) {
                            Text("Hello...")
                                .font(.largeTitle)
                                .fontWeight(.bold)
                                .foregroundColor(.primary)
                                .opacity(fadeIn ? 1.0 : 0.0)
                                .animation(.easeIn(duration: 1.0).delay(0.5), value: fadeIn)

                            Text("Welcome Hasara...")
                                .font(.title)
                                .foregroundColor(.secondary)
                                .opacity(fadeIn ? 1.0 : 0.0)
                                .animation(.easeIn(duration: 1.0).delay(1.0), value: fadeIn)

                            Text("Ready to learn.")
                                .font(.title2)
                                .fontWeight(.semibold)
                                .foregroundColor(.blue)
                                .opacity(fadeIn ? 1.0 : 0.0)
                                .animation(.easeIn(duration: 1.0).delay(1.5), value: fadeIn)
                        }
                    }
                    .onAppear {
                        fadeIn = true
                        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                            showNextScreen = true
                        }
                    }
                }
            }
            .background(Color.white.edgesIgnoringSafeArea(.all))
        }
    }
}

struct SplashScreenAnupa_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreenHasara()
    }
}
