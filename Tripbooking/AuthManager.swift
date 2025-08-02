import Foundation
import Combine
import SwiftUI // UIImage için

// Kullanıcı kimlik doğrulama ve oturum durumunu yönetecek sınıf
class AuthManager: ObservableObject {
    @Published var isLoggedIn: Bool = false
    @Published var username: String = "Misafir" // Varsayılan kullanıcı adı
    @Published var userEmail: String = "" // Kullanıcının e-postasını da tutalım
    @Published var profileImageData: Data? // Profil fotoğrafı verisi (UIImage olarak dönüştürülecek)
    // @Published var userReservations: [Reservation] = [] // Rezervasyonlar kaldırıldı

    // Giriş yapma fonksiyonu (şimdilik basit bir simülasyon)
    func login(username: String, email: String) {
        self.username = username
        self.userEmail = email
        self.isLoggedIn = true
        print("Kullanıcı giriş yaptı: \(username) (\(email))")
        // self.userReservations = [] // Rezervasyonlar kaldırıldı
    }

    // Çıkış yapma fonksiyonu (şimdilik basit bir simülasyon)
    func logout() {
        self.username = "Misafir"
        self.userEmail = ""
        self.isLoggedIn = false
        self.profileImageData = nil
        // self.userReservations = [] // Rezervasyonlar kaldırıldı
        print("Kullanıcı çıkış yaptı.")
    }

    // Profil fotoğrafını ayarlama fonksiyonu
    func setProfileImage(image: UIImage) {
        self.profileImageData = image.jpegData(compressionQuality: 0.8) // JPEG olarak kaydet
    }

    // Rezervasyon ekleme fonksiyonu kaldırıldı
    // func addReservation(_ reservation: Reservation) {
    //     userReservations.append(reservation)
    //     print("AuthManager'a yeni rezervasyon eklendi: \(reservation.place.name)")
    // }
}
