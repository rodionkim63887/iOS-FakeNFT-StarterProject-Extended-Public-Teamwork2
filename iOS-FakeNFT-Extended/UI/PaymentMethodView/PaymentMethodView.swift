import SwiftUI

struct PaymentMethodView: View {
    @Environment(Router.self) private var router
    let currencies: [Currency]
    private let columns = [GridItem(.flexible()), GridItem(.flexible())]
    let fullName = "Bitcoin"
    let shortName: String = "BTC"
    let imageURL: String = "https://code.s3.yandex.net/Mobile/iOS/Currencies/Bitcoin_(BTC).png"
    
    var body: some View {
        ZStack {
            Color.primaryColor
                .ignoresSafeArea()
            
            VStack {
                navigationBarItems
                paymentMethodsGrid
                Spacer()
            }
            
            VStack {
                Spacer()
                
                bottomPanel
            }
        }
    }
    
    private var navigationBarItems: some View {
        HStack {
            Button {
                router.pop()
            } label: {
                Image("ShevronLeft")
                    .frame(width: 24, height: 24)
                    .foregroundStyle(Color.accentColor)
            }
            
            Spacer()
        }
        .overlay(
            Text("Выберите способ оплаты")
                .font(.bold17)
                .foregroundStyle(Color.accentColor)
        )
        .padding(9)
    }
    
    private var paymentMethodsGrid: some View {
        LazyVGrid(columns: columns, spacing: 7) {
            ForEach(currencies, id: \.self) { currency in
                CurrencyCell(fullName: currency.title, shortName: currency.name, imageURL: currency.image)
                    .clipShape(
                        RoundedRectangle(cornerRadius: 12)
                    )
            }
        }
        .padding(EdgeInsets(top: 20, leading: 16, bottom: 20, trailing: 16))
    }
    
    private var bottomPanel: some View {
        VStack(alignment: .leading) {
            Text("Совершая покупку, вы соглашаетесь с условиями")
                .font(.regular13)
                .foregroundStyle(Color.accentColor)
            
            Text("Пользовательского соглашения")
                .font(.regular13)
                .foregroundStyle(Color.blueUniversalColor)
                .onTapGesture {
                    print("Пользовательское соглашение")
                }
            
            Button {
                print("Pay")
            } label: {
                RoundedRectangle(cornerRadius: 16)
                    .fill(Color.accentColor)
                    .frame(height: 60)
                    .overlay {
                        Text("Оплатить")
                            .font(.bold17)
                            .foregroundStyle(Color.primaryColor)
                    }
            }
            .padding(.top, 16)
            
        }
        .padding(16)
        .background(
            Rectangle()
                .fill(Color.lightGreyColor)
                .cornerRadius(12, corners: [.topLeft, .topRight])
                .ignoresSafeArea()
        )
    }
}
