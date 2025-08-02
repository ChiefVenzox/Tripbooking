import SwiftUI

@main
struct TripBookingApp: App {
    @StateObject var authManager = AuthManager()
    // Uygulamanın ilk kez başlatılıp başlatılmadığını kontrol eden durum değişkeni
    @AppStorage("hasLaunchedBefore") var hasLaunchedBefore: Bool = false

    var body: some Scene {
        WindowGroup {
            // Eğer uygulama daha önce başlatılmadıysa onboarding'i göster
            if !hasLaunchedBefore {
                OnboardingView(showOnboarding: $hasLaunchedBefore)
            } else {
                // Aksi takdirde, giriş durumuna göre LoginView veya HomeView'i göster
                LoginView()
                    .environmentObject(authManager)
            }
        }
    }
}
