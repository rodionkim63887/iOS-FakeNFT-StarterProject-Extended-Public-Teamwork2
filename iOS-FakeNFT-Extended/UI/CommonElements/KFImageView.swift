import SwiftUI
import Kingfisher

enum ImageContentMode {
    case fill
    case fit
}

struct ScaleModifier: ViewModifier {
    let contentMode: ImageContentMode

    func body(content: Content) -> some View {
        switch contentMode {
        case .fill:
            content.scaledToFill()
        case .fit:
            content.scaledToFit()
        @unknown default:
            content.scaledToFit()
        }
    }
}

struct KFImageView: View {
    let url: URL?
    let contentMode: ImageContentMode
    let height: CGFloat?
    let cornerRadius: CGFloat

    @State private var isLoading = true
    @State private var loadFailed = false

    var body: some View {
        ZStack {
            if isLoading {
                ProgressView()
                    .progressViewStyle(.circular)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            }

            KFImage.url(url)
                .onSuccess { _ in
                    isLoading = false
                    loadFailed = false
                }
                .onFailure { _ in
                    isLoading = false
                    loadFailed = true
                }
                .resizable()
                .modifier(ScaleModifier(contentMode: contentMode))
                .opacity(loadFailed ? 0 : 1)

            if loadFailed {
                Image(systemName: "exclamationmark.icloud")
                    .font(.system(size: 24))
                    .foregroundStyle(.gray)
            }
        }
        .frame(height: height)
        .frame(maxWidth: .infinity)
        .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
    }
}
