//
//  EditUserData.swift
//  HilSports
//
//  Created by Dennis Hasselbusch on 13.06.22.
//

import SwiftUI

struct EditUserData : View
{
    //presentationMode to presentate the profile card
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var user : UserModel
    
    var body : some View
    {
        NavigationView
        {
            Form
            {
                UserImageData()
                AboutYouData()
                FavoriteSportsData()
                MoreUserData()
            }
            .environmentObject(user)
            .navigationBarTitle(Text("Profile"))
            .navigationBarItems(trailing: Button( action: {
                self.presentationMode.wrappedValue.dismiss()
            }, label: {Text("Done")}))

        }
    }
}
struct UserImageData : View
{
    @EnvironmentObject var user : UserModel
    
    var body : some View
    {
        Section(header: Text("User Image"))
        {
            HStack
            {
                Image(systemName: "person.crop.circle")
                Button(action: {
                    //set action
                }, label: {
                    Text("Change profile image")
                })
            }
        }
        
    }
}
struct AboutYouData : View
{
    @EnvironmentObject var user : UserModel
    
    var body : some View
    {
        Section(header: Text("About you"))
        {
            VStack
            {
                TextEditor(text: $user.aboutYou)
                    .padding(.horizontal)
            }
        }
        
    }
}

struct FavoriteSportsData : View
{
    @EnvironmentObject var user : UserModel
    @State var myFBAccess = FirebaseAccess()
    
    var body : some View {
        Section(header: Text("Favorite Sports"))
        {
            HStack
            {
                NavigationLink(destination: SportsSelectionData().onAppear{
                    var test = myFBAccess.getSportItems()
                })
                {
                    Text("Change sports")
                }
            }
        }
    }
    /*func setItems()
    {
        for favSports in user.favSports {
            items.append(favSports)
        }
    }*/
}

struct SportsSelectionData : View
{
    @EnvironmentObject var user : UserModel
    @State var selection : [String] = []
    @State var items : [String] = [""]

    var body : some View
    {
        List
        {
            ForEach(self.items, id: \.self)
            { item in
                MultipleSelectionSport(title: item, isSelected: self.selection.contains(item))
                { if self.selection.contains(item)
                    {
                        self.selection.removeAll(where: {$0 == item})
                    } else {
                        self.selection.append(item)
                    }
                }
            }
        }
    }
    

    
}
struct MultipleSelectionSport : View
{
    var title: String
    var isSelected: Bool
    var action: () -> Void
    
    var body : some View
    {
        Button(action: self.action)
        {
            HStack
            {
                Text(self.title)
                if self.isSelected{
                    Spacer()
                    Image(systemName: "checkmark")
                }
            }
        }
    }
}

struct MoreUserData : View
{
    @EnvironmentObject var user : UserModel
    
    var body : some View {
        Section(header: Text("More information"))
        {
            HStack
            {
                Text("Change age..")
                Spacer()
                TextField("to..", text: $user.age)
                    .keyboardType(.decimalPad)
                    .padding()

            }
        }
    }
}


