import SwiftUI

struct LearnCameraView: View {
    @Environment(\.colorScheme) var colorScheme // Get the current color scheme (dark/light)
    
    // List of camera-related topics with icons
    let topics = [
        ("ISO", "sun.max.fill"),
        ("Shutter Speed", "clock.fill"),
        ("Aperture", "camera.aperture.fill"),
        ("White Balance", "paintbrush.fill"),
        ("Exposure", "sun.dust.fill"),
        ("Focus", "magnifyingglass"),
        ("Depth of Field", "rectangle.compress.vertical.fill")
    ]
    
    var body: some View {
        NavigationView {
            VStack {
                // Header with dynamic text color based on dark/light mode
                HStack {
                    Text("Learn Camera Settings")
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(colorScheme == .dark ? .white : .black)
                        .padding(.leading)

                    Spacer()
                }
                .padding(.vertical)
                
                // List to display camera settings in a visually appealing way
                ScrollView {
                    LazyVStack(spacing: 10) { // Reduced spacing between topics
                        ForEach(topics, id: \.0) { topic in
                            NavigationLink(destination: CameraDetailView(topic: topic.0)) {
                                // Card-style view for each camera setting with icons
                                HStack {
                                    Image(systemName: topic.1)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 50, height: 50)
                                        .foregroundColor(Color.white)
                                        .padding()
                                    
                                    VStack(alignment: .leading) {
                                        Text(topic.0)
                                            .font(.headline)
                                            .foregroundColor(.white)
                                            .padding(.bottom, 4)
                                        
                                        Text("Tap to Learn More")
                                            .font(.subheadline)
                                            .foregroundColor(.white.opacity(0.8))
                                    }
                                    .padding()
                                    .frame(maxWidth: .infinity)

                                    // Optional custom image for camera settings
                                    Image("your_image_name") // Use your image name here
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 30, height: 30) // Set the size of the image
                                        .padding(.trailing)
                                }
                                .background(
                                    LinearGradient(gradient: Gradient(colors: [Color.purple.opacity(0.7), Color.blue.opacity(0.8)]), startPoint: .topLeading, endPoint: .bottomTrailing)
                                )
                                .cornerRadius(20) // Smoothed corners
                                .shadow(radius: 10) // Depth with a soft shadow
                                .padding([.top, .horizontal])
                            }
                        }
                    }
                }
                .padding(.top, 20)
                
                Spacer()
            }
            .background(colorScheme == .dark ? Color.black.edgesIgnoringSafeArea(.all) : Color.white.edgesIgnoringSafeArea(.all))
            .navigationTitle("Camera Settings")
        }
    }
}

struct CameraDetailView: View {
    let topic: String

    // Sample notes and references for each camera topic
    let notes: String
    let references: String

    init(topic: String) {
        self.topic = topic
        // Add detailed notes for each camera topic
        switch topic {
        case "ISO":
            self.notes = """
            ISO refers to the sensitivity of your camera's sensor to light. A higher ISO value makes the sensor more sensitive, allowing you to shoot in lower light conditions, but it also increases the amount of noise in your photos.

            **Advantages**:
            - Higher ISO allows for shooting in low-light environments.
            - Useful for capturing fast-moving subjects in dim conditions.

            **Common Use Cases**:
            - **Low-Light Photography**: Ideal for indoor or night-time photography.
            - **Sports Photography**: Higher ISO allows for faster shutter speeds in low light.

            **Popular ISO Ranges**:
            - ISO 100 to 800 for most situations
            - ISO 1600 or higher for low-light environments
            """
            self.references = """
            - "Understanding ISO" on Photography Basics
            - "How to Manage ISO for Better Shots"
            """
        case "Shutter Speed":
            self.notes = """
            Shutter speed refers to the amount of time your camera's shutter is open to expose light to the sensor. Faster shutter speeds freeze motion, while slower shutter speeds can create motion blur effects.

            **Advantages**:
            - Fast shutter speeds (e.g., 1/1000) can freeze motion.
            - Slow shutter speeds (e.g., 1/30) can create motion blur, useful for creative effects.

            **Common Use Cases**:
            - **Action Photography**: Use fast shutter speeds to freeze motion, such as in sports or wildlife photography.
            - **Long Exposure Photography**: Slow shutter speeds for capturing light trails or smooth water effects.

            **Popular Shutter Speeds**:
            - Fast (e.g., 1/500 or 1/1000 for action shots)
            - Slow (e.g., 1/30 or longer for long exposure effects)
            """
            self.references = """
            - "Mastering Shutter Speed" on Digital Photography School
            - "Shutter Speed for Different Photography Styles"
            """
        case "Aperture":
            self.notes = """
            Aperture controls the size of the lens opening, which determines how much light hits the camera's sensor. It also affects the depth of field in your photos, influencing how much of the image is in focus.

            **Advantages**:
            - A wider aperture (lower f-number) allows more light, ideal for low-light conditions.
            - A narrow aperture (higher f-number) increases the depth of field, keeping more of the image in focus.

            **Common Use Cases**:
            - **Portrait Photography**: A wide aperture (e.g., f/1.8) for shallow depth of field and subject isolation.
            - **Landscape Photography**: A narrow aperture (e.g., f/16) for sharp focus throughout the frame.

            **Popular Aperture Settings**:
            - f/1.8 for blurred backgrounds in portraits
            - f/8 to f/16 for maximum sharpness in landscapes
            """
            self.references = """
            - "Aperture Explained" on Photography 101
            - "How Aperture Affects Depth of Field"
            """
        default:
            self.notes = "No notes available for this topic."
            self.references = "No references available."
        }
    }
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                Text(topic)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.white) // Topic text color set to white
                
                Text("**Notes**")
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(.white) // Notes heading in white
                
                Text(notes)
                    .font(.body)
                    .foregroundColor(.white) // Notes text in white
                
                Text("**References**")
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(.white) // References heading in white
                
                Text(references)
                    .font(.body)
                    .foregroundColor(.white) // References text in white
            }
            .padding()
        }
        .navigationTitle(topic)
        .background(Color.black) // Set background to black in detail view
    }
}

struct LearnCameraView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            LearnCameraView()
                .previewDevice("iPhone 14")
                .environment(\.colorScheme, .light) // Light mode preview
            
            LearnCameraView()
                .previewDevice("iPhone 14")
                .environment(\.colorScheme, .dark) // Dark mode preview
        }
    }
}
