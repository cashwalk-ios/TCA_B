//
//  MaleView.swift
//  TCA_B
//
//  Created by 김광록 on 2023/08/19.
//

import SwiftUI

struct MaleView: View {
    
    @Binding var showOption: Int
    
    let data = Array(1...100).map { "Person \($0)" }
    
    var body: some View {
        if showOption == 2 {
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
                    }
                }
            }
            .refreshable {
                print("Refetch data...")
            }
            .scrollIndicators(.hidden)
            .padding(.horizontal, 8)
        } else if showOption == 1 {
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


struct MaleView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
