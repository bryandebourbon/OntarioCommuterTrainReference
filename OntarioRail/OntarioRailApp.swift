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
  var body: some View {
    ZStack(alignment: .bottom) {
      TrainMapView(fetcher: fetcher)
      SlidingToastOverlay {
        VStack {
          UUIDPickerView(selection: fetcher).padding()
          if let selectedTrain {
            //            Text("\(selectedTrain.description)")
            Text("Previous Stop: \(selectedTrain.prevStop)")
            Text("Next Stop: \(selectedTrain.nextStop)")
            Text("Final Stop: \(selectedTrain.finalStop)")
          }
        }
      }
    }
  }
}
#Preview{
  ContentView()
}
