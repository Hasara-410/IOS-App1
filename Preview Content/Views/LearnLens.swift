import SwiftUI

struct LearnLensesView: View {
    @Environment(\.colorScheme) var colorScheme // Get the current color scheme (dark/light)
    
    // List of lens-related topics with icons
    let topics = [
        ("Prime Lenses", "star.circle.fill"),
        ("Zoom Lenses", "magnifyingglass.circle.fill"),
        ("Wide-Angle Lenses", "rectangle.3.offgrid.fill"),
        ("Telephoto Lenses", "camera.fill"),
        ("Macro Lenses", "camera.macro"),
        ("Fisheye Lenses", "circle.fill"),
        ("Standard Lenses", "lens.fill")
    ]
    
    var body: some View {
        NavigationView {
            VStack {
                // Header with dynamic text color based on dark/light mode
                HStack {
                    Text("Learn Lenses")
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(colorScheme == .dark ? .white : .black)
                        .padding(.leading)

                    Spacer()
                }
                .padding(.vertical)
                
                // List to display lens types in a visually appealing way
                ScrollView {
                    LazyVStack(spacing: 10) { // Reduced spacing between topics
                        ForEach(topics, id: \.0) { topic in
                            NavigationLink(destination: LensDetailView(topic: topic.0)) {
                                // Card-style view for each lens with icons
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

                                    // Add custom image to the right side of the lens name
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
            .navigationTitle("Lenses")
        }
    }
}

struct LensDetailView: View {
    let topic: String

    // Sample notes and references for each lens topic
    let notes: String
    let references: String

    init(topic: String) {
        self.topic = topic
        // Add detailed notes for each lens type
        switch topic {
        case "Prime Lenses":
            self.notes = """
            Prime lenses are fixed focal length lenses that offer exceptional image quality. They are known for their sharpness, lightweight design, and wide apertures, which make them great for low-light conditions and creating beautiful background blur (bokeh).

            **Advantages**:
            - Superior optical performance with high image sharpness
            - Larger aperture sizes (e.g., f/1.8, f/1.4), great for achieving shallow depth of field
            - Lightweight and compact, making them ideal for street and portrait photography

            **Common Use Cases**:
            - **Portrait Photography**: Their wide aperture allows for beautiful background separation and subject isolation.
            - **Low-Light Photography**: The large aperture allows more light, making it easier to shoot in dark environments.
            - **Street Photography**: Compact and unobtrusive, making them ideal for candid shots.

            **Popular Models**:
            - Canon EF 50mm f/1.8 STM
            - Nikon AF-S 50mm f/1.8G
            """
            self.references = """
            - "Prime Lens Overview" on Photography Blog
            - "The Best Prime Lenses for Portraits"
            """
        case "Zoom Lenses":
            self.notes = """
            Zoom lenses offer versatility by allowing you to change focal lengths without changing the lens. They are particularly useful in situations where you need to quickly adjust your composition, such as during travel, wildlife, or sports photography.

            **Advantages**:
            - Flexibility to change focal length, ideal for quickly adapting to different scenes
            - Convenient for capturing a wide variety of subjects
            - Often more affordable than purchasing multiple prime lenses for different focal lengths

            **Common Use Cases**:
            - **Travel Photography**: One lens to cover a wide range of subjects, perfect for varied environments and situations.
            - **Sports and Wildlife Photography**: Ability to zoom in on distant subjects without moving.
            - **Event Photography**: Great for capturing a variety of moments and angles in dynamic situations.

            **Popular Models**:
            - Canon EF 24-70mm f/2.8L II USM
            - Nikon 70-200mm f/2.8E FL ED VR
            """
            self.references = """
            - "Why Zoom Lenses Are Great for Travel Photography"
            - "Zoom Lens Techniques"
            """
        case "Wide-Angle Lenses":
            self.notes = """
            Wide-angle lenses offer a larger field of view, which is perfect for capturing expansive landscapes or large architectural subjects. They allow you to fit more into the frame and are often used to create dramatic perspectives.

            **Advantages**:
            - Captures more of the scene, ideal for vast landscapes or tight spaces
            - Great for emphasizing foreground objects in contrast to distant backgrounds
            - Can create a sense of depth and drama through perspective distortion

            **Common Use Cases**:
            - **Landscape Photography**: Wide field of view allows you to capture sweeping views and expansive horizons.
            - **Architecture**: Perfect for photographing large buildings or interiors, allowing you to fit more in the frame.
            - **Creative Shots**: Ideal for capturing wide, dramatic shots where perspective is emphasized.

            **Popular Models**:
            - Canon EF 16-35mm f/4L IS USM
            - Sony FE 12-24mm f/4 G
            """
            self.references = """
            - "Exploring Wide-Angle Lenses in Landscape Photography"
            - "Wide-Angle Lens Tips for Beginners"
            """
        case "Telephoto Lenses":
            self.notes = """
            Telephoto lenses allow you to photograph distant subjects with incredible detail. These lenses are great for sports, wildlife, and portrait photography due to their ability to compress space and isolate subjects from their backgrounds.

            **Advantages**:
            - Captures distant subjects without needing to physically get closer
            - Ideal for isolating subjects and creating a shallow depth of field
            - Compressed perspective that brings distant objects closer together

            **Common Use Cases**:
            - **Wildlife Photography**: Great for photographing animals from a distance without disturbing them.
            - **Sports Photography**: Ideal for shooting athletes in motion from a distance, especially in large stadiums.
            - **Portrait Photography**: Offers a flattering perspective and excellent background separation.

            **Popular Models**:
            - Nikon 70-200mm f/2.8E FL ED VR
            - Canon RF 100-500mm f/4.5-7.1L IS USM
            """
            self.references = """
            - "Best Telephoto Lenses for Wildlife Photography"
            - "Mastering Telephoto Lenses for Sports Photography"
            """
        case "Macro Lenses":
            self.notes = """
            Macro lenses are specialized for close-up photography, offering extreme magnification (typically 1:1 ratio). They are perfect for capturing intricate details of small subjects, such as insects, flowers, or textures.

            **Advantages**:
            - True 1:1 magnification allows you to capture subjects in fine detail
            - Short focusing distances allow for extreme close-ups
            - Sharpness and clarity at close ranges, making them perfect for detail-oriented photography

            **Common Use Cases**:
            - **Insect Photography**: Perfect for capturing detailed images of small insects and bugs.
            - **Flower and Nature Photography**: Allows you to capture the fine details of plants, flowers, and textures.
            - **Product Photography**: Ideal for photographing small objects with precision, such as jewelry or other fine items.

            **Popular Models**:
            - Canon EF 100mm f/2.8L Macro IS USM
            - Nikon 105mm f/2.8G IF-ED VR Micro
            """
            self.references = """
            - "Macro Lens Photography Tips"
            - "The Best Macro Lenses for Close-Up Photography"
            """
        case "Fisheye Lenses":
            self.notes = """
            Fisheye lenses provide an extremely wide field of view, often 180° or more, and create a distinctive spherical distortion. They are often used for creative, experimental photography and in niche applications like virtual tours.

            **Advantages**:
            - Extreme wide field of view, typically 180° or more
            - Creates a spherical, distorted image that can be used creatively
            - Unique look that is ideal for artistic and experimental photography

            **Common Use Cases**:
            - **Creative Photography**: Often used to create surreal, artistic images with dramatic distortion.
            - **Interior Photography**: Useful for capturing large indoor spaces with a single shot.
            - **Action Sports Photography**: Often used in extreme sports like skateboarding, surfing, or diving to create unique perspectives.

            **Popular Models**:
            - Canon EF 8-15mm f/4L Fisheye USM
            - Sigma 15mm f/2.8 EX DG Fisheye
            """
            self.references = """
            - "Fisheye Lenses in Action Sports Photography"
            - "Mastering the Fisheye Lens"
            """
        case "Standard Lenses":
            self.notes = """
            Standard lenses are versatile, offering a field of view similar to the human eye. They are commonly used for general-purpose photography, offering a good balance of performance and size.

            **Advantages**:
            - Versatile focal length, great for everyday shooting
            - Compact and lightweight, easy to carry around
            - Natural perspective with minimal distortion

            **Common Use Cases**:
            - **Street Photography**: Perfect for capturing everyday life in a natural, candid way.
            - **Portrait Photography**: Provides a natural perspective that is flattering to the human face.
            - **General Purpose**: Ideal for various types of photography, from travel to documentary.

            **Popular Models**:
            - Canon EF 50mm f/1.8 STM
            - Nikon AF-S 50mm f/1.8G
            """
            self.references = """
            - "Best Standard Lenses for Beginners"
            - "Street Photography with a 50mm Lens"
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
                
                Text("**Notes**")
                    .font(.title2)
                    .fontWeight(.bold)
                
                Text(notes)
                    .font(.body)
                
                Text("**References**")
                    .font(.title2)
                    .fontWeight(.bold)
                
                Text(references)
                    .font(.body)
            }
            .padding()
        }
        .navigationTitle(topic)
    }
}

struct LearnLensesView_Previews: PreviewProvider {
    static var previews: some View {
        LearnLensesView()
    }
}
