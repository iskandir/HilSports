//
//  EventMap.swift
//  HilSports
//
//  Created by Dennis Hasselbusch on 27.08.21.
//

import SwiftUI
import MapKit


struct EventMap: View {
    @State private var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 52.15292091359113, longitude: 9.954251316083534), span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5))
    @State private var locations: [Location] = Location.getLocation()
    
    @State private var filters = [
        FilterItem(title: "Football", checked: false),
        FilterItem(title: "Tennis", checked: false),
        FilterItem(title: "Badminton", checked: false),
        FilterItem(title: "Basketball", checked: false),
        FilterItem(title: "Running", checked: false)
    ]
    
    @State var edgesCardview = UIApplication.shared.windows.first?.safeAreaInsets
    @State var showFilter = false
    
    @EnvironmentObject var user : UserModel
    
    var body: some View {
        ZStack(alignment: Alignment(horizontal: .trailing, vertical: .bottom), content: {
            Map(coordinateRegion: $region, showsUserLocation: true, userTrackingMode: .constant(.follow), annotationItems: locations) {(location) -> MapPin in MapPin(coordinate: location.coordinate, tint: .green)}
            //Filter Button
            Button(action: {
                    withAnimation{
                        showFilter.toggle()
                        //TESTCASE:
                        //MARK: Testcase for debugging
                        /*print("Username:\(user.username) / Password: \(user.password) / Email: \(user.email)")*/
                    }
            }, label: {
            Image(systemName: "list.dash")
                .font(.title2)
                .foregroundColor(.black)
                .padding(.vertical, 10)
                .padding(.horizontal, 15)
                .background(Color.white)
                .cornerRadius(10)
                .shadow(color: Color.black.opacity(0.5), radius: 5, x: 5, y: 5)
        })  .padding(15)
            .padding(.bottom,20)
            //Filter Menu
            VStack{
                Spacer()
                VStack(spacing: 18){
                    HStack{
                        Text("Search by")
                            .font(.title2)
                            .foregroundColor(.black)
                            .fontWeight(.bold)
                        
                        Spacer()
                        
                        Button(action: {
                                withAnimation{
                                    showFilter.toggle()
                                }}, label: {
                            Text("Done")
                                .fontWeight(.bold)
                        })
                        
                    }
                    .padding([.horizontal,.top])
                    .padding(.bottom, 10)
                     
                    ForEach(filters){filter in
                        CardView(filter: filter)
                    }
                }
                .padding(.bottom, 10)
                .padding(.bottom, edgesCardview?.bottom)
                .background(Color.white.clipShape(CustomCorner(corners:[.topLeft,.topRight])))
                .offset(y: showFilter ? 0 : UIScreen.main.bounds.height / 2)
            }
            .ignoresSafeArea()
            .background(
                Color.black.opacity(0.3).ignoresSafeArea())
            .opacity(showFilter ? 1 : 0)
            .onTapGesture (perform: {
                withAnimation{
                    showFilter.toggle()
                }
            })
        })

    }
}

struct Location :Identifiable {
    let id = UUID()
    let title: String
    let coordinate: CLLocationCoordinate2D
    let sportsArt: String
}

extension Location {
    static func getLocation() -> [Location] {
        return [
            Location(title: "Café del Sol", coordinate: CLLocationCoordinate2D(latitude: 52.15739695361624, longitude: 9.972962405355746), sportsArt: "Food"),
            Location(title: "Restaurant Sultino", coordinate: CLLocationCoordinate2D(latitude: 52.15610684707034, longitude: 9.95686915196795), sportsArt: "Tennis")
        ]
    }
}
struct CustomCorner : Shape {
    var corners: UIRectCorner
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: 35, height: 35))
        return Path(path.cgPath)
    }
}
