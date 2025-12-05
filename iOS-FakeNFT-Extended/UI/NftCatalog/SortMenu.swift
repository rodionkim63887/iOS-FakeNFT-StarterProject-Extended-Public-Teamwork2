import SwiftUI

struct SortMenuOverlay: View {
    
    @Binding var showMenu: Bool
    
    var sortByName: () -> Void
    var sortByCount: () -> Void
    
    @State private var offset: CGFloat = 300
    @State private var backgroundOpacity: Double = 0
    
    var body: some View {
        ZStack {
            
            Color.black.opacity(backgroundOpacity)
                .ignoresSafeArea()
                .onTapGesture { hide() }
                .animation(.easeInOut(duration: 0.25), value: backgroundOpacity)
            
            VStack(spacing: 8) {
                
                Spacer()
                
                VStack(spacing: 0) {
                    Text("Сортировка")
                        .font(.regular13)
                        .foregroundColor(.labelColor)
                        .frame(height: 42)
                    
                    Divider()
                    
                    Button {
                        sortByName()
                        hide()
                    } label: {
                        Text("По названию")
                            .font(.regular20)
                            .foregroundColor(.blueUniversalColor)
                            .frame(maxWidth: .infinity)
                            .frame(height: 61)
                    }
                    
                    Divider()
                    
                    Button {
                        sortByCount()
                        hide()
                    } label: {
                        Text("По количеству NFT")
                            .font(.regular20)
                            .foregroundColor(.blueUniversalColor)
                            .frame(maxWidth: .infinity)
                            .frame(height: 61)
                    }
                }
                .background(.thinMaterial)
                .cornerRadius(13)
                .padding(.horizontal, 8)
                
                Button {
                    hide()
                } label: {
                    Text("Закрыть")
                        .font(.semibold20)
                        .frame(maxWidth: .infinity)
                        .frame(height: 61)
                }
                .background(.whiteUniversal)
                .cornerRadius(13)
                .padding(.horizontal, 8)
            }
            .offset(y: offset)
            .animation(.spring(response: 0.35, dampingFraction: 0.85), value: offset)
        }
        .onAppear {
            backgroundOpacity = 0.4
            offset = 0
        }
    }
    
    private func hide() {
        backgroundOpacity = 0
        
        offset = 300
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
            showMenu = false
        }
    }
}

#Preview {
    @Previewable @State var showMenu = true

    ZStack {
        Color.gray.opacity(0.2)
            .ignoresSafeArea()

        if showMenu {
            SortMenuOverlay(
                showMenu: $showMenu,
                sortByName: {},
                sortByCount: {}
            )
        }
    }
}
