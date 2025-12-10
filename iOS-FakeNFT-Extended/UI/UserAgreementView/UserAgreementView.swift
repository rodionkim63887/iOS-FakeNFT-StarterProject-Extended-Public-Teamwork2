import SwiftUI

struct UserAgreementView: View {
    @Environment(Router.self) private var router
    
    var body: some View {
        VStack {
            HStack {
                Button {
                    router.pop()
                } label: {
                    Image("ShevronLeft")
                        .frame(width: 24, height: 24)
                        .foregroundStyle(Color.accentColor)
                }
                .padding(9)
                
                Spacer()
            }
            
            if let url = URL(string: "https://yandex.ru/legal/practicum_termsofuse") {
                WebView(url: url)
                    .ignoresSafeArea()
            } else {
                Text("Некорректный URL")
            }
        }
    }
}

#Preview {
    UserAgreementView()
}
