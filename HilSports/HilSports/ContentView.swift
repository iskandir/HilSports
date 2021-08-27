
import SwiftUI
import CoreData


struct ContentView: View {
    //Current view Status for Sidemenu
    @State private var showingMenu = false

    
    var body: some View {
            NavigationView{
                ZStack(alignment: Alignment(horizontal: .leading, vertical: .top),content: {
                    if showingMenu{
                        SideMenu(showingMenu: $showingMenu)
                    } else {
                    EventMap()
                        .cornerRadius(showingMenu ? 20 : 10)
                        .offset(x: showingMenu ? 300: 0, y: showingMenu ? 44 : 0)
                        .scaleEffect(showingMenu ? 0.8 : 1)
                        .ignoresSafeArea()
                        .navigationBarItems(leading: Button(action: {
                            withAnimation(.spring()){
                                showingMenu.toggle()
                            }
                        }, label: {
                            Image(systemName: "menubar.rectangle")
                                .font(.title2)
                                .foregroundColor(.black)
                                .padding(.vertical, 10)
                                .padding(.horizontal, 15)
                                .background(Color.green)
                                .cornerRadius(10)
                                .shadow(color: Color.black.opacity(0.5), radius: 5, x: 5, y: 5)
                        }))
                        
                    }
                })
            }
    }
}

struct GradientButtonStyle : ButtonStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .foregroundColor(Color.white)
            .padding()
            .background(LinearGradient(gradient: Gradient(colors: [Color.green, Color.blue]),startPoint: .leading, endPoint: .trailing))
            .cornerRadius(25.0)
            .scaleEffect(configuration.isPressed ? 1.3 : 1.0)
    }
}
