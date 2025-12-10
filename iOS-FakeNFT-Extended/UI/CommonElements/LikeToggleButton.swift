import SwiftUI

struct LikeToggleButton: View {
    let isLiked: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Image(systemName: "heart.fill")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 18)
                .foregroundStyle(isLiked ? Color.redUniversal : Color.whiteUniversal)
        }
        .frame(width: 42, height: 42)
    }
}
