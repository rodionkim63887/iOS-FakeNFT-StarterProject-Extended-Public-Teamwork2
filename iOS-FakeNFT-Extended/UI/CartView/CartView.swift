import SwiftUI

struct CartView: View {
    var body: some View {
        ZStack {
            Color.primaryColor
                .ignoresSafeArea()
            
            VStack(spacing: 20) {
                HStack {
                    Spacer()
                    
                    Button {
                        print("Sort")
                    } label: {
                        Image("SortCart")
                            .frame(width: 42, height: 42)
                            .foregroundStyle(Color.accentColor)
                    }
                    .padding(.horizontal, 9)
                }
                
                List {
                    ForEach(0..<3) { _ in
                        ProductInCart()
                            .listRowSeparator(.hidden)
                            .listRowBackground(Color.primaryColor)

                    }
                }
                .listRowSpacing(16)
                .listStyle(.plain)
            }
            
            VStack {
                Spacer()
                
                ZStack {
                    Rectangle()
                        .fill(Color.lightGreyColor)
                        .frame(height: 76)
                        .cornerRadius(12, corners: [.topLeft, .topRight])
                    
                    HStack {
                        VStack(alignment: .leading) {
                            Text("3 NFT")
                                .font(.regular15)
                            
                            Text("5,34 ETH")
                                .font(.bold17)
                                .foregroundStyle(.greenUniversal)
                        }
                        .padding(EdgeInsets(top: 16, leading: 16, bottom: 16, trailing: 8))
                        
                        Button {
                            print("Pushed")
                        } label: {
                            RoundedRectangle(cornerRadius: 16)
                                .fill(Color.accentColor)
                                .frame(height: 44)
                                .overlay {
                                    Text("К оплате")
                                        .font(.bold17)
                                        .foregroundStyle(Color.primaryColor)
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
