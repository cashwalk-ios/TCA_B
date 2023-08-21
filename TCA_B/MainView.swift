//
//  ContentView.swift
//  TCA_B
//
//  Created by 이아림 on 2023/08/08.
//

import SwiftUI

enum CellType {
    case column // 1개씩
    case row // 2개씩
}

enum ScreenSize {
    static let width = UIScreen.main.bounds.width
    static let height = UIScreen.main.bounds.height
}

struct MainView: View {
    @State var cellType: CellType = .row
    
    var body: some View {
        VStack{
//            GeometryReader { geometry in
            Spacer().frame(height: 1)
                HStack {
                    Button("남자") {
                        
                    }.frame(width: ScreenSize.width/2)
                    Divider()
                    Button("여자") {
                        
                    }.frame(width: ScreenSize.width/2)
                }
                .background(.yellow)
                .frame(height: 50)
//            }
            
            ScrollView(.vertical) {
                TableListView(cellType: .column)
            }.frame(maxHeight: .infinity)
                .background(.red)
            
            Spacer().frame(height: 1)
        }
        
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
