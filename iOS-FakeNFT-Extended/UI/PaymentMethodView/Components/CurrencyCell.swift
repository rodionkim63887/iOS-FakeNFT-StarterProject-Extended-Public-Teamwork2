import SwiftUI
import Kingfisher

struct CurrencyCell: View {
    let fullName: String
    let shortName: String
    let imageURL: String
    
    var body: some View {
        ZStack {
            Color.lightGrey
                .ignoresSafeArea()
            
            HStack(spacing: 4) {
                RoundedRectangle(cornerRadius: 6)
                    .fill(.blackUniversal)
                    .overlay {
                        KFImage(URL(string: imageURL))
                            .resizable()
                            .padding(2.25)
                            .clipShape(
                                RoundedRectangle(cornerRadius: 6)
                            )
                    }
                    .frame(width: 36, height: 36)
                
                VStack(alignment: .leading) {
                    Text(fullName)
                        .font(.regular13)
                        .foregroundStyle(Color.accentColor)
                    
                    Text(shortName)
                        .font(.regular13)
                        .foregroundStyle(Color.greenUniversal)
                }
                
                Spacer()
            }
            .padding(EdgeInsets(top: 5, leading: 12, bottom: 5, trailing: 12))
        }
    }
}

#Preview {
    let fullName = "Bitcoin"
    let shortName: String = "BTC"
    let imageURL: String = "https://code.s3.yandex.net/Mobile/iOS/Currencies/Bitcoin_(BTC).png"
    
    CurrencyCell(fullName: fullName, shortName: shortName, imageURL: imageURL)
}
