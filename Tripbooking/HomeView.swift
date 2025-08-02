import SwiftUI

struct HomeView: View {
    @EnvironmentObject var authManager: AuthManager
    
    // Önerilen geziler için örnek verileri doğrudan kullanıyoruz
    let recommendedPlaces = Place.samplePlaces

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    // Üst Kısım: Kullanıcı Adı ve Profil Fotoğrafı
                    HStack {
                        VStack(alignment: .leading) {
                            Text("Merhaba \(authManager.username)!")
                                .font(.largeTitle)
                                .fontWeight(.bold)
                                .foregroundColor(.primary)
                            Text("Keşfedilecek Yerler")
                                .font(.title2)
                                .fontWeight(.semibold)
                                .foregroundColor(.secondary)
                        }
                        Spacer()
                        NavigationLink(destination: ProfileView().environmentObject(authManager)) {
                            if let imageData = authManager.profileImageData,
                               let uiImage = UIImage(data: imageData) {
                                Image(uiImage: uiImage)
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 50, height: 50)
                                    .clipShape(Circle())
                                    .overlay(Circle().stroke(Color.gray, lineWidth: 1))
                            } else {
                                Image(systemName: "person.circle.fill")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 50, height: 50)
                                    .foregroundColor(.gray)
                                    .clipShape(Circle())
                            }
                        }
                    }
                    .padding(.horizontal)
                    .padding(.top, 20)

                    // Arama Çubuğu (Örnek)
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.gray)
                        TextField("Bir şeyler aramaya başla...", text: .constant(""))
                            .padding(.vertical, 8)
                    }
                    .padding(.horizontal)
                    .background(Color(.systemGray6))
                    .cornerRadius(10)
                    .padding(.horizontal)
                    .padding(.top, 10)

                    // Keşfedilecek Yerler Başlığı
                    Text("Keşfedilecek Yerler")
                        .font(.title2)
                        .fontWeight(.semibold)
                        .padding(.horizontal)
                        .padding(.top, 20)

                    // Önerilen gezileri yatay olarak kaydırılabilir bir görünümde göster
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 15) {
                            ForEach(recommendedPlaces) { place in
                                NavigationLink(destination: PlaceDetailView(place: place)) {
                                    PlaceCard(place: place)
                                }
                                .buttonStyle(PlainButtonStyle())
                            }
                        }
                        .padding(.horizontal)
                    }

                    // "İnsanların Beğendikleri" bölümü
                    Text("İnsanların Beğendikleri")
                        .font(.title2)
                        .fontWeight(.semibold)
                        .padding(.horizontal)
                        .padding(.top, 20)

                    VStack(alignment: .leading, spacing: 15) {
                        ForEach(recommendedPlaces.shuffled().prefix(2)) { place in
                            // Her bir öğeyi NavigationLink ile sarıyoruz
                            NavigationLink(destination: PlaceDetailView(place: place)) {
                                HStack(alignment: .top) {
                                    Image(place.imageName)
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: 100, height: 100)
                                        .cornerRadius(15)
                                        .clipped()

                                    VStack(alignment: .leading, spacing: 5) {
                                        Text(place.name)
                                            .font(.headline)
                                            .fontWeight(.bold)
                                        Text(place.location)
                                            .font(.subheadline)
                                            .foregroundColor(.gray)
                                        HStack {
                                            Image(systemName: "star.fill")
                                                .foregroundColor(.yellow)
                                                .font(.caption)
                                            Text("\(place.rating, specifier: "%.1f") (\(place.reviewCount) yorum)")
                                                .font(.caption)
                                                .foregroundColor(.gray)
                                        }
                                    }
                                    Spacer()
                                    Image(systemName: "heart.fill")
                                        .foregroundColor(.red)
                                        .font(.title3)
                                }
                                .padding()
                                .background(Color.white)
                                .cornerRadius(15)
                                .shadow(color: Color.black.opacity(0.1), radius: 8, x: 0, y: 4)
                            }
                            .buttonStyle(PlainButtonStyle()) // Linkin varsayılan buton stilini kaldırır
                        }
                    }
                    .padding(.horizontal)

                    Spacer()
                }
            }
            .navigationTitle("")
            .navigationBarHidden(true)
        }
    }
}

// PlaceCard yapısı HomeView içinde kalır.
struct PlaceCard: View {
    let place: Place

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Image(place.imageName)
                .resizable()
                .scaledToFill()
                .frame(width: 250, height: 180)
                .cornerRadius(18)
                .clipped()

            Text(place.name)
                .font(.title2)
                .fontWeight(.bold)
                .foregroundColor(.primary)
                .padding(.leading, 5)

            Text(place.location)
                .font(.subheadline)
                .foregroundColor(.secondary)
                .padding(.leading, 5)

            HStack {
                Image(systemName: "star.fill")
                    .foregroundColor(.yellow)
                Text("\(place.rating, specifier: "%.1f")")
                    .font(.caption)
                    .fontWeight(.semibold)
                Text("(\(place.reviewCount) yorum)")
                    .font(.caption)
                    .foregroundColor(.gray)
            }
            .padding(.leading, 5)
        }
        .padding(.bottom, 15)
        .background(Color.white)
        .cornerRadius(20)
        .shadow(color: Color.black.opacity(0.15), radius: 10, x: 0, y: 5)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .environmentObject(AuthManager())
    }
}
