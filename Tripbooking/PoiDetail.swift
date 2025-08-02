import Foundation
import SwiftUI // Image için

// Tarihi yerler, yemek veya eğlence yerleri gibi ilgi çekici noktaların detayları için model
struct PoiDetail: Identifiable {
    let id = UUID() // Her detay için benzersiz kimlik
    let name: String // Yerin adı (örn: Eski Taş Köprü, Dağ Evi Restoranı)
    let imageName: String // Yerin görseli için resim adı (Assets'e eklenmeli)
    let description: String // Yer hakkında kısa açıklama

    // Örnek init metodu
    init(name: String, imageName: String, description: String) {
        self.name = name
        self.imageName = imageName
        self.description = description
    }
}
