import SwiftUI

struct PaymentMethodView: View {
    @Environment(Router.self) private var router
    @State private var selectedCurrency: Currency? = nil
    private let orderService = OrderServiceImpl(networkClient: DefaultNetworkClient())
    let currencies: [Currency]
    private let columns = [GridItem(.flexible()), GridItem(.flexible())]
    
    var body: some View {
        ZStack {
            Color.primaryColor
                .ignoresSafeArea()
            
            VStack {
                navigationBarItems
                paymentMethodsGrid
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
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(
                                selectedCurrency == currency ? Color.accentColor : Color.clear,
                                lineWidth: 1
                            )
                    )
                    .clipShape(
                        RoundedRectangle(cornerRadius: 12)
                    )
                    .onTapGesture {
                        selectedCurrency = currency
                    }
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
                    router.push(.userAgreementView)
                }
                .padding(.top, 1)
            
            Button {
                if let selectedCurrency {
                    Task {
                        do {
                            let result = try await orderService.setCurrency(id: selectedCurrency.id)
                            if result.success {
                                await MainActor.run {
                                    router.push(.successfulPayment)
                                }
                            }
                        } catch {
                            assertionFailure("Вывести алерт")
                        }
                    }
                }
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
