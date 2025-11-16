import SwiftUI

struct NewsPageView1: View {
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

struct NewsPageView1_Previews: PreviewProvider {
    static var previews: some View {
        NewsPageView1(newsTitle: "Top 10 Cameras for Beginners in 2024",
                     newsImage: "N2",
                     newsContent: """
                         If you’re a beginner in photography, choosing the right camera can be overwhelming. In 2024, there are plenty of options available that offer ease of use, great features, and exceptional image quality without breaking the bank. Here are the top 10 cameras for beginners that will help you step up your photography game.

                         Whether you're looking for a budget DSLR, a powerful mirrorless option, or a compact point-and-shoot, these cameras provide the perfect balance of performance and affordability.

                         From the Canon EOS Rebel T8i to the Sony Alpha a6000, each of these options is perfect for photographers looking to learn the basics and grow into their craft.
                         """,
                     newsLink: "https://www.example.com/top-10-cameras-beginners-2024")
    }
}
