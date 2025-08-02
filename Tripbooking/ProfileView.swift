import SwiftUI
import PhotosUI

struct ProfileView: View {
    @EnvironmentObject var authManager: AuthManager // AuthManager'a erişim
    @State private var selectedItem: PhotosPickerItem? = nil
    @State private var profileImage: Image? = nil

    var body: some View {
        ScrollView { // İçeriğin kaydırılabilir olması için
            VStack(spacing: 25) { // Genel boşluğu artırdık
                Text("Profilim")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.bottom, 20)

                // Profil Fotoğrafı Alanı
                VStack {
                    if let image = profileImage {
                        image
                            .resizable()
                            .scaledToFill()
                            .frame(width: 150, height: 150)
                            .clipShape(Circle())
                            .overlay(Circle().stroke(Color.blue, lineWidth: 4))
                            .shadow(radius: 10)
                    } else if let imageData = authManager.profileImageData,
                              let uiImage = UIImage(data: imageData) {
                        Image(uiImage: uiImage)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 150, height: 150)
                            .clipShape(Circle())
                            .overlay(Circle().stroke(Color.blue, lineWidth: 4))
                            .shadow(radius: 10)
                    }
                    else {
                        Image(systemName: "person.circle.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 150, height: 150)
                            .foregroundColor(.gray)
                            .clipShape(Circle())
                            .overlay(Circle().stroke(Color.gray, lineWidth: 2))
                    }

                    PhotosPicker(
                        selection: $selectedItem,
                        matching: .images,
                        photoLibrary: .shared()
                    ) {
                        Text("Fotoğrafı Değiştir")
                            .font(.headline)
                            .foregroundColor(.blue)
                            .padding(.top, 10)
                    }
                    .onChange(of: selectedItem) { newItem in
                        Task {
                            if let data = try? await newItem?.loadTransferable(type: Data.self) {
                                if let uiImage = UIImage(data: data) {
                                    profileImage = Image(uiImage: uiImage)
                                    authManager.setProfileImage(image: uiImage)
                                }
                            }
                        }
                    }
                }
                .padding(.bottom, 30)

                // Kullanıcı Bilgileri
                VStack(alignment: .leading, spacing: 15) {
                    ProfileInfoRow(label: "Kullanıcı Adı", value: authManager.username, icon: "person.fill")
                    ProfileInfoRow(label: "E-posta", value: authManager.userEmail, icon: "envelope.fill")
                }
                .padding(.horizontal)
                .padding(.bottom, 30)

                // "Rezervasyonlarım" bölümü kaldırıldı
                /*
                SectionHeader(title: "Rezervasyonlarım")
                    .padding(.horizontal)
                    .padding(.top, 10)

                if authManager.userReservations.isEmpty {
                    Text("Henüz bir rezervasyonunuz bulunmamaktadır.")
                        .foregroundColor(.gray)
                        .padding(.horizontal)
                        .padding(.top, 5)
                } else {
                    VStack(alignment: .leading, spacing: 10) {
                        ForEach(authManager.userReservations) { reservation in
                            ReservationRow(reservation: reservation)
                        }
                    }
                    .padding(.horizontal)
                }
                */

                Spacer()

                // Çıkış Yap Butonu
                Button(action: {
                    authManager.logout()
                }) {
                    Text("Çıkış Yap")
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.red)
                        .cornerRadius(15)
                }
                .padding(.horizontal)
                .padding(.bottom, 20)
            }
            .navigationTitle("Profil")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

// ReservationRow struct'ı kaldırıldı
/*
struct ReservationRow: View {
    let reservation: Reservation

    var body: some View {
        HStack {
            Image(systemName: "calendar")
                .foregroundColor(.blue)
                .font(.title3)
            VStack(alignment: .leading) {
                Text(reservation.place.name)
                    .font(.headline)
                    .fontWeight(.semibold)
                Text("\(reservation.reservationDate.formatted(date: .abbreviated, time: .omitted)) - \(reservation.numberOfPeople) Kişi")
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
            Spacer()
            Image(systemName: "chevron.right")
                .foregroundColor(.gray)
        }
        .padding()
        .background(Color.white)
        .cornerRadius(10)
        .shadow(color: Color.black.opacity(0.05), radius: 3, x: 0, y: 2)
    }
}
*/

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
            .environmentObject(AuthManager())
    }
}
