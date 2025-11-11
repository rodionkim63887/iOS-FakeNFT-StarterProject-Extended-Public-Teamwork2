import SwiftUI

struct ProductInCart: View {
    var body: some View {
        HStack(spacing: 20) {
            Image("MockNFTCard1")
                .resizable()
                .scaledToFit()
                .clipShape(
                    RoundedRectangle(cornerRadius: 12)
                )
            
            VStack(alignment: .leading, spacing: 4) {
                Text("Spring")
                    .font(.system(size: 17, weight: .bold))
                
                HStack(spacing: 2) {
                    ForEach(0..<5) { _ in
                        Image(systemName: "star.fill")
                            .resizable()
                            .frame(width: 12, height: 12)
                            .foregroundStyle(.yellow)
                    }
                }
                
                Spacer()
                
                Text("Цена")
                    .font(.system(size: 13))
                
                Text("1,78 ETH")
                    .font(.system(size: 17, weight: .bold))
            }
            .padding(.vertical, 8)
            
            Spacer()
            
            Image("DeleteFromCart")
                .frame(width: 40, height: 40)
        }
        .frame(height: 108)
    }
}

#Preview {
    ProductInCart()
}
