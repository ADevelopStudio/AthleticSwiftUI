//
//  FilterListView.swift
//  AthleticSwiftUI
//
//  Created by Dmitrii Zverev on 31/8/2022.
//

import SwiftUI

struct FilterListView: View {
    @State var filteringValue: Filterable
    
    var body: some View {
        HStack {
            Text(filteringValue.name)
                .font(.title3)
            Spacer()
        }
        .padding()
    }
}

struct FilterListView_Previews: PreviewProvider {
    static var previews: some View {
        FilterListView(filteringValue: Team.example)
    }
}
