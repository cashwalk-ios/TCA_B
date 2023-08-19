//
//  ContentView.swift
//  TCA_B
//
//  Created by 이아림 on 2023/08/08.
//

import SwiftUI

enum Gender: Int {
    case male
    case female
}

struct HomeView: View {
    @State var selectedGender = Gender.male
    @State var showOption = 2
    
    var body: some View {
        NavigationView {
            VStack {
                Picker("성별", selection: $selectedGender) {
                    Text("남자").tag(Gender.male)
                    Text("여자").tag(Gender.female)
                }
                .pickerStyle(.segmented)
                .padding(.horizontal)
                
                HStack {
                    Spacer()
                    ShowOptionMenuView(showOption: $showOption)

//                    Text("보기옵션: \(showOption)열")
//                        .padding(.top, 5)
//                        .padding(.trailing, 15.0)
//                        .onTapGesture {
//                            showOption = (showOption == 2) ? 1 : 2
//                            print("보기옵션 클릭 - \(showOption)열")
//                        }
                }
                
                TabView(selection: $selectedGender) {
                    MaleView().tag(Gender.male)
                    FemaleView().tag(Gender.female)
                }.tabViewStyle(.page(indexDisplayMode: .never))
                    .padding(.bottom, 40)
                
            }
            .navigationBarTitle("랜덤 프로필", displayMode: .inline)
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}

struct ShowOptionMenuView: View {
    @Binding var showOption: Int
    
    var body: some View {
        Menu {
            Button("1열", action: { showOption = 1 })
            Button("2열", action: { showOption = 2 })
        } label: {
            Label("보기옵션: \(showOption)열", systemImage: "text.below.photo")
        }
        .padding([.top, .bottom], 5)
        .padding(.trailing, 15.0)
    }
}
