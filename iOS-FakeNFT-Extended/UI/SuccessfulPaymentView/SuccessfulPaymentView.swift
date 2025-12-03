import SwiftUI

struct SuccessfulPaymentView: View {
    @Environment(Router.self) private var router
    
    var body: some View {
        VStack {
            Spacer()
            
            Image("SuccessfulPayment")
                .frame(width: 278, height: 278)
                .padding()
                .padding(EdgeInsets(top: 20, leading: 28, bottom: 20, trailing: 28))
            
            Text("Успех! Оплата прошла,\nпоздравляем с покупкой!")
                .font(.bold22)
                .foregroundStyle(Color.accentColor)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 16)
            
            Spacer()
            
            Button {
                router.popToRoot()
            } label: {
                RoundedRectangle(cornerRadius: 16)
                    .fill(Color.accentColor)
                    .frame(height: 60)
                    .overlay {
                        Text("Вернуться в корзину")
                            .font(.bold17)
                            .foregroundStyle(Color.primaryColor)
                    }
            }
            .padding(16)
        }
    }
}

#Preview {
    SuccessfulPaymentView()
}
