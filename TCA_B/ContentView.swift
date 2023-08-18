//
//  ContentView.swift
//  TCA_B
//
//  Created by 이아림 on 2023/08/08.
//

import SwiftUI

struct ContentView: View {
    @State var selectIndex = 0
    
    var body: some View {
        TabView {
            Text("남자")
                .tabItem {
                    Text("남자")
                }
            Text("여자")
                .tabItem {
                    Text("여자")
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
