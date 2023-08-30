//
//  ContentView.swift
//  TCA_B
//
//  Created by 이아림 on 2023/08/08.
//

import SwiftUI
import ComposableArchitecture

enum ShowOption: Int, Equatable {
    case first = 1
    case second = 2
}

struct HomeView: View {
    let store: StoreOf<HomeViewStore>
    @State var showOption: ShowOption = .second
    
    var body: some View {
        WithViewStore(self.store, observe: \.selectedGender) { viewStore in
            NavigationView {
                VStack {
                    Picker("성별", selection: viewStore.binding(send: HomeViewStore.Action.switchGender)) {
                        Text("남자").tag(Gender.male)
                        Text("여자").tag(Gender.female)
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
                            self.store.withState { state in
                                Label("보기옵션: \(state.showOption.rawValue)열", systemImage: state.showOption == .second ? "text.below.photo" : "list.dash")
                            }
                        }
                        .padding(.vertical, 5)
                        .padding(.trailing, 15.0)
                    }
                    
                    TabView(selection: viewStore.binding(send: HomeViewStore.Action.switchGender)) {
                        ListView(store: Store(initialState: ListViewStore.State(), reducer: {
                            ListViewStore()
                        }), showOption: .second, gender: .male).tag(Gender.male)
                        ListView(store: Store(initialState: ListViewStore.State(), reducer: {
                            ListViewStore()
                        }), showOption: .second, gender: .female).tag(Gender.female)
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

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(store: Store(initialState: HomeViewStore.State(), reducer: {
            HomeViewStore()
        }))
    }
}
