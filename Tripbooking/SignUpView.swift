import SwiftUI

struct SignUpView: View {
    @Environment(\.dismiss) var dismiss // Sheet'i kapatmak için
    @State private var email = "" // E-posta için durum değişkeni
    @State private var password = "" // Şifre için durum değişkeni
    @State private var confirmPassword = "" // Şifre tekrarı için durum değişkeni
    @State private var fullName = "" // Tam ad için durum değişkeni

    var body: some View {
        NavigationView { // Navigasyon için
            VStack(spacing: 20) {
                Spacer()

                Text("Üye Ol")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.bottom, 40)

                // Tam Ad Girişi
                TextField("Tam Ad", text: $fullName)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(10)
                    .padding(.horizontal)

                // E-posta Girişi
                TextField("E-posta", text: $email)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(10)
                    .autocapitalization(.none)
                    .keyboardType(.emailAddress)
                    .padding(.horizontal)

                // Şifre Girişi
                SecureField("Şifre", text: $password)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(10)
                    .padding(.horizontal)

                // Şifre Tekrarı Girişi
                SecureField("Şifreyi Tekrar Girin", text: $confirmPassword)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(10)
                    .padding(.horizontal)

                // Üye Ol Butonu
                Button(action: {
                    // Burada üye olma doğrulama mantığı olacak
                    // Şifrelerin eşleşip eşleşmediğini kontrol edebiliriz
                    if password == confirmPassword {
                        print("Yeni hesap oluşturuldu: \(email)")
                        dismiss() // Üye olma başarılıysa sheet'i kapat
                    } else {
                        print("Şifreler eşleşmiyor!")
                        // Kullanıcıya bir hata mesajı gösterebiliriz
                    }
                }) {
                    Text("Üye Ol")
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.orange)
                        .cornerRadius(15)
                }
                .padding(.horizontal)
                .padding(.top, 20)

                Spacer()

                // Zaten Hesabın Var mı? Giriş Yap Butonu
                HStack {
                    Text("Zaten hesabın var mı?")
                        .foregroundColor(.gray)
                    Button(action: {
                        dismiss() // Giriş ekranına geri dönmek için sheet'i kapat
                    }) {
                        Text("Giriş Yap")
                            .fontWeight(.bold)
                            .foregroundColor(.orange)
                    }
                }
                .padding(.bottom, 40)
            }
            .navigationBarHidden(true) // Navigasyon çubuğunu gizle
        }
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}
