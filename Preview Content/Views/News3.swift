import SwiftUI

struct NewsPageView2: View {
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

                // News Image
                Image(newsImage)
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: .infinity, maxHeight: 300)
                    .cornerRadius(15)
                    .shadow(radius: 5)

                // News Content (Full Article)
                Text(newsContent)
                    .font(.body)
                    .foregroundColor(.secondary)
                    .lineLimit(nil) // Ensures all content is displayed
                    .padding(.horizontal)
                    .padding(.bottom, 10)

                // Link to Full Article
                Link("Read Full Article", destination: URL(string: newsLink)!)
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

struct NewsPageView2_Previews: PreviewProvider {
    static var previews: some View {
        NewsPageView2(newsTitle: "Lighting Basics: Improve Your Shots",
                     newsImage: "N3", // Replace with a real image name
                     newsContent: """
                         Lighting is one of the most crucial elements in photography, and understanding how to use light to your advantage can significantly improve your photos. Whether you're shooting portraits, landscapes, or products, lighting can make or break your shot.

                         In this article, we’ll explore the different types of lighting setups, such as key light, fill light, and backlighting, and provide practical tips on how to use natural and artificial lighting to enhance your images.

                         Mastering lighting is essential for photographers at all levels. Get the tips and techniques that will take your shots to the next level.
                         """,
                     newsLink: "https://www.example.com/lighting-basics-improve-shots")
    }
}
