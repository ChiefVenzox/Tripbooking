import Foundation

// Her bir onboarding slaytı için veri modeli
struct OnboardingSlide: Identifiable {
    let id = UUID() // Benzersiz kimlik
    let imageName: String // Görsel adı (Assets.xcassets'ten)
    let title: String // Başlık
    let description: String // Açıklama
}

// Örnek onboarding slayt verileri
extension OnboardingSlide {
    static let slides: [OnboardingSlide] = [
        OnboardingSlide(
            imageName: "onboarding_travel", // Bu görseli Assets.xcassets'e eklemeniz gerekecek
            title: "Yeni Yerler Keşfedin",
            description: "Dünyanın dört bir yanındaki en güzel destinasyonları keşfedin ve hayalinizdeki seyahati planlayın."
        ),
        OnboardingSlide(
            imageName: "onboarding_booking", // Bu görseli Assets.xcassets'e eklemeniz gerekecek
            title: "Kolayca Rezervasyon Yapın",
            description: "Konaklama, ulaşım ve aktiviteler için hızlı ve güvenli rezervasyon seçenekleriyle zaman kazanın."
        ),
        OnboardingSlide(
            imageName: "onboarding_guide", // Bu görseli Assets.xcassets'e eklemeniz gerekecek
            title: "Kişisel Seyahat Rehberiniz",
            description: "Gitmek istediğiniz yerlerin tarihi, yemek ve eğlence mekanları hakkında detaylı bilgilere ulaşın."
        )
    ]
}
