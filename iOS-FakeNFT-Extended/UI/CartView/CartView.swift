import SwiftUI
import ProgressHUD

struct CartView: View {
    @Environment(Router.self) private var router
    @Environment(CartStore.self) private var cart
    @State private var showingOptions = false
    let orderService = OrderServiceImpl(networkClient: DefaultNetworkClient())
    
    var body: some View {
        ZStack {
            Color.primaryColor
                .ignoresSafeArea()
            
            ZStack {
                VStack(spacing: 20) {
                    navigationBarItems
                    nftsList
                }
                
                costAndPaymentPanel
            }
            .opacity(cart.items.isEmpty ? 0 : 1)
            .blur(radius: cart.blur)
            
            Text("Корзина пуста")
                .font(.bold17)
                .foregroundStyle(Color.accentColor)
                .opacity(cart.items.isEmpty ? 1 : 0)
            
            if cart.deletingAttempt {
                NftDeletingView()
            }
        }
    }
    
    private var navigationBarItems: some View {
        HStack {
            Spacer()
            
            Button {
                showingOptions = true
            } label: {
                MenuButtonImage()
            }
            .padding(.trailing, 9)
            
            .confirmationDialog("Сортировка", isPresented: $showingOptions, titleVisibility: .visible) {
                Button("По цене") {
                    cart.items.sort(by: { $0.price < $1.price })
                }
                
                Button("По рейтингу") {
                    cart.items.sort(by: { $0.rating > $1.rating })
                }
                
                Button("По названию") {
                    cart.items.sort(by: { $0.name < $1.name })
                }
                
                Button("Закрыть", role: .cancel) {
                    showingOptions = false
                }
            }
        }
    }
    
    private var nftsList: some View {
        List {
            ForEach(cart.items) { nft in
                ProductInCart(nft: nft)
                    .listRowSeparator(.hidden)
                    .listRowBackground(Color.primaryColor)
            }
        }
        .listRowSpacing(16)
        .listStyle(.plain)
    }
    
    private var costAndPaymentPanel: some View {
        VStack {
            Spacer()
            
            ZStack {
                Rectangle()
                    .fill(Color.lightGreyColor)
                    .frame(height: 76)
                    .cornerRadius(12, corners: [.topLeft, .topRight])
                
                HStack {
                    VStack(alignment: .leading) {
                        Text("\(cart.items.count) NFT")
                            .font(.regular15)
                        
                        Text("\(String(format: "%.2f", cart.totalPrice)) ETH")
                            .font(.bold17)
                            .foregroundStyle(.greenUniversal)
                    }
                    .padding(EdgeInsets(top: 16, leading: 16, bottom: 16, trailing: 8))
                    
                    Button {
                        ProgressHUD.animate()
                        Task {
                            do {
                                let currencies = try await orderService.getCurrencies()
                                await MainActor.run {
                                    ProgressHUD.dismiss()
                                    router.push(.paymentMethod(currencies: currencies))
                                }
                            } catch {
                                assertionFailure("Fail: \(error)")
                            }
                        }
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
