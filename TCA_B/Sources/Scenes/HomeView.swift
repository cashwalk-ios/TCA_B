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

enum ShowOption: Int {
    case first = 1
    case second = 2
}

struct HomeView: View {
    @State var selectedGender = Gender.male
    @State var showOption: ShowOption = .second
    
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
                    
                    Menu {
                        Button {
                            showOption = .first
                        } label: {
                            Label("1열", systemImage: "list.dash")
                        }
                        Button {
                            showOption = .second
                        } label: {
                            Label("2열", systemImage: "text.below.photo")
                        }
                    } label: {
                        Label("보기옵션: \(showOption.rawValue)열", systemImage: showOption == .second ? "text.below.photo" : "list.dash")
                    }
                    .padding([.top, .bottom], 5)
                    .padding(.trailing, 15.0)
                }
                
                TabView(selection: $selectedGender) {
                    MaleView(showOption: $showOption).tag(Gender.male)
                    FemaleView(showOption: $showOption).tag(Gender.female)
                }
                .tabViewStyle(.page(indexDisplayMode: .never))
                .overlay(alignment: .bottom, content: {
                    GradationView()
                })
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
