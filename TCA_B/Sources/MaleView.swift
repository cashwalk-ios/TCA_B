//
//  MaleView.swift
//  TCA_B
//
//  Created by 김광록 on 2023/08/19.
//

import SwiftUI

struct MaleView: View {
    
    let data = Array(1...100).map {"Person \($0)"}
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
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
                            Text("kim.kwangrok@cashwalk.io")
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
        .scrollIndicators(.hidden)
        .padding(.horizontal, 8)
    }
}

struct MaleView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
