import SwiftUI

struct OnboardingView: View {
    // Onboarding tamamlandığında bu binding true olacak
    @Binding var showOnboarding: Bool

    @State private var currentSlideIndex = 0 // Mevcut slaytın indeksi

    var body: some View {
        VStack {
            // Slaytları kaydırmak için TabView
            TabView(selection: $currentSlideIndex) {
                ForEach(0..<OnboardingSlide.slides.count, id: \.self) { index in
                    OnboardingSlideView(slide: OnboardingSlide.slides[index])
                        .tag(index) // Her slayta bir etiket veriyoruz
                }
            }
            .tabViewStyle(.page(indexDisplayMode: .always)) // Sayfa göstergesi
            .indexViewStyle(.page(backgroundDisplayMode: .always)) // Sayfa göstergesi arka planı

            // Son slaytta "Başla" butonu
            if currentSlideIndex == OnboardingSlide.slides.count - 1 {
                Button(action: {
                    // Onboarding'i tamamla ve ana uygulamaya geç
                    showOnboarding = false
                    // UserDefaults'a uygulamanın ilk kez açılmadığını kaydet
                    UserDefaults.standard.set(true, forKey: "hasLaunchedBefore")
                }) {
                    Text("Şimdi Başla")
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.orange)
                        .cornerRadius(15)
                }
                .padding(.horizontal, 30)
                .padding(.bottom, 50)
            } else {
                // Diğer slaytlarda boşluk bırak
                Spacer()
                    .frame(height: 100) // Butonun kaplayacağı kadar boşluk
            }
        }
    }
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        // Önizleme için bir Binding sağlamalıyız
        OnboardingView(showOnboarding: .constant(true))
    }
}
