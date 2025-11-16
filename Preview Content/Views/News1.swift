import SwiftUI

struct NewsPageView: View {
    let newsTitle: String
    let newsImage: String
    let newsContent: String
    let newsLink: String
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                // Header with News Title
                Text(newsTitle)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(Color(red: 0.0, green: 0.2, blue: 0.4)) // Dark blue color
                    .padding(.top)
                    .multilineTextAlignment(.center)
                    .frame(maxWidth: .infinity)

                // News Image
                Image(newsImage) // Using dynamic image
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: .infinity, maxHeight: 300)
                    .cornerRadius(15)
                    .shadow(radius: 5)

                // News Content (Full Article)
                Text(newsContent)
                    .font(.body)
                    .foregroundColor(.secondary)
                    .padding(.horizontal)
                    .padding(.bottom, 10)

                // Link to Full Article with the new text "More News"
                Link("More News", destination: URL(string: newsLink)!)
                    .font(.headline)
                    .foregroundColor(.blue)
                    .padding(.bottom)

                Spacer()
            }
            .padding()
        }
        .background(Color.white.edgesIgnoringSafeArea(.all))
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct NewsPageView_Previews: PreviewProvider {
    static var previews: some View {
        NewsPageView(newsTitle: "New Photography Techniques Released!",
                     newsImage: "Camera", // Replace with a real image name
                     newsContent: """
                         The world of photography is evolving faster than ever, and 2024 brings new techniques that can elevate your photography game. From AI-assisted photography to advanced lens technology, here’s what you need to know to stay ahead of the curve.

                         One of the most exciting developments is the rise of computational photography. With the use of powerful algorithms, new cameras can now simulate wide apertures in post-processing, allowing you to achieve a shallow depth of field without switching lenses. This is revolutionizing how portraits and low-light images are captured.

                         Additionally, smartphone cameras are integrating multi-frame processing to create high dynamic range (HDR) images, even in extremely challenging lighting conditions. The result is improved detail, vivid colors, and a broader tonal range in every shot.

                         Whether you’re a beginner or a professional, these innovations open new possibilities for creativity and precision. Stay updated on the latest trends and techniques in the world of photography!
                         """,
                     newsLink: "https://www.example.com/full-article") // Replace with your real link
    }
}
