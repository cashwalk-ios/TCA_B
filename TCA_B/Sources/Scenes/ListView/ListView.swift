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
            let columns = showOption == .first ? [GridItem(.flexible(), spacing: 15), GridItem(.flexible(), spacing: 15)] : [GridItem(.flexible())]
            
            ScrollView {
                LazyVGrid(columns: columns, spacing: 20) {
                    ForEach(viewStoreGender, id: \.login.uuid) { person in
                        NavigationLink(destination: DetailView(person: person)) {
                            listViewCell(showOption: showOption, person: person)
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

struct listViewCell: View {
    var showOption: ShowOption?
    var person: ResultModel?
    var body: some View {
        if let person = person {
            if showOption == .second {
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
            } else {
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
