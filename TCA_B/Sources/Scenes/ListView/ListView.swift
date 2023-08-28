//
//  ListView.swift
//  TCA_B
//
//  Created by 이아림 on 2023/08/24.
//

import SwiftUI
import ComposableArchitecture

struct ListView: View {
    let store: StoreOf<ListViewStore>
    var cellType: CellType = .two
    @State var personList: [ResultModel] = []
     
    
    var body: some View {
        WithViewStore(self.store, observe: {$0}) { viewStore in
            if cellType == .two {
                let columns = [
                    GridItem(.flexible(), spacing: 15),
                    GridItem(.flexible(), spacing: 15)
                ]
                
                ScrollView {
                    LazyVStack(alignment: .center, spacing: 10) {
                        Button("버튼") {
                            viewStore.send(.clickMale)
                        }
                        LazyVGrid(columns: columns, spacing: 20) {
                            ForEach(viewStore.males,id: \.login.uuid) { person in
                                VStack(alignment: .leading) {
                                    Rectangle()
                                        .fill(Color.yellow)
                                        .frame(height: 200)
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
                                .onTapGesture {
                                    print("Clicked \(person)")
                                }
                            }
                        }
                    }
                    
                }
                .refreshable {
                    print("Refetch data...")
                }
                .scrollIndicators(.hidden)
                .padding(.horizontal, 8)
            } else if cellType == .one {
                let columns = [
                    GridItem(.flexible())
                ]
                
                ScrollView {
                    LazyVGrid(columns: columns, spacing: 20) {
                        ForEach(viewStore.males, id: \.login.uuid) { person in
                            HStack(alignment: .top) {
                                Rectangle()
                                    .fill(Color.blue)
                                    .frame(width: 100, height: 100)
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
                                Spacer()
                            }
                            .onTapGesture {
                                print("Clicked \(person)")
                            }
                        }
                    }
                }
                .refreshable {
                    print("Refetch data...")
                }
                .scrollIndicators(.hidden)
                .padding(.horizontal, 8)
            } else {
                Text("Invalid showOption value")
            }
            
            
        }
    }
}


struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
