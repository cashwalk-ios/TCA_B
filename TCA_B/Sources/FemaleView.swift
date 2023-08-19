//
//  FemaleView.swift
//  TCA_B
//
//  Created by 김광록 on 2023/08/19.
//

import SwiftUI

struct FemaleView: View {
    
    let data = Array(1...100).map {"Person \($0)"}
    
    let columns = [
        GridItem(.flexible())
    ]
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 20) {
                ForEach(data, id: \.self) { i in
                    HStack(alignment: .top) {
                        Rectangle()
                            .fill(Color.blue)
                            .frame(width: 100, height: 100)
                            .cornerRadius(20)
                        VStack(alignment: .leading, spacing: 5) {
                            Text(i).font(.title)
                            Text("Country").font(.body)
                            Text("kim.kwangrok@cashwalk.io").font(.body)
                        }
                        Spacer()
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

struct FemaleView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
