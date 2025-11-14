import SwiftUI

struct ProductInCart: View {
    var body: some View {
        ZStack {
            Color.primaryColor
                .ignoresSafeArea()
            
            HStack(spacing: 20) {
                Image("MockNFTCard1")
                    .resizable()
                    .scaledToFit()
                    .clipShape(
                        RoundedRectangle(cornerRadius: 12)
                    )
                
                VStack(alignment: .leading, spacing: 4) {
                    Text("Spring")
                        .font(.bold17)
                    
                    HStack(spacing: 2) {
                        ForEach(0..<5) { _ in
                            Image(systemName: "star.fill")
                                .resizable()
                                .frame(width: 12, height: 12)
                                .foregroundStyle(.yellowUniversal)
                        }
                    }
                    
                    Spacer()
                    
                    Text("Цена")
                        .font(.regular13)
                    
                    Text("1,78 ETH")
                        .font(.bold17)
                }
                .padding(.vertical, 8)
                
                Spacer()
                
                Button {
                    print("Delete")
                } label: {
                    Image("DeleteFromCart")
                        .frame(width: 40, height: 40)
                        .foregroundStyle(Color.accentColor)
                }
                .buttonStyle(.plain)
            }
            .frame(height: 108)
        }
    }
}

#Preview {
    ProductInCart()
}
