import SwiftUI
import Kingfisher

struct NftDeletingView: View {
    @Environment(CartStore.self) private var cart
    
    var body: some View {
        VStack {
            KFImage(cart.nftToDeleteImage)
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
                    guard let nftToDelete = cart.nftToDelete else {
                        assertionFailure("[CartViewModel] - deleteFromCart: No such NFT found.")
                        return
                    }
                    cart.remove(nftToDelete)
                    cart.deleteFromCart()
                } label: {
                    RoundedRectangle(cornerRadius: 12)
                        .fill(Color.accentColor)
                        .frame(width: 127, height: 44)
                        .overlay {
                            Text("Удалить")
                                .font(.regular17)
                                .foregroundStyle(Color.redUniversal)
                        }
                }
                
                Button {
                    cart.cancelDeleting()
                } label: {
                    RoundedRectangle(cornerRadius: 12)
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
