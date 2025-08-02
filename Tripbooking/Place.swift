import Foundation
import SwiftUI
import CoreLocation

// Gezi yerleri için veri modeli
struct Place: Identifiable {
    let id: UUID

    let name: String
    let location: String
    let imageName: String
    let description: String
    let historicalPlaces: [PoiDetail] // String yerine PoiDetail dizisi
    let foodAndEntertainment: [PoiDetail] // String yerine PoiDetail dizisi
    let rating: Double
    let reviewCount: Int
    let distance: String
    let latitude: Double
    let longitude: Double

    init(id: UUID = UUID(), name: String, location: String, imageName: String, description: String, historicalPlaces: [PoiDetail], foodAndEntertainment: [PoiDetail], rating: Double, reviewCount: Int, distance: String, latitude: Double, longitude: Double) {
        self.id = id
        self.name = name
        self.location = location
        self.imageName = imageName
        self.description = description
        self.historicalPlaces = historicalPlaces
        self.foodAndEntertainment = foodAndEntertainment
        self.rating = rating
        self.reviewCount = reviewCount
        self.distance = distance
        self.latitude = latitude
        self.longitude = longitude
    }
}

// Örnek gezi yerleri verisi (PoiDetail nesneleri ile güncellendi)
extension Place {
    static let samplePlaces: [Place] = [
        Place(
            name: "Milano Dağları",
            location: "San Francisco, California",
            imageName: "milano_mountains",
            description: "Milano Dağları, doğa severler ve macera arayanlar için muhteşem bir kaçış noktasıdır. Yemyeşil vadileri, kristal berraklığındaki gölleri ve zorlu yürüyüş parkurlarıyla unutulmaz bir deneyim sunar.",
            historicalPlaces: [
                PoiDetail(name: "Eski Taş Köprü", imageName: "old_stone_bridge", description: "Yüzyıllar öncesine dayanan bu köprü, bölgenin tarihi dokusunu yansıtır ve muhteşem manzaralar sunar."),
                PoiDetail(name: "Dağ Manastırı", imageName: "mountain_monastery", description: "Sarp kayalıkların arasına gizlenmiş antik manastır, huzurlu atmosferi ve eşsiz mimarisiyle ziyaretçilerini büyüler."),
                PoiDetail(name: "Antik Kalıntılar", imageName: "ancient_ruins", description: "Bölgedeki eski medeniyetlere ait kalıntılar, geçmişin izlerini sürmek isteyenler için ilgi çekici bir duraktır.")
            ],
            foodAndEntertainment: [
                PoiDetail(name: "Dağ Evi Restoranı", imageName: "mountain_restaurant", description: "Yerel lezzetleri ve dağ manzarası eşliğinde unutulmaz bir yemek deneyimi sunar."),
                PoiDetail(name: "Panoramik Kafe", imageName: "panoramic_cafe", description: "Nefes kesen manzaraya sahip bu kafe, kahve keyfi ve hafif atıştırmalıklar için idealdir."),
                PoiDetail(name: "Yerel El Sanatları Pazarı", imageName: "crafts_market", description: "El yapımı ürünler ve yerel hediyelik eşyalar bulabileceğiniz canlı bir pazar.")
            ],
            rating: 4.8,
            reviewCount: 245,
            distance: "20 mil (araba ile)",
            latitude: 37.7749,
            longitude: -122.4194
        ),
        Place(
            name: "Milano Park",
            location: "Milano, İtalya",
            imageName: "milano_park",
            description: "Milano Park, şehrin kalbinde huzurlu bir vaha sunar. Geniş yeşil alanları, heykelleri ve göletiyle dinlenmek ve piknik yapmak için idealdir.",
            historicalPlaces: [
                PoiDetail(name: "Sforza Kalesi", imageName: "sforza_castle", description: "Milano'nun tarihi kalbi, müzeleri ve sanat koleksiyonlarıyla dolu büyük bir kale."),
                PoiDetail(name: "Duomo Katedrali", imageName: "duomo_cathedral", description: "Gotik mimarinin başyapıtı, Milano'nun en ikonik simgelerinden biri."),
                PoiDetail(name: "Santa Maria delle Grazie", imageName: "santa_maria_grazie", description: "Leonardo da Vinci'nin Son Akşam Yemeği tablosuna ev sahipliği yapan kilise.")
            ],
            foodAndEntertainment: [
                PoiDetail(name: "Park Kafe", imageName: "park_cafe", description: "Parkın içinde yer alan şirin kafe, rahat bir mola için mükemmel."),
                PoiDetail(name: "Gelateria", imageName: "gelateria", description: "Geleneksel İtalyan dondurmasıyla serinleyin."),
                PoiDetail(name: "Canlı Müzik Alanı", imageName: "live_music_area", description: "Akşamları canlı müzik performanslarının yapıldığı popüler bir mekan.")
            ],
            rating: 4.5,
            reviewCount: 180,
            distance: "5 mil (yürüyerek)",
            latitude: 45.4642,
            longitude: 9.1900
        ),
        Place(
            name: "Venedik Kanalları",
            location: "Venedik, İtalya",
            imageName: "venice_canals",
            description: "Venedik'in büyüleyici kanalları ve tarihi binaları, romantik bir kaçamak için mükemmeldir. Gondol gezintileri ve dar sokaklarda kaybolmak unutulmaz anılar yaratır.",
            historicalPlaces: [
                PoiDetail(name: "San Marco Meydanı", imageName: "san_marco_square", description: "Venedik'in en ünlü meydanı, tarihi binalar ve güvercinlerle dolu."),
                PoiDetail(name: "Rialto Köprüsü", imageName: "rialto_bridge", description: "Büyük Kanal üzerindeki ikonik köprü, alışveriş ve manzara için ideal."),
                PoiDetail(name: "Dükler Sarayı", imageName: "doges_palace", description: "Venedik Cumhuriyeti'nin eski yönetim merkezi, muhteşem mimarisiyle dikkat çeker.")
            ],
            foodAndEntertainment: [
                PoiDetail(name: "Trattoria", imageName: "trattoria", description: "Geleneksel Venedik mutfağını deneyimleyebileceğiniz samimi restoran."),
                PoiDetail(name: "Gondol Gezintisi", imageName: "gondola_ride", description: "Venedik'in kanallarında romantik bir gondol gezintisi."),
                PoiDetail(name: "Maske Dükkanları", imageName: "mask_shops", description: "Venedik karnaval maskelerini ve el sanatlarını bulabileceğiniz dükkanlar.")
            ],
            rating: 4.9,
            reviewCount: 320,
            distance: "0 mil (yürüyerek)",
            latitude: 45.4408,
            longitude: 12.3155
        )
    ]
}
