import SwiftUI
import SwiftUIIntrospect
import MapKit

@Observable
final class NavigationRouter {
  var items: [Item] = []
  
  enum Item: Hashable {
    case map
    case user(User)
  }
}

struct SearchView: View {
  enum OrderType: CaseIterable {
    case recommend
    case review
    case newest
    
    var label: LocalizedStringKey {
      switch self {
      case .recommend: "Recommend"
      case .review: "Review"
      case .newest: "Newest"
      }
    }
  }
  
  @State var router = NavigationRouter()
  @State var orderType: OrderType = .recommend
  @State var text = "千葉"
  var users: [User] = [
    .sato,
    .otsuka,
    .miyamoto,
    .yamashita,
    .kiuchi,
    .kato
  ]
  
  var body: some View {
    NavigationStack(path: $router.items) {
      List(users) { user in
        VStack(alignment: .leading) {
          HStack {
            Image(systemName: "person")
              .imageScale(.large)
            VStack(alignment: .leading) {
              HStack {
                Text(user.shop.location.name)
                Text(user.name)
              }
              .bold()
              HStack(spacing: 1) {
                ForEach(0..<5) { _ in
                  Image(systemName: "star.fill")
                    .imageScale(.small)
                    .foregroundStyle(.yellow)
                }
              }
            }
            Spacer()
            Image(systemName: "heart.circle")
              .imageScale(.large)
          }
          
          ScrollView(.horizontal) {
            LazyHStack {
              ForEach(user.imageURLs, id: \.self) { url in
                AsyncImage(url: url) { image in
                  image
                    .resizable()
                    .frame(width: 90, height: 90)
                } placeholder: {
                  ProgressView()
                }
              }
            }
          }
          
          
          HStack {
            HStack {
              Image(systemName: "location.circle")
              Text(user.shop.location.name)
            }
            
            HStack {
              Image(systemName: "building")
              Text(user.shop.name)
            }
          }
        }
        .background(Color.white, in: .capsule)
        .listRowSeparator(.hidden)
      }
      #if !os(macOS)
      .listRowSpacing(10)
      #endif
      .searchable(text: $text)
      .navigationTitle(Text("Search"))
      #if !os(macOS)
      .navigationBarTitleDisplayMode(.inline)
      #endif
      .toolbar {
        ToolbarItem(placement: .primaryAction) {
          Button {
            router.items.append(.map)
          } label: {
            Label {
              Text("Display Map")
            } icon: {
              Image(systemName: "location.circle")
            }
          }
        }
        #if !os(macOS)
        ToolbarItem(placement: .topBarTrailing) {
          Picker("Order Type", selection: $orderType) {
            ForEach(OrderType.allCases, id: \.self) { orderType in
              Text(orderType.label)
            }
          }
        }
        #endif
      }
      .safeAreaInset(edge: .top) {
        ScrollView(.horizontal) {
          HStack {
            Button {
              
            } label: {
              Text("Fee")
            }
            .buttonBorderShape(.capsule)
            .buttonStyle(.bordered)

            Button {
              
            } label: {
              Text("Date")
            }
            .buttonBorderShape(.capsule)
            .buttonStyle(.bordered)
            
            Button {
              
            } label: {
              Text("Location")
            }
            .buttonBorderShape(.capsule)
            .buttonStyle(.bordered)
            
            Button {
              
            } label: {
              Text("Menu")
            }
            .buttonBorderShape(.capsule)
            .buttonStyle(.bordered)
            
            Button {
              
            } label: {
              Text("Detail Search")
            }
            .buttonBorderShape(.capsule)
            .buttonStyle(.bordered)
          }
        }
      }
      .navigationDestination(for: NavigationRouter.Item.self) { item in
        switch item {
        case .map:
          Map()
        case .user(let user):
          Text(user.name)
        }
      }
    }
  }
}

struct User: Identifiable, Hashable {
  var id = UUID()
  var name: LocalizedStringKey
  var shop: Shop
  var imageURLs: [URL] = [
    .init(string: "https://d1wjnekklco6g3.cloudfront.net/resize/420x420/photo/swfQE33uTKajg1g0FY9zh1ahBnOod7Lz/1/afcdea0bb198abfa17165c1f48b693ee9fa8e6d421f31687cc0d062568759305.jpg")!,
    .init(string: "https://d1wjnekklco6g3.cloudfront.net/resize/420x420/photo/u9LVAHEqBWBxR3CAkVkbE4eP91rsqapr/1/53c8ecb2092eb6530b11d62b97891261dd0dcccaf3286a5f5f94c141c43443d1.jpg")!,
    .init(string: "https://d1wjnekklco6g3.cloudfront.net/resize/420x420/photo/2c3Oldkf7HDi1IenKcY6VC4TRWIW8t8N/1/eac71e600809d0b6aeb8f840e9a68d70b0fa4ba015ac211969dddd77ff0683d9.jpg")!,
    .init(string: "https://d1wjnekklco6g3.cloudfront.net/resize/420x420/photo/oyFs520MaBYmZpXUToyRId8TYI8LTYIH/1/5f8db8b7c201d3d7e8f61557802c1524eda9a5359e23f0c67ea631a3faac2990.jpg")!
  ]
}

@MainActor
extension User {
  static let sato = Self(name: "Sato", shop: .salonMixi)
  static let otsuka = Self(name: "Otsuka", shop: .salonMixi)
  static let miyamoto = Self(name: "Miyamoto", shop: .salonMixi)
  static let yamashita = Self(name: "Yamashita", shop: .salonMixi)
  static let kiuchi = Self(name: "Kiuchi", shop: .salonMixi)
  static let kato = Self(name: "Kato", shop: .salonMixi)
}

struct Shop: Identifiable, Hashable {
  var id = UUID()
  var name: LocalizedStringKey
  var location: Location
}

@MainActor
extension Shop {
  static let salonMixi = Self(name: "Salon Mixi at Shibuya", location: .tokyo)
}


struct Location: Identifiable, Hashable {
  var id = UUID()
  let name: LocalizedStringKey
}

extension LocalizedStringKey: @retroactive Hashable {
  public func hash(into hasher: inout Hasher) {
    hasher.combine(self)
  }
}

@MainActor
extension Location {
  static let tokyo = Self(name: "Tokyo")
  static let saiwama = Self(name: "Saitama")
  static let chiba = Self(name: "Chiba")
  static let osaka = Self(name: "Osaka")
  static let kyoto = Self(name: "Kyoto")
}

#Preview {
  SearchView()
    .environment(\.locale, Locale(identifier: "ja_JP"))
}
