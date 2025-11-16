import SwiftUI

struct LearnLightsView: View {
    @Environment(\.colorScheme) var colorScheme // Get the current color scheme (dark/light)
    
    // List of light-related topics with icons (now with Key, Rim, etc.)
    let topics = [
        ("Key Light", "star.circle.fill"),
        ("Rim Light", "magnifyingglass.circle.fill"),
        ("Fill Light", "rectangle.3.offgrid.fill"),
        ("Back Light", "camera.fill"),
        ("Soft Light", "camera.macro"),
        ("Hard Light", "circle.fill"),
        ("Bounce Light", "lens.fill")
    ]
    
    var body: some View {
        NavigationView {
            VStack {
                // Header with dynamic text color based on dark/light mode
                HStack {
                    Text("Learn Lights")
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(colorScheme == .dark ? .white : .black)
                        .padding(.leading)

                    Spacer()
                }
                .padding(.vertical)
                
                // List to display light types in a visually appealing way
                ScrollView {
                    LazyVStack(spacing: 10) { // Reduced spacing between topics
                        ForEach(topics, id: \.0) { topic in
                            NavigationLink(destination: LightsDetailView(topic: topic.0)) {
                                // Card-style view for each light with icons
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

                                    // Add custom image to the right side of the light name
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
            .navigationTitle("Lights")
        }
    }
}

struct LightsDetailView: View {
    let topic: String

    // Sample notes and references for each light topic
    let notes: String
    let references: String

    init(topic: String) {
        self.topic = topic
        // Add detailed notes for each light type
        switch topic {
        case "Key Light":
            self.notes = """
            The Key Light is the primary light source used in lighting setups. It is typically the most intense light and defines the subject's shape, texture, and mood of the scene. In most setups, it is placed at a 45-degree angle from the subject to create depth through shadows.

            **Advantages**:
            - It is the most crucial light source for shaping the scene.
            - Adds dimension and highlights the subject’s features.

            **Common Use Cases**:
            - **Portrait Photography**: Key light helps illuminate the subject's face, usually placed slightly above the subject’s head.
            - **Cinematic Lighting**: In film, the key light helps in creating mood and atmosphere by adjusting its intensity and position.

            **Popular Models**:
            - Profoto B10 Plus
            - Aputure LS C300d II
            """
            self.references = """
            - "Mastering Key Light in Photography"
            - "Key Lighting Techniques in Cinematography"
            """
        case "Rim Light":
            self.notes = """
            The Rim Light is placed behind the subject to highlight its edges, creating a glowing outline around the subject. It separates the subject from the background, often used to enhance contrast and dimension.

            **Advantages**:
            - Creates dramatic separation from the background.
            - Adds a sense of depth and highlights the subject's outline.

            **Common Use Cases**:
            - **Portrait Photography**: Often used in dramatic or backlit portrait setups, giving a halo effect around the subject.
            - **Product Photography**: Separates the product from a background to make it pop visually.

            **Popular Models**:
            - Godox AD200 Pro
            - Elinchrom ELC Pro HD 500
            """
            self.references = """
            - "Rim Light in Portraits"
            - "Enhancing Portraits with Rim Lighting"
            """
        case "Fill Light":
            self.notes = """
            The Fill Light softens the shadows created by the Key Light, providing a more balanced and natural exposure. It is usually positioned on the opposite side of the key light to create even illumination.

            **Advantages**:
            - Helps reduce harsh shadows.
            - Balances the light across the scene for a more flattering look.

            **Common Use Cases**:
            - **Event Photography**: Used to soften lighting in dynamic environments.
            - **Interview Setups**: Ensures the subject is evenly lit, reducing unflattering shadows on the face.

            **Popular Models**:
            - Westcott FJ400
            - Profoto D2 1000Ws
            """
            self.references = """
            - "The Importance of Fill Lighting"
            - "Techniques for Effective Fill Lighting"
            """
        case "Back Light":
            self.notes = """
            The Back Light, or Hair Light, is placed behind the subject, typically above and facing downward. It creates a dramatic silhouette or highlights the hair and shoulders.

            **Advantages**:
            - Adds dimension by separating the subject from the background.
            - Creates a sense of depth and emphasizes features like hair and edges.

            **Common Use Cases**:
            - **Silhouette Photography**: Common in creative shots where the subject is completely in shadow.
            - **Cinematic Lighting**: Used to create a "halo" effect around the subject, especially in dramatic scenes.

            **Popular Models**:
            - Broncolor Siros L 800
            - Elinchrom Quadra Hybrid
            """
            self.references = """
            - "Using Back Lights in Cinematic Shots"
            - "Creative Backlighting Techniques"
            """
        case "Soft Light":
            self.notes = """
            Soft Light diffuses the light, creating a flattering, even light source with soft shadows. It is generally produced by using large light sources or diffusers.

            **Advantages**:
            - Reduces harsh shadows, creating smooth, even lighting.
            - Perfect for flattering portraits and beauty shots.

            **Common Use Cases**:
            - **Beauty Photography**: Used to enhance skin tones and soften imperfections.
            - **Portrait Photography**: Ideal for creating a gentle and flattering appearance.

            **Popular Models**:
            - Profoto Softboxes
            - Lastolite Softboxes
            """
            self.references = """
            - "Soft Lighting for Portraits"
            - "Using Soft Lights in Photography"
            """
        case "Hard Light":
            self.notes = """
            Hard Light creates sharp, defined shadows and high contrast, making it perfect for creating a strong visual impact. It is produced by small light sources or by focusing a larger light source to a smaller area.

            **Advantages**:
            - High contrast creates a dramatic, intense atmosphere.
            - Sharply defined shadows add depth and interest.

            **Common Use Cases**:
            - **Dramatic Film Lighting**: Often used in noir-style films or for intense, high-contrast shots.
            - **Fashion Photography**: Highlights textures and creates dynamic lighting effects.

            **Popular Models**:
            - ARRI SkyPanel S60
            - Aputure LS 300X
            """
            self.references = """
            - "Hard Lighting Techniques in Cinematography"
            - "Using Hard Light for Dramatic Effects"
            """
        case "Bounce Light":
            self.notes = """
            Bounce Light involves reflecting light off a surface (like a wall or reflector) to soften its intensity. This technique produces soft, even lighting without direct light sources.

            **Advantages**:
            - Provides soft, even illumination, especially in natural light environments.
            - Ideal for reducing harsh shadows and creating a more diffused light.

            **Common Use Cases**:
            - **Outdoor Photography**: Bouncing natural sunlight to create a soft, natural effect.
            - **Indoor Studio Photography**: Using white walls or reflectors to create a soft fill light.

            **Popular Models**:
            - Westcott 7-in-1 Reflector
            - Lastolite TriGrip Reflector
            """
            self.references = """
            - "Using Bounce Light for Cinematic Photography"
            - "Techniques for Effective Bounce Lighting"
            """
        default:
            self.notes = "No notes available for this topic."
            self.references = "No references available."
        }
    }
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 15) {
                Text(topic)
                    .font(.title)
                    .fontWeight(.bold)
                    .padding(.top)
                
                Text("**Notes**")
                    .font(.headline)
                    .padding(.top, 10)
                
                Text(notes)
                    .font(.body)
                    .padding(.bottom)
                
                Text("**References**")
                    .font(.headline)
                    .padding(.top, 10)
                
                Text(references)
                    .font(.body)
                    .padding(.bottom)
            }
            .padding()
        }
        .navigationBarTitle(topic, displayMode: .inline)
    }
}

struct LearnLightsView_Previews: PreviewProvider {
    static var previews: some View {
        LearnLightsView()
    }
}
