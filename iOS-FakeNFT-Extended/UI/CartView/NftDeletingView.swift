import SwiftUI

struct NftDeletingView: View {
    @State var viewModel: CartViewModel
    
    var body: some View {
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
