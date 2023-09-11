//
//  ListViewCell.swift
//  TCA_B
//
//  Created by Minhyun Cho on 2023/09/11.
//

import SwiftUI

struct ListViewCell: View {
    var showOption: ShowOption?
    var person: ResultModel?
    
    var body: some View {
        if let person = person {
            if showOption == .first {
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

struct ListViewCell_Previews: PreviewProvider {
    static var previews: some View {
        ListViewCell()
    }
}
