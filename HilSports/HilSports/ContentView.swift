
import SwiftUI
import CoreData


struct ContentView: View {
    @State var showLoginView : Bool = true
    
    var body: some View {
        VStack {
          Image("header_image")
            .resizable()
            .aspectRatio(contentMode: .fit)

          Text("Welcome to HilFit!")
            .fontWeight(.black)
            .foregroundColor(Color(.systemIndigo))
            .font(.largeTitle)
            .multilineTextAlignment(.center)

          Text("Empower your life!")
            .fontWeight(.light)
            .multilineTextAlignment(.center)
            .padding()
            if showLoginView {
                LoginView()
                    .animation(.easeIn)
            } else {
          Button("Sign in") {
            self.showLoginView = true
          }
          .buttonStyle(AuthenticationButtonStyle())
            Spacer()
            Spacer()
            }
        }
    }
}
struct AuthenticationButtonStyle: ButtonStyle {
  func makeBody(configuration: Self.Configuration) -> some View {
    configuration.label
      .foregroundColor(.white)
      .padding()
      .frame(maxWidth: .infinity)
      .background(Color(.systemIndigo))
      .cornerRadius(12)
      .padding()
  }
}
