import SwiftUI

struct MenuButtonImage: View {
    var body: some View {
        Image("MenuButton")
            .resizable()
            .scaledToFit()
            .frame(width: 21)
            .foregroundStyle(.black)
            .padding(.horizontal, 10.5)
            .padding(.vertical, 14.7)
    }
}
