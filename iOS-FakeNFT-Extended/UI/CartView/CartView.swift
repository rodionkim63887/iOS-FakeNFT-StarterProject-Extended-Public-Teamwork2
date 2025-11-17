import SwiftUI

struct CartView: View {
    @State var viewModel: CartViewModel
    
    var body: some View {
        ZStack {
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
                        ForEach(viewModel.nfts) { nft in
                            ProductInCart(viewModel: viewModel, nft: nft)
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
                                Text("\(viewModel.nfts.count) NFT")
                                    .font(.regular15)
                                
                                Text("\(getTotalPrice()) ETH")
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
            .blur(radius: viewModel.blur)
            
            if viewModel.deletingAttempt {
                HStack {
                    Button {
                        print("Отменить")
                        viewModel.cancelDeleting()
                    } label: {
                        Text("Отменить")
                    }
                    
                    Button {
                        print("Удалить")
                        viewModel.deleteFromCart()
                    } label: {
                        Text("Удалить")
                    }
                }
            }
        }
    }
    
    private func getTotalPrice() -> String {
        var totalPrice: Double = 0
        for nft in viewModel.nfts {
            totalPrice += nft.price
        }
        
        return String(format: "%.2f", totalPrice)
    }
}

#Preview {
    CartView(viewModel: CartViewModel())
}
