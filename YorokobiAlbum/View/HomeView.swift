//
//  HomeView.swift
//  YorokobiAlbum
//
//  Created by 小原宙 on 2023/10/04.
//

import SwiftUI
import SwiftData

struct HomeView: View {
    @Environment(\.modelContext) private var modelContext
    @State private var selectedSortType: SortType
    @State private var presentation: Presentation?

    static private let itemSpacing = 12.0
    private let columns = [GridItem(.adaptive(minimum: 160, maximum: 200), spacing: itemSpacing)]

    @State private var sortOrder = [SortDescriptor<Item>]()
    @State private var showItemList = true

    init() {
        let sortTypeNum = UserDefaults.standard.integer(forKey: "sortType")
        selectedSortType = SortType(rawValue: sortTypeNum) ?? .dateDesc
        sortOrder = selectedSortType.sortOrder
    }

    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVGrid(columns: columns, spacing: Self.itemSpacing) {
                    if showItemList {
                        ItemList(sort: sortOrder, presentation: $presentation)
                    }
                }
                .padding(.horizontal, Self.itemSpacing)
            }
            .background(Color(UIColor.secondarySystemBackground))
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Menu {
                        Picker(selection: $selectedSortType) {
                            ForEach(SortType.allCases, id: \.self) { type in
                                Text(type.description)
                                    .tag(type)
                            }
                        } label: {
                            EmptyView()
                        }
                    } label: {
                        Image(systemName: "arrow.up.and.down.text.horizontal")
                    }
                    .onChange(of: selectedSortType) { _, type in
                        showItemList = false
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                            sortOrder = type.sortOrder
                        }
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                            showItemList = true
                        }
                        UserDefaults.standard.set(type.rawValue, forKey: "sortType")
                    }
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: {
                        presentation = .addItem
                    }){
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(item: $presentation) { $0 }
            .animation(.easeOut(duration: 0.15), value: showItemList)
        }
    }
}

extension HomeView {
    enum Presentation: View, Hashable, Identifiable {
        case addItem
        case itemDetail(_ item: Item)

        var id: Self { self }

        var body: some View {
            switch self {
            case .addItem:
                PhotoSelectView()
            case .itemDetail(let item):
                ItemDetailView(item: item)
            }
        }
    }

    private enum SortType: Int, Hashable, CaseIterable {
        case dateDesc
        case dateAsc
        case starDesc
        case starAsc

        var sortOrder: [SortDescriptor<Item>] {
            switch self {
            case .dateDesc: [SortDescriptor(\Item.createdAt, order: .reverse)]
            case .dateAsc: [SortDescriptor(\Item.createdAt)]
            case .starDesc: [SortDescriptor(\Item.rate, order: .reverse), SortDescriptor(\Item.createdAt, order: .reverse)]
            case .starAsc: [SortDescriptor(\Item.rate), SortDescriptor(\Item.createdAt, order: .reverse)]
            }
        }

        var description: String {
            switch self {
            case .dateDesc: "新しい順"
            case .dateAsc: "古い順"
            case .starDesc: "スターが多い順"
            case .starAsc: "スターが少ない順"
            }
        }
    }
}

//#Preview {
//    let items: [Item] = [
//        Item(imageData: UIImage.sample1.pngData()!, title: "title1", rate: 3, createdAt: Date()),
//        Item(imageData: UIImage.sample2.pngData()!, title: "title2", rate: 4, createdAt: Date()),
//        Item(imageData: UIImage.sample3.pngData()!, title: "title3", rate: 2, createdAt: Date()),
//        Item(imageData: UIImage.sample4.pngData()!, title: "title4", rate: 5, createdAt: Date()),
//        Item(imageData: UIImage.sample5.pngData()!, title: "title5", rate: 1, createdAt: Date()),
//        Item(imageData: UIImage.sample6.pngData()!, title: "title6", rate: 4, createdAt: Date())
//    ]
//
//    return HomeView(items: items)
//}
