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

                    Label("보기옵션: \(showOption)열", systemImage: "text.below.photo")
                        .foregroundColor(.accentColor)
                        .padding(.top, 5)
                        .padding(.trailing, 15.0)
                        .onTapGesture {
                            showOption = (showOption == 2) ? 1 : 2
                            print("보기옵션 클릭 - \(showOption)열")
                        }
                }
                
                TabView(selection: $selectedGender) {
                    MaleView(showOption: $showOption).tag(Gender.male)
                    FemaleView(showOption: $showOption).tag(Gender.female)
                }
                .tabViewStyle(.page(indexDisplayMode: .never))
                .padding(.bottom, 30)
                
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
