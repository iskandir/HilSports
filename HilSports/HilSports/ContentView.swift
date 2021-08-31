
import SwiftUI
import CoreData


struct ContentView: View {
    @State var showLoginView : Bool = true
    @State var showRegistrationView : Bool = false
    @EnvironmentObject var loginModel: LoginModel
    
    
    var body: some View {
        VStack {
          Image("header_image")
            .resizable()
            .aspectRatio(contentMode: .fit)

          Text("Welcome to HilFit!")
            .fontWeight(.black)
            .foregroundColor(Color(.systemGreen))
            .font(.largeTitle)
            .multilineTextAlignment(.center)

          Text("Empower your life!")
            .fontWeight(.light)
            .multilineTextAlignment(.center)
            .padding()
            if showLoginView {
                LoginView()
                    .animation(.easeIn)
            } else if showRegistrationView {
                NavigationLink(
                    destination: RegistrationView(),
                    label: {
                       Text("Registration")
                    })
                
                /*RegistrationView()
                    .animation(.easeIn)*/
            } else {
                VStack{
                    Button("Sign in") {
                        self.showLoginView = true
                    }
                    .buttonStyle(AuthenticationButtonStyle())
                    Button("Registration") {
                        self.showRegistrationView = true
                    }
                    .buttonStyle(RegistrationButtonStyle())
                    }
            }
            Spacer()
            Spacer()
        }
    }
}
struct AuthenticationButtonStyle: ButtonStyle {
  func makeBody(configuration: Self.Configuration) -> some View {
    configuration.label
      .foregroundColor(.white)
      .padding()
      .frame(maxWidth: .infinity)
      .background(Color(.systemGreen))
      .cornerRadius(12)
      .padding()
  }
}

struct RegistrationButtonStyle : ButtonStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .foregroundColor(.white)
            .padding()
            .frame(maxWidth: .infinity)
            .background(Color(.systemGray2))
            .cornerRadius(12)
            .padding()
    }
}
