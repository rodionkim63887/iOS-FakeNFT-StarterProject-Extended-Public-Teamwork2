import SwiftUI

struct CartView: View {
    var body: some View {
        ZStack {
            VStack(spacing: 20) {
                HStack {
                    Spacer()
                    
                    Button {
                        print("Sort")
                    } label: {
                        Image("SortCart")
                            .frame(width: 42, height: 42)
                    }
                    .padding(.horizontal, 9)
                }
                
                List {
                    ForEach(0..<3) { _ in
                        ProductInCart()
                            .listRowSeparator(.hidden)
                    }
                }
                .listRowSpacing(16)
                .listStyle(.plain)
            }
            
            VStack {
                Spacer()
                
                ZStack {
                    Rectangle()
                        .fill(.gray)
                        .frame(height: 76)
                        .cornerRadius(12, corners: [.topLeft, .topRight])
                    
                    HStack {
                        VStack(alignment: .leading) {
                            Text("3 NFT")
                                .font(.system(size: 15))
                            
                            Text("5,34 ETH")
                                .font(.system(size: 17, weight: .bold))
                                .foregroundStyle(.green)
                        }
                        .padding(EdgeInsets(top: 16, leading: 16, bottom: 16, trailing: 8))
                        
                        Button {
                            print("Pushed")
                        } label: {
                            RoundedRectangle(cornerRadius: 16)
                                .fill(.black)
                                .frame(height: 44)
                                .overlay {
                                    Text("К оплате")
                                        .font(.system(size: 17, weight: .bold))
                                        .foregroundStyle(.white)
                                }
                        }
                        .padding(16)
                    }
                }
            }
        }
    }
}

#Preview {
    CartView()
}
