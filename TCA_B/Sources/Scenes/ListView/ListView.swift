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
            if showOption == .second {
                let columns = [
                    GridItem(.flexible(), spacing: 15),
                    GridItem(.flexible(), spacing: 15)
                ]
                
                ScrollView {
                    LazyVGrid(columns: columns, spacing: 20) {
                        ForEach(viewStoreGender, id: \.login.uuid) { person in
                            NavigationLink(destination: DetailView(person: person)) {
                                VStack(alignment: .leading) {
                                    AsyncImage(url: URL(string: person.picture.medium)!, placeholder: { Text("Loading ...") })
                                        .environment(\.imageCache, TemporaryImageCache())
                                        .frame(minHeight: 200, maxHeight: 200)
                                        .aspectRatio(contentMode: .fill)
                                        .cornerRadius(20)
                                    VStack(alignment: .leading, spacing: 4) {
                                        Text(person.name.title)
                                            .font(.title)
                                            .lineLimit(1)
                                        Text(person.location.country)
                                            .font(.body)
                                            .lineLimit(1)
                                        Text(verbatim: person.email)
                                            .font(.body)
                                            .lineLimit(1)
                                    }
                                }
                            }
                            .onTapGesture {
                                print("Clicked \(person)")
                                viewStore.send(.clickProfile(model: person))
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
                                .alert(isPresented: $showAlert) {
                                    Alert(
                                        title: Text(""),
                                        message: Text("\(selectedPerson)를 삭제할까요?"),
                                        primaryButton: .destructive(Text("삭제")) {
                                            if let index = viewStore.females.firstIndex(where: { $0.name.last == selectedPerson }) {
                                                // viewStore.males.remove(at: index)
                                                // TODO: viewStore의 해당 index의 남자 데이터 삭제하는 Reduce 추가
                                            }
                                        },
                                        secondaryButton: .cancel(Text("취소"))
                                    )
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
            } else if showOption == .first {
                let columns = [
                    GridItem(.flexible())
                ]
                ScrollView {
                    LazyVGrid(columns: columns, spacing: 20) {
                        ForEach(viewStoreGender, id: \.login.uuid) { person in
                            NavigationLink(destination: DetailView(person: person)) {
                                HStack(alignment: .top) {
                                    AsyncImage(url: URL(string: person.picture.medium)!, placeholder: { Text("Loading ...") })
                                        .environment(\.imageCache, TemporaryImageCache())
                                        .frame(minHeight: 200, maxHeight: 200)
                                        .aspectRatio(contentMode: .fill)
                                        .cornerRadius(20)
                                    VStack(alignment: .leading, spacing: 5) {
                                        Text(person.name.title)
                                            .font(.title)
                                            .lineLimit(1)
                                        Text(person.location.country)
                                            .font(.body)
                                            .lineLimit(1)
                                        Text(verbatim: person.email)
                                            .font(.body)
                                            .lineLimit(1)
                                    }
                                }
                            }
                            .onTapGesture {
                                print("Clicked \(person)")
                                viewStore.send(.clickProfile(model: person))
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
                                .onTapGesture {
                                    print("Clicked \(person)")
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
            } else {
                Text("Invalid showOption value")
            }
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
