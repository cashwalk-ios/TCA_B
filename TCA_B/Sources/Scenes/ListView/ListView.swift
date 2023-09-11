//
//  ListView.swift
//  TCA_B
//
//  Created by 이아림 on 2023/08/24.
//

import SwiftUI
import ComposableArchitecture

struct ListView: View {
    @State private var showAlert = false
    @State private var selectedPerson = ""
    let store: StoreOf<ListViewStore>
    var showOption: ShowOption = .second
    var gender: Gender = .male
     
    public init(store: StoreOf<ListViewStore>, showOption: ShowOption, gender: Gender) {
        self.store = store
        self.showOption = showOption
        self.gender = gender
    }
    
    var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            let viewStoreGender = gender == .male ? viewStore.males : viewStore.females
            let columns = showOption == .first ? [GridItem(.flexible())] : [GridItem(.flexible(), spacing: 15), GridItem(.flexible(), spacing: 15)]
            
            ScrollView {
                LazyVGrid(columns: columns, spacing: 20) {
                    ForEach(viewStoreGender, id: \.login.uuid) { person in
                        NavigationLink(destination: DetailView(person: person)) {
                            ListViewCell(showOption: showOption, person: person)
                        }
                        .onLongPressGesture {
                            if viewStoreGender.firstIndex(where: { $0 == person }) != nil {
                                selectedPerson = person.name.last
                                showAlert = true
                            }
                        }
                        .alert(isPresented: $showAlert) {
                            Alert(
                                title: Text(""),
                                message: Text("\(selectedPerson)를 삭제할까요?"),
                                primaryButton: .destructive(Text("삭제")) {
                                    if let index = viewStoreGender.firstIndex(where: { $0.name.last == selectedPerson }) {
                                        viewStore.send(.deleteRow(gender, index))
                                    }
                                },
                                secondaryButton: .cancel(Text("취소"))
                            )
                        }
                        .onAppear {
                            if person.name == viewStoreGender.last?.name {
                                if gender == .male {
                                    viewStore.send(.moreMale)
                                } else {
                                    viewStore.send(.moreFemale)
                                }
                            }
                        }
                    }
                }
            }
            .refreshable {
                print("Refetch data...")
                viewStore.send(.refreshModelData(genderType: gender))
            }
            .scrollIndicators(.hidden)
            .padding(.horizontal, 8)
        }
    }
}

//struct ListView_Previews: PreviewProvider {
//    static var previews: some View {
//        ListView(store: Store(initialState: ListViewStore.State(), reducer: {
//            ListViewStore()
//        }), showOption: .first, gender: .female)
//    }
//}
