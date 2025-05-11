import SwiftUI

struct Category: Identifiable {
  var id = UUID()
  var name: LocalizedStringKey
  var icon: String
}


struct HomeView: View {
  @Environment(\.locale) var locale

  let categories: [Category] = [
    .init(name: "Hair", icon: "scissors"),
    .init(name: "Nail", icon: "hand.raised.fingers.spread"),
    .init(name: "Eyelash", icon: "eyes"),
    .init(name: "EyeBrow", icon: "eyebrow"),
    .init(name: "Relax", icon: "waterbottle.fill"),
    .init(name: "Diagnosis", icon: "waveform.path.ecg.text.clipboard.rtl"),
  ]
  
  var popularCategoriesSection: some View {
    Section {
      ScrollView(.horizontal) {
        HStack {
          ForEach(categories) { category in
            VStack {
              Circle()
                .frame(width: 60, height: 60)
                .foregroundStyle(.secondary)
                .overlay {
                  Circle()
                    .frame(width: 58, height: 58)
                    .foregroundStyle(.white)
                    .overlay {
                      Image(systemName: category.icon)
                        .foregroundStyle(.tint)
                        .imageScale(.large)
                    }
                }
              Text(category.name)
                .font(.caption)
            }
          }
        }
      }
      .listRowSeparator(.hidden)
    } header: {
      Text("Popular Categories")
    }
  }
  
  var findFromDateSection: some View {
    Section {
      HStack {
        HStack(spacing: 0) {
          Text("Today")
          Text(Date.now, format: .dateTime.month(.defaultDigits).day())
        }
        .padding(.vertical, 13)
        .padding(.horizontal, 25)
        .background {
          RoundedRectangle(cornerRadius: 24)
            .stroke(.secondary, lineWidth: 1)
        }
        Spacer()
        
        HStack(spacing: 0) {
          let date = Date.now.addingTimeInterval(60 * 60 * 24 * 2)
          Text("Tommorow")
          Text(date, format: .dateTime.month(.defaultDigits).day())
        }
        .padding(.vertical, 13)
        .padding(.horizontal, 25)
        .background {
          RoundedRectangle(cornerRadius: 24)
            .stroke(.secondary, lineWidth: 1)
        }
        Spacer()
        
        HStack(spacing: 0) {
          let date = Date.now.addingTimeInterval(60 * 60 * 24 * 2)
          let weekdaySymbol: String = {
            var calendar = Calendar.current
            calendar.locale = locale
            let weekday =  calendar.component(.weekday, from: date)
            return calendar.weekdaySymbols[weekday-1]
          }()
          
          Text(weekdaySymbol)
          Text(date, format: .dateTime.month(.defaultDigits).day())
        }
        .padding(.vertical, 13)
        .padding(.horizontal, 25)
        .background {
          RoundedRectangle(cornerRadius: 24)
            .stroke(.secondary, lineWidth: 1)
        }
      }
      .font(.caption)
      .listRowSeparator(.hidden)
      
      Button {
        
      } label: {
        HStack {
          Image(systemName: "magnifyingglass")
          Text("Input and search")
        }
          .frame(maxWidth: .infinity)
      }
      .buttonStyle(.borderedProminent)
      .buttonBorderShape(.capsule)
      .listRowSeparator(.hidden)

      HStack {
        Button {
          print("Reserve History")
        } label: {
          Label {
            Text("Reserve History")
          } icon: {
            Image(systemName: "book.pages")
          }
            .frame(maxWidth: .infinity)
        }
        .buttonStyle(.plain)
        
        Divider()
        
        Button {
          print("View History")
        } label: {
          Label {
            Text("View History")
          } icon: {
            Image(systemName: "clock")
          }
          .frame(maxWidth: .infinity)
        }
        .buttonStyle(.plain)
      }
      .alignmentGuide(.listRowSeparatorLeading) { _ in -20 }
    } header: {
      Text("Find from Date")
    }
  }
  
  var popularMenuSection: some View {
    Section {
      VStack {
        HStack {
          Button {
            
          } label: {
            Text("""
Cut +
Hair Color
""")
            .foregroundStyle(.white)
            .bold()
            .padding(.leading, 10)
            .frame(maxWidth: .infinity, minHeight: 60, alignment: .leading)
            .background(
              LinearGradient(
                gradient: Gradient(colors: [Color.cyan, Color.cyan, Color.cyan.opacity(0.6)]),
                startPoint: .init(x: 0.1, y: 0.1),
                endPoint: .init(x: 0.7, y: 0.7)
              ),
              in: .rect(cornerRadius: 10)
            )
          }
          Button {
            
          } label: {
            Text("Nail")
              .foregroundStyle(.white)
              .bold()
              .padding(.leading, 10)
              .frame(maxWidth: .infinity, minHeight: 60, alignment: .leading)
              .background(
                LinearGradient(
                  gradient: Gradient(colors: [Color.pink, Color.pink, Color.pink.opacity(0.6)]),
                  startPoint: .init(x: 0.1, y: 0.1),
                  endPoint: .init(x: 0.7, y: 0.7)
                ),
                in: .rect(cornerRadius: 10)
              )
          }
        }
        
        HStack {
          Button {
            
          } label: {
            Text("Eyelash")
              .foregroundStyle(.white)
              .bold()
              .padding(.leading, 10)
              .frame(maxWidth: .infinity, minHeight: 60, alignment: .leading)
              .background(
                LinearGradient(
                  gradient: Gradient(colors: [Color.gray, Color.gray, Color.gray.opacity(0.6)]),
                  startPoint: .init(x: 0.1, y: 0.1),
                  endPoint: .init(x: 0.7, y: 0.7)
                ),
                in: .rect(cornerRadius: 10)
              )
          }
          .buttonStyle(.plain)

          Button {
            
          } label: {
            Text("Relax")
              .foregroundStyle(.white)
              .bold()
              .padding(.leading, 10)
              .frame(maxWidth: .infinity, minHeight: 60, alignment: .leading)
              .background(
                LinearGradient(
                  gradient: Gradient(colors: [Color.orange, Color.orange, Color.orange.opacity(0.6)]),
                  startPoint: .init(x: 0.1, y: 0.1),
                  endPoint: .init(x: 0.7, y: 0.7)
                ),
                in: .rect(cornerRadius: 10)
              )
          }
        }
      }
      .listRowSeparator(.hidden)
    } header: {
      Text("Popular Menus")
    }
  }
  
  
  var body: some View {
    NavigationStack {
      List {
        Section {
          
        } header: {
          Text("Informations")
        }
        
        popularCategoriesSection
        
        findFromDateSection
        
        Section {
          
        } header: {
          Text("Special feature")
        }
        
        Section {
          
        } header: {
          Text("Recommend salon staff members")
        }
        
        popularMenuSection
      }
        .listStyle(.plain)
        .listSectionSpacing(0)
        .navigationTitle("Home")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
          ToolbarItem(placement: .principal) {
            Text("minimo")
              .foregroundStyle(.cyan)
              .font(.title2)
              .bold()
          }
          ToolbarItem(placement: .primaryAction) {
            Image(systemName: "person.crop.circle")
          }
        }
    }
  }
}

#Preview {
  HomeView()
    .environment(\.locale, .init(identifier: "ja_JP"))
}
