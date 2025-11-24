import SwiftUI
import ProgressHUD

struct CartView: View {
    @Environment(Router.self) private var router
    @State var viewModel: CartViewModel
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
            .opacity(viewModel.nfts.isEmpty ? 0 : 1)
            .blur(radius: viewModel.blur)
            
            Text("Корзина пуста")
                .font(.bold17)
                .foregroundStyle(Color.accentColor)
                .opacity(viewModel.nfts.isEmpty ? 1 : 0)
            
            if viewModel.deletingAttempt {
                nftDeletingView
            }
        }
    }
    
    private var navigationBarItems: some View {
        HStack {
            Spacer()
            
            Button {
                showingOptions = true
            } label: {
                Image("SortCart")
                    .frame(width: 42, height: 42)
                    .foregroundStyle(Color.accentColor)
            }
            .padding(.horizontal, 9)
            .confirmationDialog("Сортировка", isPresented: $showingOptions) {
                Button("По цене") {
                    viewModel.nfts.sort(by: { $0.price < $1.price })
                }
                
                Button("По рейтингу") {
                    viewModel.nfts.sort(by: { $0.rating > $1.rating })
                }
                
                Button("По названию") {
                    viewModel.nfts.sort(by: { $0.name < $1.name })
                }
                
                Button("Закрыть", role: .cancel) {
                    showingOptions = false
                }
            }
        }
    }
    
    private var nftsList: some View {
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
                        Text("\(viewModel.nfts.count) NFT")
                            .font(.regular15)
                        
                        Text("\(viewModel.getTotalPrice()) ETH")
                            .font(.bold17)
                            .foregroundStyle(.greenUniversal)
                    }
                    .padding(EdgeInsets(top: 16, leading: 16, bottom: 16, trailing: 8))
                    
                    Button {
                        ProgressHUD.animate()
                        Task {
                            do {
                                let currencies = try await orderService.getCurrencies()
                                DispatchQueue.main.async {
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
    
    private var nftDeletingView: some View {
        VStack {
            Image(viewModel.nftToDeleteImage)
                .resizable()
                .frame(width: 108, height: 108)
                .clipShape(
                    RoundedRectangle(cornerRadius: 12)
                )
                .padding(.bottom, 12)
            
            Text("Вы уверены, что хотите\nудалить объект из корзины?")
                .font(.regular13)
                .foregroundStyle(Color.accentColor)
                .multilineTextAlignment(.center)
                .padding(.bottom, 20)
            
            HStack(spacing: 8) {
                Button {
                    viewModel.deleteFromCart()
                } label: {
                    RoundedRectangle(cornerRadius: 16)
                        .fill(Color.accentColor)
                        .frame(width: 127, height: 44)
                        .overlay {
                            Text("Удалить")
                                .font(.regular17)
                                .foregroundStyle(Color.redUniversal)
                        }
                }
                
                Button {
                    viewModel.cancelDeleting()
                } label: {
                    RoundedRectangle(cornerRadius: 16)
                        .fill(Color.accentColor)
                        .frame(width: 127, height: 44)
                        .overlay {
                            Text("Вернуться")
                                .font(.regular17)
                                .foregroundStyle(Color.primaryColor)
                        }
                }
            }
        }
    }
}
