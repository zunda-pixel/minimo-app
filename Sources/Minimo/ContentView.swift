import SwiftUI

struct ContentView: View {
  @State var selectedTab: TabItem = .home
  
  @ViewBuilder
  func tabContent(_ tab: TabItem) -> some View {
    switch tab {
    case .home: HomeView()
    case .search: SearchView()
    case .snapshot: Text("Snapshot")
    case .message: Text("Message")
    case .favorite: Text("Favorite")
    }
  }
  
  var body: some View {
    TabView(selection: $selectedTab) {
      ForEach(TabItem.allCases, id: \.self) { tab in
        tabContent(tab)
          .tabItem {
            Label {
              Text(tab.item.name)
            } icon: {
              Image(systemName: tab.item.image)
                .environment(\.symbolVariants, tab == selectedTab ? .fill : .none)
            }
          }
      }
    }
  }
}

enum TabItem: String, CaseIterable {
  case home
  case search
  case snapshot
  case message
  case favorite
  
  struct Item {
    var name: LocalizedStringKey
    var image: String
  }
  
  var item: Item {
    switch self {
    case .home: Item(name: "Home", image: "house")
    case .search: Item(name: "Search", image: "magnifyingglass")
    case .snapshot: Item(name: "Snapshot", image: "photo.on.rectangle.fill")
    case .message: Item(name: "Message", image: "envelope")
    case .favorite: Item(name: "Favorite", image: "heart")
    }
  }
}

#Preview {
  ContentView()
    .environment(\.locale, .init(identifier: "jp_JP"))
}
