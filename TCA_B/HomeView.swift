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
    @State var selectGender = Gender.male
    @State var showOption = 2
    
    var body: some View {
        NavigationView {
            VStack {
                Picker("성별", selection: $selectGender) {
                    Text("남자").tag(Gender.male)
                    Text("여자").tag(Gender.female)
                }
                .pickerStyle(.segmented)
                
                HStack {
                    Spacer()
                    Text("보기옵션: \(showOption)열")
                        .padding(.top, 5)
                        .padding(.trailing, 15.0)
                        .onTapGesture {
                            showOption = (showOption == 2) ? 1 : 2
                            print("보기옵션 클릭 - \(showOption)열")
                        }
                }
                
                TabView(selection: $selectGender) {
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
