//
//  ModelView.swift
//  CustomTopNavigationBar
//
//  Created by Anas Hamad on 7/25/24.
//

import Foundation
import SwiftUI

struct TopNavigationBar: View {

    @Environment(\.dismiss) var dissmes
    let title :String
    let showBtn : Bool
    let navColor : Color
    let backButtonColor : Color
    var body: some View {
        HStack{
            if showBtn{
                backButton()
                    
            }else{
                backButton()
                    .opacity(0)
            }
               
            Spacer()
            titleLabel(title: title)
                .padding()
                
                
            Spacer()
            backButton()
                .opacity(0)
        }
        .background(navColor)
        
        

    }
    
    private func backButton() -> some  View {
        Button  {
            dissmes()
        } label: {
          Image(systemName: "chevron.left")
                .foregroundStyle(backButtonColor)
        }
        .padding(.horizontal)
    }
    
    private func titleLabel(title:String) -> some View {
        Text(title)
             .font(.title)
             .fontWeight(.semibold)
    }
    
}


struct CustomTopNavBarContainerViewController<Content:View>: View {
    
    let content : Content
   
    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
    
    @State var title :String = ""
    @State  var showBtn : Bool = false
    @State var navColor : Color = .white
    @State var backButtonColor : Color = .white
    var body: some View {
        VStack(spacing:0){
            TopNavigationBar(title: title, showBtn: showBtn, navColor:  navColor,backButtonColor:backButtonColor)
            content
                .frame(maxWidth: .infinity,maxHeight: .infinity)
        }
        .onPreferenceChange(CustomNavTitlePrefrenceKeyed.self, perform: { value in
            self.title = value
        })
        .onPreferenceChange(CustomNavBackBTNPrefrenceKeyed.self, perform: { value in
            self.showBtn = !value
        })
        .onPreferenceChange(CustomNavColorPrefrenceKeyed.self, perform: { value in
            self.navColor = value
        })
        .onPreferenceChange(CustomNavBackButtonColorPrefrenceKeyed.self, perform: { value in
            self.backButtonColor = value
        })
    }
}


struct CustomNavView<Content:View>: View{
    
    let content : Content
    
    init(@ViewBuilder content: ()-> Content) {
        self.content = content()
    }
    var body: some View{
        NavigationStack{
            CustomTopNavBarContainerViewController {
                content
                    .ignoresSafeArea()
            }
            
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .toolbar(.hidden)
    }

}


struct CustomNavLink<Label:View,Destination:View> :View {
    let destination : Destination
    let lable : Label
    
    init( destination: () -> Destination, @ViewBuilder label: () -> Label){
        
        self.destination = destination()
        self.lable = label()
    }
    
    var body: some View{
        NavigationLink {
            CustomNavView {
                destination
            }
            .toolbar(.hidden)
        } label: {
            lable
        }

    }
}


struct CustomNavTitlePrefrenceKeyed : PreferenceKey{
    static var defaultValue:   String = ""
    
    static func reduce(value: inout String, nextValue: () -> String) {
        value = nextValue()
    }
}
struct CustomNavBackBTNPrefrenceKeyed : PreferenceKey{
    static var defaultValue:   Bool = false
    
    static func reduce(value: inout Bool, nextValue: () -> Bool) {
        value = nextValue()
    }
    
}
struct CustomNavColorPrefrenceKeyed : PreferenceKey{
    static var defaultValue:   Color = .white
    
    static func reduce(value: inout Color, nextValue: () -> Color) {
        value = nextValue()
    }
    
}

struct CustomNavBackButtonColorPrefrenceKeyed : PreferenceKey{
    static var defaultValue:   Color = .blue
    
    static func reduce(value: inout Color, nextValue: () -> Color) {
        value = nextValue()
    }
    
}


extension View {
    
    func customNavigationTitle (_ title : String) -> some View{
        preference(key:CustomNavTitlePrefrenceKeyed.self,value: title)
    }
    func customNavigationBackBottun(_ hidden : Bool) -> some View{
        preference(key:CustomNavBackBTNPrefrenceKeyed.self,value: hidden)
    }
    func customNavigationColor(_ color : Color) -> some View{
        preference(key:CustomNavColorPrefrenceKeyed.self,value: color)
    }
    func customBackButtonColor(_ color : Color) -> some View{
        preference(key:CustomNavBackButtonColorPrefrenceKeyed.self,value: color)
    }
}

extension UINavigationController {
    open override func viewDidLoad() {
        super.viewDidLoad()
        interactivePopGestureRecognizer?.delegate = nil
    }
}
