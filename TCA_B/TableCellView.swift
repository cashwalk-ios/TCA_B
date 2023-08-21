//
//  TableCell.swift
//  TCA_B
//
//  Created by 이아림 on 2023/08/21.
//
 
import SwiftUI

struct TableCellView: View {
    @State var cellType: CellType = .column
    var color: Color = .clear
    var body: some View {
        if cellType == .row {
            VStack(spacing: 5){
                Image(systemName: "circle")
                    .resizable()
                    .frame(height: 150)
                    .foregroundColor(.white)
                Text("name")
                    .font(.system(size: 15, weight: .bold))
                Text("country")
                    .font(.system(size: 13, weight: .medium))
                Text("email")
                    .font(.system(size: 13, weight: .medium))

            }
            .padding(EdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10))
        } else {
            HStack {
                Image(systemName: "circle")
                    .resizable()
                    .frame(width: 100, height: 100, alignment: .leading)
                    .foregroundColor(.white)
                VStack(spacing: 5) {
                    Text("name")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .font(.system(size: 15, weight: .bold))
                    Text("countrydddddddddddddddddddd")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .font(.system(size: 13, weight: .medium))
                    Text("email")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .font(.system(size: 13, weight: .medium))
                }
                .frame(width: .infinity, alignment: .leading)
                .background(.pink)
                Spacer()
            }
            .padding(EdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10))
        }
        
    }
}
