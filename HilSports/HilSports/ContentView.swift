
import SwiftUI
import CoreData


struct ContentView: View {
    
    var body: some View {
        VStack {
          Spacer()

          // 2
          Image("header_image")
            .resizable()
            .aspectRatio(contentMode: .fit)

          Text("Welcome to Ellifit!")
            .fontWeight(.black)
            .foregroundColor(Color(.systemIndigo))
            .font(.largeTitle)
            .multilineTextAlignment(.center)

          Text("Empower your elliptical workouts by tracking every move.")
            .fontWeight(.light)
            .multilineTextAlignment(.center)
            .padding()

          Spacer()

          // 3
          Button("Sign in with Google") {
            print("Do smth")
          }
          .buttonStyle(AuthenticationButtonStyle())
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
