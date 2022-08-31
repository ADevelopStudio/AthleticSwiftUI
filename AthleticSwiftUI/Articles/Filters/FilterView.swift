//
//  FilterView.swift
//  AthleticSwiftUI
//
//  Created by Dmitrii Zverev on 31/8/2022.
//

import SwiftUI

struct FilterView: View {
    @StateObject fileprivate var viewModel =  FilterViewModel()
    @State var type: ArticleFilterPickerType
    @Binding var isPresented: Bool
    @Binding var selectedFilter: ArticleFilter?
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Button {
                    isPresented = false
                } label: {
                    Image(systemName: "xmark")
                        .resizable()
                        .foregroundColor(.gray)
                        .frame(width: 25, height: 25)
                        .padding(.horizontal, 30)
                        .padding(.top, 10)
                }
            }
            .padding()
            
            switch viewModel.loadingState {
            case .loaded(let resultArray):
                if resultArray.isEmpty {
                    VStack(spacing: 15) {
                        Image(systemName: "exclamationmark.triangle.fill")
                            .symbolRenderingMode(.multicolor)
                            .resizable()
                            .scaledToFit()
                            .frame(height: 80)
                        Text("No result found")
                            .font(.title2)
                    }
                } else {
                    List(resultArray, id: \.id) { value in
                        FilterListView(filteringValue: value)
                            .onTapGesture {
                                switch type {
                                case .team:
                                    selectedFilter = .byTeam(id: value.id)
                                case .league:
                                    selectedFilter = .byLeague(id: value.id)
                                case .author:
                                    selectedFilter = .byAuthor(id: value.id)
                                }
                                isPresented = false
                            }
                    }
                }
            case .failedToUpdate(let error):
                VStack(spacing: 15) {
                    Spacer()
                    Image(systemName: "xmark.icloud")
                        .symbolRenderingMode(.multicolor)
                        .resizable()
                        .scaledToFit()
                        .frame(height: 80)
                    Text(error)
                        .font(.headline)
                    Button("Try again") {
                        Task {
                            await self.viewModel.fetchResults(type: self.type)
                        }
                    }
                    Spacer()
                }
            case .loading:
                Spacer()
                ProgressView()
                    .scaleEffect(2)
                Spacer()
            }
        }
        .task {
            await self.viewModel.fetchResults(type: self.type)
        }
    }
}

struct FilterView_Previews: PreviewProvider {
    static var previews: some View {
        FilterView(type: .league, isPresented: .constant(true), selectedFilter: .constant(nil))
    }
}
