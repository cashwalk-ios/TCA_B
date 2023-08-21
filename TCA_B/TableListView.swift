//
//  TableListView.swift
//  TCA_B
//
//  Created by 이아림 on 2023/08/21.
//

import SwiftUI

struct TableListView: View {
    @State var cellType: CellType
    let rows = [
        GridItem(.flexible()),
        GridItem(.flexible())]
    let columns = [GridItem(.flexible())]
    let colors: [Color] = [.green, .blue, .brown, .cyan, .gray, .indigo, .mint, .yellow, .orange, .purple,.accentColor, .pink]
    var body: some View {
        if cellType == .column {
            LazyVGrid(columns: columns) {
                ForEach(colors, id: \.self) { color in
                    TableCellView(cellType: cellType, color: color)
                        .background(color)
                }
            }
            .padding(EdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 20))
        } else {
            LazyVGrid(columns: rows) {
                ForEach(colors, id: \.self) { color in
                    TableCellView(cellType: cellType, color: color)
                        .background(color)
                }
            }.padding(EdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 20))
        }
    }
}
