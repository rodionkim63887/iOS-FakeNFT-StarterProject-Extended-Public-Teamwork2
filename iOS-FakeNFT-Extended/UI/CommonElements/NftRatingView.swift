import SwiftUI

struct NftRatingView: View {
    let rating: Int
    
    private let maxRating = 5
    private let starSize: CGFloat = 12

    var body: some View {
        HStack(spacing: 2) {
            ForEach(0..<maxRating, id: \.self) { index in
                Image(systemName: "star.fill")
                    .resizable()
                    .frame(width: starSize, height: starSize)
                    .foregroundStyle(index < rating ? Color.yellowUniversalColor : Color.lightGreyColor)
            }
        }
    }
}
