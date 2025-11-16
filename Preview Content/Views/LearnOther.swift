import SwiftUI

struct LearnOtherView: View {
    @Environment(\.colorScheme) var colorScheme // Get the current color scheme (dark/light)
    
    // List of rules/topics with icons
    let topics = [
        ("Rule of Thirds", "square.grid.3x3.fill"),
        ("Leading Lines", "line.3.horizontal.decrease.circle.fill"),
        ("Framing", "rectangle.portrait.on.rectangle.portrait"),
        ("Depth of Field", "circle.circle"),
        ("Golden Hour", "sun.and.horizon.fill"),
        ("Rule of Odds", "circle.grid.3x3.fill"),
        ("Negative Space", "rectangle.fill.on.rectangle.angled.fill")
    ]
    
    var body: some View {
        NavigationView {
            VStack {
                // Header
                HStack {
                    Text("Learn Other Rules")
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(colorScheme == .dark ? .white : .black)
                        .padding(.leading)

                    Spacer()
                }
                .padding(.vertical)
                
                // List of rules/topics
                ScrollView {
                    LazyVStack(spacing: 10) {
                        ForEach(topics, id: \.0) { topic in
                            NavigationLink(destination: RuleDetailView(topic: topic.0)) {
                                // Card-style for each rule
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
                                }
                                .background(
                                    LinearGradient(gradient: Gradient(colors: [Color.purple.opacity(0.7), Color.blue.opacity(0.8)]), startPoint: .topLeading, endPoint: .bottomTrailing)
                                )
                                .cornerRadius(20)
                                .shadow(radius: 10)
                                .padding([.top, .horizontal])
                            }
                        }
                    }
                }
                .padding(.top, 20)
                
                Spacer()
            }
            .background(colorScheme == .dark ? Color.black.edgesIgnoringSafeArea(.all) : Color.white.edgesIgnoringSafeArea(.all))
            .navigationTitle("Rules")
        }
    }
}

struct RuleDetailView: View {
    let topic: String

    let notes: String

    init(topic: String) {
        self.topic = topic
        switch topic {
        case "Rule of Thirds":
            self.notes = """
            **Rule of Thirds**:
            - Imagine dividing your frame into a 3x3 grid.
            - Place the subject at one of the four intersections or along the lines of the grid.
            **Why It Works**:
            - Creates a balanced and dynamic composition by avoiding the center.
            - Helps guide the viewer’s eye naturally through the image.
            **Practical Examples**:
            - Position a person’s eyes along the upper grid line in portraits.
            - Place the horizon on either the top or bottom third of the frame in landscapes.
            """
        case "Leading Lines":
            self.notes = """
            **Leading Lines**:
            - Use natural or man-made lines to draw the viewer’s attention toward the subject.
            **Why It Works**:
            - Directs focus and creates a sense of depth.
            - Adds dynamism to the frame by guiding movement through the image.
            **Examples**:
            - Roads or pathways leading to a distant mountain.
            - Lines created by shadows or architecture drawing attention to the center of the frame.
            """
        case "Framing":
            self.notes = """
            **Framing**:
            - Use elements in the environment, such as windows, doorways, arches, or trees, to create a "frame" around the subject.
            **Why It Works**:
            - Adds depth and layers to the image.
            - Focuses attention on the subject by isolating it from distractions.
            **Examples**:
            - A person standing inside a window frame or arch.
            - Tree branches forming a natural border around a subject.
            """
        case "Depth of Field":
            self.notes = """
            **Depth of Field**:
            - Refers to the range of distance in a scene that appears sharp.
            - **Shallow Depth**: Achieved with wide apertures (e.g., f/1.8), blurring the background to highlight the subject.
            - **Deep Depth**: Achieved with narrow apertures (e.g., f/16), keeping the entire scene in focus.
            **Why It Works**:
            - Helps to isolate the subject or emphasize details in the entire scene.
            **Examples**:
            - A portrait with a beautifully blurred background.
            - A landscape where both foreground and background are sharp.
            """
        case "Golden Hour":
            self.notes = """
            **Golden Hour**:
            - Refers to the hour after sunrise and before sunset when the light is soft, warm, and directional.
            **Why It Works**:
            - Produces flattering skin tones and natural highlights.
            - Long shadows add depth and dimension to the image.
            **Examples**:
            - Portraits with a glowing backlight.
            - Landscapes bathed in warm light with soft shadows.
            """
        case "Rule of Odds":
            self.notes = """
            **Rule of Odds**:
            - Suggests that images are more visually appealing when they include an odd number of elements (e.g., 3, 5, 7).
            **Why It Works**:
            - Creates a natural sense of balance and harmony.
            **Examples**:
            - A bouquet with three flowers arranged naturally.
            - A composition with five birds flying in formation.
            """
        case "Negative Space":
            self.notes = """
            **Negative Space**:
            - Refers to the empty or blank space surrounding the subject.
            **Why It Works**:
            - Helps to draw attention to the subject.
            - Evokes feelings of simplicity, elegance, or isolation.
            **Examples**:
            - A lone tree against a vast, clear sky.
            - A person walking along a deserted beach with open space around them.
            """
        default:
            self.notes = "No information available for this topic."
        }
    }
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                Text(topic)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.top)

                Text(notes)
                    .font(.body)
                    .padding(.bottom)
            }
            .padding()
        }
        .navigationTitle(topic)
    }
}

struct LearnOtherView_Previews: PreviewProvider {
    static var previews: some View {
        LearnOtherView()
    }
}
