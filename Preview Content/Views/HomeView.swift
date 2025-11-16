import SwiftUI

struct HomeView: View {
    let newsItems = [
        ("New Photography Techniques Released!", "N1"),
        ("Top 10 Cameras for Beginners in 2024", "N2"),
        ("Lighting Basics: Improve Your Shots", "N3"),
        ("Upcoming Photography Workshops", "N4"),
        ("Lens Buying Guide for Professionals", "N5")
    ]
    
    @Environment(\.colorScheme) var colorScheme
    @State private var isDarkMode: Bool = false
    @State private var isSideMenuVisible: Bool = false
    @State private var offset: CGFloat = -300
    @State private var isLoggedOut: Bool = false
    @State private var navigateToLogin: Bool = false
    @State private var currentIndex = 0 // Current index of the visible news card
    
    var body: some View {
        ZStack {
            // Main Content
            NavigationStack {
                VStack(spacing: 20) {
                    // Header
                    HStack {
                        // Side Menu Button
                        Button(action: {
                            withAnimation {
                                isSideMenuVisible.toggle()
                                offset = isSideMenuVisible ? 0 : -300
                            }
                        }) {
                            Image(systemName: "line.horizontal.3")
                                .font(.title2)
                                .foregroundColor(colorScheme == .dark ? .white : .black)
                        }
                        .padding(.leading)

                        // "Latest News" Button
                        NavigationLink(destination: NewsMenuView()) {
                            Text("Latest News")
                                .font(.title3)
                                .fontWeight(.bold)
                                .foregroundColor(colorScheme == .dark ? .white : .black)
                        }
                        .padding(.leading)

                        Spacer()

                        // NavigationLink to NotesView
                        NavigationLink(destination: NotesView()) {
                            Image(systemName: "pencil.circle.fill")
                                .font(.title2)
                                .foregroundColor(.blue)
                                .accessibilityLabel("Add Note")
                        }
                        .padding(.trailing, 8)

                        // Dark Mode Toggle
                        HStack(spacing: 8) {
                            Image(systemName: "sun.max.fill")
                                .font(.system(size: 14))
                                .foregroundColor(.orange)

                            Toggle("", isOn: $isDarkMode)
                                .toggleStyle(SwitchToggleStyle(tint: .blue))
                                .labelsHidden()
                                .scaleEffect(0.8)

                            Image(systemName: "moon.fill")
                                .font(.system(size: 14))
                                .foregroundColor(.yellow)
                        }
                    }
                    .padding(.top, 20)  // Added more space at the top
                    .padding(.horizontal)

                    // News Section with Automatic Sliding
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 20) {
                            ForEach(newsItems.indices, id: \.self) { index in
                                NewsCardView(newsText: newsItems[index].0, imageName: newsItems[index].1)
                                    .frame(width: 300)
                            }
                        }
                        .padding(.horizontal)
                        .offset(x: -CGFloat(currentIndex) * 320) // Adjust offset for sliding
                        .animation(.easeInOut(duration: 0.8), value: currentIndex)
                        .onAppear {
                            startAutoSliding()
                        }
                    }

                    // Learn Button with NavigationLink (Smaller Height)
                    NavigationLink(destination: LearnMenuView()) {
                        ZStack {
                            Image("Learn")
                                .resizable()
                                .scaledToFill()
                                .frame(maxWidth: .infinity, maxHeight: 180) // Reduced height
                                .clipped()
                                .cornerRadius(15)
                                .blur(radius: 5)

                            Color.black.opacity(0.4)
                                .cornerRadius(15)

                            Text("Learn")
                                .font(.title)
                                .foregroundColor(.white)
                                .fontWeight(.bold)
                        }
                        .frame(maxWidth: .infinity, minHeight: 180) // Reduced height
                        .background(colorScheme == .dark ? Color.black : Color.blue)
                        .cornerRadius(15)
                        .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 5)
                        .padding(.horizontal)
                    }

                    // Examine Button with NavigationLink (Smaller Height)
                    NavigationLink(destination: ExamMenuView()) {
                        ZStack {
                            Image("Exam")
                                .resizable()
                                .scaledToFill()
                                .frame(maxWidth: .infinity, maxHeight: 180) // Reduced height
                                .clipped()
                                .cornerRadius(15)
                                .blur(radius: 5)

                            Color.black.opacity(0.4)
                                .cornerRadius(15)

                            Text("Examine Your Knowledge")
                                .font(.title)
                                .foregroundColor(.white)
                                .fontWeight(.bold)
                        }
                        .frame(maxWidth: .infinity, minHeight: 180) // Reduced height
                        .background(colorScheme == .dark ? Color.black : Color.blue)
                        .cornerRadius(15)
                        .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 5)
                        .padding(.horizontal)
                    }

                    // New "Buy Equipment" Button
                    NavigationLink(destination: BuyEquipmentView()) {
                        Text("Buy Equipment")
                            .font(.title3)
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity, minHeight: 50)
                            .background(Color.green)
                            .cornerRadius(10)
                            .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 5)
                            .padding(.horizontal)
                    }

                    Spacer()
                }
                .padding(.vertical, 20)
                .background(colorScheme == .dark ? Color.black.edgesIgnoringSafeArea(.all) : Color.white.edgesIgnoringSafeArea(.all))
                .preferredColorScheme(isDarkMode ? .dark : .light)
                .navigationBarBackButtonHidden(true)
            }
        }
    }
    
    // Function to start auto sliding
    private func startAutoSliding() {
        Timer.scheduledTimer(withTimeInterval: 3, repeats: true) { _ in
            withAnimation {
                currentIndex = (currentIndex + 1) % newsItems.count
            }
        }
    }
}

struct NewsCardView: View {
    let newsText: String
    let imageName: String
    
    var body: some View {
        VStack {
            // News Image
            Image(imageName)
                .resizable()
                .scaledToFill()
                .frame(width: 300, height: 150)
                .clipped()
                .cornerRadius(10)

            // News Title
            Text(newsText)
                .font(.headline)
                .fontWeight(.semibold)
                .foregroundColor(.black)
                .multilineTextAlignment(.center)
                .padding([.top, .horizontal], 10)
        }
        .frame(width: 300, height: 220)
        .background(
            Color.white
                .cornerRadius(15)
                .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 5)
        )
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
