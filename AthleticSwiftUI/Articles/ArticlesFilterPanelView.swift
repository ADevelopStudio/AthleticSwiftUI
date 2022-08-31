//
//  ArticlesFilterPanelView.swift
//  AthleticSwiftUI
//
//  Created by Dmitrii Zverev on 31/8/2022.
//

import SwiftUI

struct ArticlesFilterPanelView: View {
    @Binding var selectedFilterType: ArticleFilterPickerType
    @Binding var showingPickFilterValueModal: Bool
    @State var needToShowReset: Bool
    
    var onReset: (() -> Void)
    
    var body: some View {
        HStack {
            ForEach(ArticleFilterPickerType.allCases) { type in
                Spacer()
                Button {
                    selectedFilterType = type
                    showingPickFilterValueModal = true
                } label: {
                    Text(type.buttonTitle)
                }
            }
            
            if needToShowReset {
                Spacer()
                Button {
                    onReset()
                } label: {
                    Text("Reset")
                        .foregroundColor(.red)
                }
                Spacer()
            } else {
                Spacer()
            }
        }
    }
}

