import SwiftUI
import MapKit

struct BuyEquipmentView: View {
    // Define coordinates for each location (latitude, longitude)
    let cameraStores: [Store] = [
        Store(name: "CameraLK", coordinate: CLLocationCoordinate2D(latitude: 6.9271, longitude: 79.8600)), // Example coordinates
        Store(name: "Photo Technica", coordinate: CLLocationCoordinate2D(latitude: 6.9277, longitude: 79.8592)),
        Store(name: "Wijaya Digital", coordinate: CLLocationCoordinate2D(latitude: 6.9273, longitude: 79.8605)),
        Store(name: "Amazon", coordinate: CLLocationCoordinate2D(latitude: 37.7749, longitude: -122.4194)), // Example for online store
        Store(name: "B&H Photo Video", coordinate: CLLocationCoordinate2D(latitude: 40.7128, longitude: -74.0060)),
        Store(name: "Adorama", coordinate: CLLocationCoordinate2D(latitude: 40.7130, longitude: -74.0065))
    ]
    
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 6.9271, longitude: 79.8600), // Default to the first store's location
        span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
    )

    var body: some View {
        VStack {
            Text("Places to Buy Camera Equipment")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.top, 20)

            // Map View showing stores
            Map(coordinateRegion: $region, annotationItems: cameraStores) { store in
                MapPin(coordinate: store.coordinate, tint: .blue) // Pin for each store
            }
            .frame(height: 300) // Set the height of the map

            // List of stores
            List {
                Section(header: Text("Local Shops").fontWeight(.semibold)) {
                    ForEach(cameraStores.filter { $0.coordinate.latitude != 37.7749 }, id: \.name) { store in
                        Text(store.name)
                    }
                }
                Section(header: Text("Online Stores").fontWeight(.semibold)) {
                    ForEach(cameraStores.filter { $0.coordinate.latitude == 37.7749 }, id: \.name) { store in
                        Text(store.name)
                    }
                }
            }
            .listStyle(InsetGroupedListStyle())

            Spacer()
        }
        .padding()
        .navigationTitle("Buy Equipment")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct Store: Identifiable {
    var id: String { name }
    let name: String
    let coordinate: CLLocationCoordinate2D
}

struct BuyEquipmentView_Previews: PreviewProvider {
    static var previews: some View {
        BuyEquipmentView()
    }
}
