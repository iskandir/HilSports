
import SwiftUI
import CoreData


struct ContentView: View {

    @State var showLoginView : Bool = false
    @State var loggedUser : Bool = false
    
    @StateObject var user = UserModel()
    var body: some View {
        if loggedUser == true {
            MapLandingView().environmentObject(user)
        } else {
            NavigationView{
                VStack {
                    WelcomeText()
                    
                    if showLoginView {
                        LoginView(showLoginView: $showLoginView, loggedUser: $loggedUser)
                            .animation(.easeIn)
                            .environmentObject(user)
                    } else {
                        HStack{
                            Button("Sign in") {
                                self.showLoginView = true
                            }.buttonStyle(AuthenticationButtonStyle(bgColor: .green))
                            
                            NavigationLink(destination: RegistrationView())
                            {
                                Text("Registration")
                            }.buttonStyle(RegistrationButtonStyle(bgColor: .gray))
                        }
                    }
                }
            }
            
        }
    }
}
//Button style for AuthenticationButton
struct AuthenticationButtonStyle: ButtonStyle {
    var bgColor: Color
    
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .padding(20)
            .background(
                ZStack{
                    RoundedRectangle(cornerRadius: 10, style: .continuous)
                        .shadow(color: .white, radius: configuration.isPressed ? 7 : 10, x: configuration.isPressed ? -5: -15, y: configuration.isPressed ? -5: -15)
                        .shadow(color: .black, radius: configuration.isPressed ? 7 : 10, x: configuration.isPressed ? 5: 15, y: configuration.isPressed ? 5: 15)
                        .blendMode(.overlay)
                    RoundedRectangle(cornerRadius: 10, style: .continuous)
                        .fill(bgColor)
                }
            ).scaleEffect(configuration.isPressed ? 0.95: 1)
            .foregroundColor(.white)
            .animation(.spring())
        
    }
}

//Button style for RegistrationButton
struct RegistrationButtonStyle : ButtonStyle {
    var bgColor: Color
    
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .padding(20)
            .background(
                ZStack{
                    RoundedRectangle(cornerRadius: 10, style: .continuous)
                        .shadow(color: .white, radius: configuration.isPressed ? 7 : 10, x: configuration.isPressed ? -5: -15, y: configuration.isPressed ? -5: -15)
                        .shadow(color: .black, radius: configuration.isPressed ? 7 : 10, x: configuration.isPressed ? 5: 15, y: configuration.isPressed ? 5: 15)
                        .blendMode(.overlay)
                    RoundedRectangle(cornerRadius: 10, style: .continuous)
                        .fill(bgColor)
                }
            ).scaleEffect(configuration.isPressed ? 0.95: 1)
            .foregroundColor(.white)
            .animation(.spring())
        
    }
}

struct WelcomeText : View {
    var body: some View {
        
        Text("Welcome to HilFit!")
            .fontWeight(.black)
            .foregroundColor(Color(.systemGreen))
            .font(.largeTitle)
            .multilineTextAlignment(.center)
        
        Text("Empower your life!")
            .fontWeight(.light)
            .multilineTextAlignment(.center)
            .padding()
        Image("hallo")
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(width: 150, height: 150)
            .clipped()
            .cornerRadius(150)
            .padding(.bottom, 75)
        
    }
}
