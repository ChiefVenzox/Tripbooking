import SwiftUI

struct PoiDetailView: View {
    let poi: PoiDetail // Gösterilecek PoiDetail nesnesi

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                // Yer görseli
                Image(poi.imageName)
                    .resizable()
                    .scaledToFill()
                    .frame(height: 250) // Yüksekliği ayarladık
                    .clipped()
                    .cornerRadius(20)
                    .padding(.horizontal, 20)
                    .shadow(color: Color.black.opacity(0.2), radius: 10, x: 0, y: 5)

                // Yerin adı
                Text(poi.name)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.primary)
                    .padding(.horizontal, 20)
                    .padding(.top, 5)

                // Açıklama
                Text(poi.description)
                    .font(.body)
                    .lineSpacing(5)
                    .foregroundColor(.gray)
                    .padding(.horizontal, 20)
                    .padding(.top, 10)

                Spacer()
            }
            .navigationTitle(poi.name) // Navigasyon başlığı olarak yer adını kullan
            .navigationBarTitleDisplayMode(.inline) // Başlığı küçük göster
        }
    }
}

struct PoiDetailView_Previews: PreviewProvider {
    static var previews: some View {
        // Önizleme için örnek bir PoiDetail nesnesi gönderiyoruz
        NavigationView { // Önizlemede navigasyon çubuğunu görmek için
            PoiDetailView(poi: PoiDetail(name: "Örnek Tarihi Yer", imageName: "milano_mountains", description: "Bu örnek tarihi yer hakkında detaylı bilgi."))
        }
    }
}
