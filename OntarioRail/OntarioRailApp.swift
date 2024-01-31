import Combine
import MapKit
import SwiftUI

@main
struct OntarioRailApp: App {
  var body: some Scene {
    WindowGroup {
      ZStack {
        ContentView()
      }
    }
  }
}

struct ContentView: View {
  @StateObject var fetcher = UUIDFetcher<ApiResponse>()
  var selectedTrain: UUIDWrapper? {
    return fetcher.cachedUUIDs[fetcher.selectedUUID]
  }

  func reflectingTripProperties() -> [(name: String, value: String)] {
    guard let train = selectedTrain?.trip else { return [] }
    let mirror = Mirror(reflecting: train)
    return mirror.children.compactMap { child in
      guard let propertyName = child.label else { return nil }
      let propertyValue = String(describing: child.value)
      return (name: propertyName, value: propertyValue)
    }
  }

  @State var selectedLine: TrainLine = .BL
  var body: some View {


    ZStack(alignment: .bottom) {
      TrainMapView(fetcher: fetcher)
      SlidingToastOverlay {
        VStack {

          RegionalTrainLinePicker(selectedLine: $selectedLine).padding()
          UUIDPickerView(selection: fetcher, selectedLine: selectedLine).padding()
          if let _ = selectedTrain {
            List {
              ForEach(reflectingTripProperties(), id: \.name) { property in
                Text("\(property.name): \(property.value)")
              }
            }
          }
        }
      }
    }
  }
}
#Preview{
  ContentView()
}
