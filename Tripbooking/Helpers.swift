import SwiftUI

// Bölüm başlıkları için yardımcı görünüm
struct SectionHeader: View {
    let title: String
    var body: some View {
        Text(title)
            .font(.title2)
            .fontWeight(.bold)
            .foregroundColor(.primary)
            .padding(.horizontal, 20)
            .padding(.top, 15)
    }
}

// Profil bilgileri satırı için yardımcı görünüm
struct ProfileInfoRow: View {
    let label: String
    let value: String
    let icon: String

    var body: some View {
        HStack {
            Image(systemName: icon)
                .foregroundColor(.blue)
                .font(.title3)
                .frame(width: 30)
            VStack(alignment: .leading) {
                Text(label)
                    .font(.caption)
                    .foregroundColor(.gray)
                Text(value)
                    .font(.headline)
                    .fontWeight(.semibold)
                    .foregroundColor(.primary)
            }
            Spacer()
        }
        .padding(.vertical, 8)
        .padding(.horizontal, 10)
        .background(Color(.systemGray6).opacity(0.3))
        .cornerRadius(10)
    }
}

// Comment ve CommentRow struct'ları buradan kaldırıldı.
/*
struct Comment: Identifiable {
    let id = UUID()
    let username: String
    let text: String
    let placeName: String
}

struct CommentRow: View {
    let comment: Comment

    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            HStack {
                Image(systemName: "person.circle.fill")
                    .resizable()
                    .frame(width: 30, height: 30)
                    .foregroundColor(.gray)
                    .clipShape(Circle())
                Text(comment.username)
                    .font(.subheadline)
                    .fontWeight(.semibold)
                Spacer()
                Text(comment.placeName)
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            Text(comment.text)
                .font(.body)
                .foregroundColor(.primary)
                .lineLimit(nil)
        }
        .padding()
        .background(Color.white)
        .cornerRadius(10)
        .shadow(color: Color.black.opacity(0.05), radius: 3, x: 0, y: 2)
    }
}
*/
