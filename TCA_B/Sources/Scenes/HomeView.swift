//
//  ContentView.swift
//  TCA_B
//
//  Created by 이아림 on 2023/08/08.
//

import SwiftUI
import ComposableArchitecture

extension HomeViewStore.State: Equatable {
    static func == (lhs: HomeViewStore.State, rhs: HomeViewStore.State) -> Bool {
        return true
    }
}

enum ShowOption: Int {
    case first = 1
    case second = 2
}

struct HomeView: View {
    let store: StoreOf<HomeViewStore>
    
//    @State var selectedGender = GenderTab.male
    @State var showOption: ShowOption = .second
    
    var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            NavigationView {
                VStack {
                    Picker("성별", selection: viewStore.binding(get: \.selectedGender, send: HomeViewStore.Action.switchGender)) {
                        Text("남자").tag(GenderTab.male)
                        Text("여자").tag(GenderTab.female)
                    }
                    .pickerStyle(.segmented)
                    .padding(.horizontal)
                    
                    HStack {
                        Spacer()
                        
                        Menu {
                            Button {
                                viewStore.send(.showOptionTapped(.first))
                            } label: {
                                Label("1열", systemImage: "list.dash")
                            }
                            Button {
                                viewStore.send(.showOptionTapped(.second))
                            } label: {
                                Label("2열", systemImage: "text.below.photo")
                            }
                        } label: {
                            Label("보기옵션: \(viewStore.showOption.rawValue)열", systemImage: viewStore.showOption == .second ? "text.below.photo" : "list.dash")
                        }
                        .padding(.vertical, 5)
                        .padding(.trailing, 15.0)
                    }
                    
                    TabView(selection: viewStore.binding(get: \.selectedGender, send: HomeViewStore.Action.switchGender)) {
                        ListView(showOption: $showOption).tag(GenderTab.male)
                        ListView(showOption: $showOption).tag(GenderTab.female)
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
}
