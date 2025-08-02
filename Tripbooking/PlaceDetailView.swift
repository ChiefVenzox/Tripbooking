import SwiftUI
import MapKit

struct PlaceDetailView: View {
    let place: Place

    @State private var region: MKCoordinateRegion
    
    init(place: Place) {
        self.place = place
        _region = State(initialValue: MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: place.latitude, longitude: place.longitude),
            span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
        ))
    }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                // Yer görseli
                Image(place.imageName)
                    .resizable()
                    .scaledToFill()
                    .frame(height: 200)
                    .clipped()
                    .cornerRadius(30)
                    .padding(.horizontal, 20)
                    .shadow(color: Color.black.opacity(0.25), radius: 10, x: 0, y: 5)

                // Yer adı ve konumu
                VStack(alignment: .leading, spacing: 5) {
                    Text(place.name)
                        .font(.largeTitle)
                        .fontWeight(.heavy)
                        .foregroundColor(.primary)

                    Text(place.location)
                        .font(.title2)
                        .fontWeight(.medium)
                        .foregroundColor(.secondary)
                }
                .padding(.horizontal, 20)
                .padding(.top, 5)

                // Açıklama
                Text(place.description)
                    .font(.body)
                    .lineSpacing(5)
                    .foregroundColor(.gray)
                    .padding(.horizontal, 20)
                    .padding(.top, 10)

                // Derecelendirme ve Mesafe Bilgisi
                HStack {
                    HStack(spacing: 5) {
                        Image(systemName: "star.fill")
                            .foregroundColor(.yellow)
                        Text("\(place.rating, specifier: "%.1f")")
                            .font(.headline)
                            .fontWeight(.semibold)
                        Text("(\(place.reviewCount) yorum)")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                    Spacer()
                    HStack(spacing: 5) {
                        Image(systemName: "car.fill")
                            .foregroundColor(.blue)
                        Text(place.distance)
                            .font(.headline)
                            .fontWeight(.semibold)
                    }
                }
                .padding(.horizontal)
                .padding(.vertical, 12)
                .background(Color(.systemGray6).opacity(0.5))
                .cornerRadius(15)
                .padding(.horizontal, 20)

                // Harita Bölümü
                SectionHeader(title: "Konum")
                    .padding(.top, 10)

                Map(coordinateRegion: $region, annotationItems: [place]) { place in
                    MapMarker(coordinate: CLLocationCoordinate2D(latitude: place.latitude, longitude: place.longitude), tint: .red)
                }
                .frame(height: 200)
                .cornerRadius(20)
                .padding(.horizontal, 20)
                .shadow(color: Color.black.opacity(0.15), radius: 8, x: 0, y: 4)

                // Tarihi Yerler Bölümü
                SectionHeader(title: "Tarihi Yerler")
                VStack(alignment: .leading, spacing: 8) {
                    ForEach(place.historicalPlaces) { poiItem in
                        NavigationLink(destination: PoiDetailView(poi: poiItem)) {
                            DetailListItem(text: poiItem.name, icon: "building.columns.fill")
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                }
                .padding(.horizontal, 20)

                // Yemek ve Eğlence Yerleri Bölümü
                SectionHeader(title: "Yemek ve Eğlence")
                VStack(alignment: .leading, spacing: 8) {
                    ForEach(place.foodAndEntertainment) { poiItem in
                        NavigationLink(destination: PoiDetailView(poi: poiItem)) {
                            DetailListItem(text: poiItem.name, icon: "fork.knife.circle.fill")
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                }
                .padding(.horizontal, 20)

                Spacer()

                // Rezervasyon Yap Butonu kaldırıldı (önceki talimatlara göre)
            }
            .navigationTitle("")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    // Varsayılan geri butonunu kullanıyoruz
                }
            }
        }
    }
}

// DetailListItem struct'ı PlaceDetailView içinde kalır.
struct DetailListItem: View {
    let text: String
    let icon: String

    var body: some View {
        HStack {
            Image(systemName: icon)
                .foregroundColor(.orange)
                .font(.title3)
            Text(text)
                .font(.body)
                .foregroundColor(.primary)
            Spacer()
        }
        .padding(.vertical, 8)
        .padding(.horizontal, 10)
        .background(Color(.systemGray6).opacity(0.3))
        .cornerRadius(10)
    }
}

struct PlaceDetailView_Previews: PreviewProvider {
    static var previews: some View {
        PlaceDetailView(place: Place.samplePlaces[0])
    }
}
