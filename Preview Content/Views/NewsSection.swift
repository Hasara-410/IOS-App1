import SwiftUI

struct NewsMenuView: View {
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 15) {
                    HStack {
                        Text("Photography News")
                            .font(.title)
                            .fontWeight(.bold)
                            .padding(.leading)
                        Spacer()
                    }
                    .padding(.top, 10)

                    // News Buttons Grid
                    LazyVGrid(columns: [
                        GridItem(.flexible()),
                        GridItem(.flexible())
                    ], spacing: 15) {
                        // Button 1
                        NavigationLink(destination: NewsPageView(
                            newsTitle: "New Photography Techniques Released!",
                            newsImage: "N1",
                            newsContent: """
                            The world of photography is evolving faster than ever, and 2024 brings new techniques that can elevate your photography game. From AI-assisted photography to advanced lens technology, here’s what you need to know to stay ahead of the curve.

                            One of the most exciting developments is the rise of computational photography. With the use of powerful algorithms, new cameras can now simulate wide apertures in post-processing, allowing you to achieve a shallow depth of field without switching lenses. This is revolutionizing how portraits and low-light images are captured.

                            Additionally, smartphone cameras are integrating multi-frame processing to create high dynamic range (HDR) images, even in extremely challenging lighting conditions. The result is improved detail, vivid colors, and a broader tonal range in every shot.

                            Whether you’re a beginner or a professional, these innovations open new possibilities for creativity and precision.
                            """,
                            newsLink: "https://www.example.com/photography-techniques"
                        )) {
                            NewsButton(newsText: "New Photography Techniques Released!", imageName: "N1")
                        }

                        // Button 2
                        NavigationLink(destination: NewsPageView(
                            newsTitle: "Top 10 Cameras for Beginners in 2024",
                            newsImage: "N2",
                            newsContent: """
                            If you’re a beginner in photography, choosing the right camera can be overwhelming. In 2024, there are plenty of options available that offer ease of use, great features, and exceptional image quality without breaking the bank. Here are the top 10 cameras for beginners that will help you step up your photography game.

                            Whether you're looking for a budget DSLR, a powerful mirrorless option, or a compact point-and-shoot, these cameras provide the perfect balance of performance and affordability.

                            From the Canon EOS Rebel T8i to the Sony Alpha a6000, each of these options is perfect for photographers looking to learn the basics and grow into their craft.
                            """,
                            newsLink: "https://www.example.com/top-cameras-2024"
                        )) {
                            NewsButton(newsText: "Top 10 Cameras for Beginners in 2024", imageName: "N2")
                        }

                        // Button 3
                        NavigationLink(destination: NewsPageView(
                            newsTitle: "Lighting Basics: Improve Your Shots",
                            newsImage: "N3",
                            newsContent: """
                            Lighting is one of the most crucial elements in photography, and understanding how to use light to your advantage can significantly improve your photos. Whether you're shooting portraits, landscapes, or products, lighting can make or break your shot.

                            In this article, we’ll explore the different types of lighting setups, such as key light, fill light, and backlighting, and provide practical tips on how to use natural and artificial lighting to enhance your images.

                            Mastering lighting is essential for photographers at all levels. Get the tips and techniques that will take your shots to the next level.
                            """,
                            newsLink: "https://www.example.com/lighting-basics"
                        )) {
                            NewsButton(newsText: "Lighting Basics: Improve Your Shots", imageName: "N3")
                        }

                        // Button 4
                        NavigationLink(destination: NewsPageView(
                            newsTitle: "Upcoming Photography Workshops",
                            newsImage: "N4",
                            newsContent: """
                            Whether you’re an amateur or a seasoned professional, attending a photography workshop can significantly enhance your skills. If you’re looking for expert advice and hands-on experience, check out these upcoming workshops in 2024!

                            These workshops will cover a wide range of topics, from studio lighting and portrait photography to landscape photography and photo editing. Whether you’re looking to learn new techniques or just want to refine your existing skills, there’s a workshop for you.

                            Don't miss the chance to meet other photographers and grow your creative network!
                            """,
                            newsLink: "https://www.example.com/photography-workshops"
                        )) {
                            NewsButton(newsText: "Upcoming Photography Workshops", imageName: "N4")
                        }

                        // Button 5
                        NavigationLink(destination: NewsPageView(
                            newsTitle: "Lens Buying Guide for Professionals",
                            newsImage: "N5",
                            newsContent: """
                            Choosing the right lens is critical for professional photographers. In this lens buying guide, we’ll explore the different types of lenses and what they offer. We’ll cover prime lenses, zoom lenses, wide-angle, telephoto, and macro lenses. We’ll also discuss factors to consider when purchasing a lens, such as focal length, aperture, and compatibility with your camera system.

                            For professional photographers, understanding the nuances of lenses is key to mastering your craft and achieving the best results possible.
                            """,
                            newsLink: "https://www.example.com/lens-buying-guide"
                        )) {
                            NewsButton(newsText: "Lens Buying Guide for Professionals", imageName: "N5")
                        }
                    }
                    .padding(.horizontal)

                    Spacer()
                }
            }
            .navigationTitle("News Menu")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct NewsButton: View {
    let newsText: String
    let imageName: String
    
    var body: some View {
        VStack {
            Image(imageName)
                .resizable()
                .scaledToFill()
                .frame(width: 150, height: 100)
                .clipped()
                .cornerRadius(10)
            
            Text(newsText)
                .font(.headline)
                .foregroundColor(.black)
                .multilineTextAlignment(.center)
                .lineLimit(2)
                .padding(.top, 5)
        }
        .frame(width: 150, height: 150)
        .background(Color.white)
        .cornerRadius(15)
        .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 5)
        .padding(5)
    }
}

struct NewsView: View {
    let newsTitle: String
    let newsImage: String
    let newsContent: String
    let newsLink: String
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                // News Title
                Text(newsTitle)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)
                    .padding(.top)
                
                // News Image
                Image(newsImage)
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: .infinity, maxHeight: 300)
                    .cornerRadius(15)
                    .shadow(radius: 5)
                
                // News Content
                Text(newsContent)
                    .font(.body)
                    .padding(.horizontal)
                
                // News Link
                Link("Read More", destination: URL(string: newsLink)!)
                    .font(.headline)
                    .foregroundColor(.blue)
                    .padding(.bottom)
            }
            .padding()
        }
    }
}

struct NewsMenuView_Previews: PreviewProvider {
    static var previews: some View {
        NewsMenuView()
    }
}
