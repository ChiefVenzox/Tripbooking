import SwiftUI

struct OnboardingSlideView: View {
    let slide: OnboardingSlide // Gösterilecek slayt verisi

    var body: some View {
        VStack(spacing: 30) {
            Image(slide.imageName)
                .resizable()
                .scaledToFit() // Görselin çerçeveye sığmasını sağlar
                .frame(height: 300) // Görsel yüksekliği
                .padding(.horizontal, 40) // Yatay boşluk
                .shadow(color: Color.black.opacity(0.15), radius: 10, x: 0, y: 5)

            Text(slide.title)
                .font(.largeTitle)
                .fontWeight(.bold)
                .multilineTextAlignment(.center)
                .foregroundColor(.primary)
                .padding(.horizontal)

            Text(slide.description)
                .font(.body)
                .multilineTextAlignment(.center)
                .foregroundColor(.secondary)
                .padding(.horizontal, 30)

            Spacer() // İçeriği yukarı itmek için
        }
        .padding(.top, 50) // Üstten boşluk
    }
}

struct OnboardingSlideView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingSlideView(slide: OnboardingSlide.slides[0])
    }
}
