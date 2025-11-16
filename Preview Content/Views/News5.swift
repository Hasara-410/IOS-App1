import SwiftUI
import MapKit

struct NewsPageView4: View {
    let newsTitle: String
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

                // Map of Colombo, Sri Lanka
                Map(coordinateRegion: .constant(MKCoordinateRegion(
                    center: CLLocationCoordinate2D(latitude: 6.9271, longitude: 79.8612), // Colombo's coordinates
                    span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
                )))
                .frame(height: 300)
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

struct NewsPageView4_Previews: PreviewProvider {
    static var previews: some View {
        NewsPageView4(newsTitle: "Lens Buying Guide for Professionals",
                     newsContent: """
                         Choosing the right lens is critical for professional photographers. In this lens buying guide, we’ll explore the different types of lenses and what they offer. We’ll cover prime lenses, zoom lenses, wide-angle, telephoto, and macro lenses. We’ll also discuss factors to consider when purchasing a lens, such as focal length, aperture, and compatibility with your camera system.

                         For professional photographers, understanding the nuances of lenses is key to mastering your craft and achieving the best results possible.
                         """,
                     newsLink: "https://www.example.com/lens-buying-guide-professionals")
    }
}
