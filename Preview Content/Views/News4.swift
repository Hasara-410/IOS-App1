import SwiftUI

struct NewsPageView3: View {
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

                // News Content (Short Introduction)
                Text(newsContent)
                    .font(.body)
                    .foregroundColor(.secondary)
                    .lineLimit(nil)
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

struct NewsPageView3_Previews: PreviewProvider {
    static var previews: some View {
        NewsPageView3(newsTitle: "Upcoming Photography Workshops",
                     newsImage: "N4",
                     newsContent: """
                         Whether you’re an amateur or a seasoned professional, attending a photography workshop can significantly enhance your skills. If you’re looking for expert advice and hands-on experience, check out these upcoming workshops in 2024!

                         These workshops will cover a wide range of topics, from studio lighting and portrait photography to landscape photography and photo editing. Whether you’re looking to learn new techniques or just want to refine your existing skills, there’s a workshop for you.

                         Don't miss the chance to meet other photographers and grow your creative network!
                         """,
                     newsLink: "https://www.example.com/upcoming-photography-workshops")
    }
}
