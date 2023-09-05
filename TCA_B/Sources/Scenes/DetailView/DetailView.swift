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
    
    init(person: ResultModel?) {
        self.person = person
    }
    
    var body: some View {
        Text(person?.cell ?? "")
        Text(person?.email ?? "")
        Text(person?.gender ?? "")
        Text(person?.phone ?? "")
        Text(person?.name.title ?? "")
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(person: nil)
    }
}
