//
//  DetailView.swift
//  TCA_B
//
//  Created by Minhyun Cho on 2023/09/02.
//

import SwiftUI
import ComposableArchitecture

struct DetailView: View {
    
    var person: ResultModel? = nil
    @State private var scale: CGFloat = 1.0
    init(person: ResultModel?) {
      self.person = person
    }
    var body: some View {
        if let picture = person?.picture.large {
            AsyncImage(url: URL(string: picture)!, placeholder: { Text("Loading ...") })
                .environment(\.imageCache, TemporaryImageCache())
                .frame(maxWidth:.infinity, maxHeight: .infinity)
                .scaledToFit()
                .scaleEffect(scale)
                .gesture(
                    MagnificationGesture()
                        .onChanged{ value in
                let currAmount = value - 1
                scale = 1 + currAmount
              }
          )
      }
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(person: nil)
    }
}
