//
//  ListView.swift
//  TCA_B
//
//  Created by 김광록 on 2023/08/19.
//

import SwiftUI

struct ListView: View {
    
    @Binding var showOption: ShowOption
    @State private var data = Array(1...100).map { "Person \($0)" }
    @State private var showAlert = false
    @State private var selectedPerson = ""
    
    var body: some View {
        if showOption == .second {
            let columns = [
                GridItem(.flexible(), spacing: 15),
                GridItem(.flexible(), spacing: 15)
            ]
            
            ScrollView {
                LazyVGrid(columns: columns, spacing: 20) {
                    ForEach(data, id: \.self) { i in
                        VStack(alignment: .leading) {
                            Rectangle()
                                .fill(Color.yellow)
                                .frame(height: 200)
                                .cornerRadius(20)
                            VStack(alignment: .leading, spacing: 4) {
                                Text(i)
                                    .font(.title)
                                    .lineLimit(1)
                                Text("Country")
                                    .font(.body)
                                    .lineLimit(1)
                                Text(verbatim: "kim.kwangrok@cashwalk.io")
                                    .font(.body)
                                    .lineLimit(1)
                            }
                        }
                        .onTapGesture {
                            print("Clicked \(i)")
                        }
                        .onLongPressGesture {
                            if data.firstIndex(where: { $0 == i }) != nil {
                                selectedPerson = i
                                showAlert = true
                            }
                        }
                        .alert(isPresented: $showAlert) {
                            Alert(
                                title: Text(""),
                                message: Text("\(selectedPerson)를 삭제할까요?"),
                                primaryButton: .destructive(Text("삭제")) {
                                    if let index = data.firstIndex(where: { $0 == selectedPerson }) {
                                        data.remove(at: index)
                                    }
                                },
                                secondaryButton: .cancel(Text("취소"))
                            )
                        }
                        
                    }
                }
            }
            .refreshable {
                print("Refetch data...")
            }
            .scrollIndicators(.hidden)
            .padding(.horizontal, 8)
        } else if showOption == .first {
            let columns = [
                GridItem(.flexible())
            ]
            
            ScrollView {
                LazyVGrid(columns: columns, spacing: 20) {
                    ForEach(data, id: \.self) { i in
                        HStack(alignment: .top) {
                            Rectangle()
                                .fill(Color.blue)
                                .frame(width: 100, height: 100)
                                .cornerRadius(20)
                            VStack(alignment: .leading, spacing: 5) {
                                Text(i)
                                    .font(.title)
                                    .lineLimit(1)
                                Text("Country")
                                    .font(.body)
                                    .lineLimit(1)
                                Text(verbatim: "kim.kwangrok@cashwalk.io")
                                    .font(.body)
                                    .lineLimit(1)
                            }
                            Spacer()
                        }
                        .onTapGesture {
                            print("Clicked \(i)")
                        }
                        .onLongPressGesture {
                            if data.firstIndex(where: { $0 == i }) != nil {
                                selectedPerson = i
                                showAlert = true
                            }
                        }
                        .alert(isPresented: $showAlert) {
                            Alert(
                                title: Text(""),
                                message: Text("\(selectedPerson)를 삭제할까요?"),
                                primaryButton: .destructive(Text("삭제")) {
                                    if let index = data.firstIndex(where: { $0 == selectedPerson }) {
                                        data.remove(at: index)
                                    }
                                },
                                secondaryButton: .cancel(Text("취소"))
                            )
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

struct DetailView: View {
    var body: some View {
        VStack {
            Text("Detail View")
        }
    }
}
