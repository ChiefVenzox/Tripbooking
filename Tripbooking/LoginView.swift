import SwiftUI

struct LoginView: View {
    @State private var email = ""
    @State private var password = ""
    @State private var showSignUp = false

    @EnvironmentObject var authManager: AuthManager

    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                Spacer()

                Text("Tekrar Hoş Geldiniz!")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.bottom, 40)

                TextField("E-posta veya Kullanıcı Adı", text: $email)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(10)
                    .autocapitalization(.none)
                    .keyboardType(.emailAddress)
                    .padding(.horizontal)

                SecureField("Şifre", text: $password)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(10)
                    .padding(.horizontal)

                Button(action: {
                    let username = email.split(separator: "@").first?.uppercased() ?? "Kullanıcı"
                    // authManager'ın login fonksiyonunu email ile çağır
                    authManager.login(username: username, email: email)
                }) {
                    Text("Giriş Yap")
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

                Button(action: {
                    print("Şifremi unuttum tıklandı")
                }) {
                    Text("Şifremi unuttum?")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
                .padding(.top, 5)

                Spacer()

                HStack {
                    Text("Hesabın yok mu?")
                        .foregroundColor(.gray)
                    Button(action: {
                        showSignUp = true
                    }) {
                        Text("Üye Ol")
                            .fontWeight(.bold)
                            .foregroundColor(.orange)
                    }
                }
                .padding(.bottom, 40)
            }
            .navigationBarHidden(true)
            .sheet(isPresented: $showSignUp) {
                SignUpView()
                    .environmentObject(authManager)
            }
            .fullScreenCover(isPresented: $authManager.isLoggedIn) {
                HomeView()
                    .environmentObject(authManager)
            }
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
            .environmentObject(AuthManager())
    }
}
