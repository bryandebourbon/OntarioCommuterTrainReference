import Combine
import MapKit
import SwiftUI
import Vortex

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
    return fetcher.cachedUUIDs[fetcher.selectedLine]
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

  @State var selectedLine: TrainLine = .KT
  @State var selectedStop: TrainStop = .MA

//  // The function to filter stop values
//  private func filterStops() {
//    // Filter trains whose stops match the selected stop
//    let filteredTrains = fetcher.cachedUUIDs.values.filter { train in
//      train.prevStop == selectedStop.rawValue ||
//      train.nextStop == selectedStop.rawValue ||
//      train.atStation == selectedStop.rawValue
//    }
//
//    // Process the filtered trains as needed
//    // For example, print them for now
//    for train in filteredTrains {
//      print("Filtered Train: \(train.description)")
//    }
//  }




  var body: some View {


    ZStack(alignment: .bottom) {
      TrainMapView(fetcher: fetcher)
      SlidingToastOverlay {
        VStack {
//          VortexViewReader { proxy in
//            VortexView(.confetti) {
//              Rectangle()
//                .fill(.white)
//                .frame(width: 16, height: 16)
//                .tag("square")
//
//              Circle()
//                .fill(.white)
//                .frame(width: 16)
//                .tag("circle")
//            }
//
//            Button("Burst", action: proxy.burst)
//          }

          RegionalTrainLinePicker(selectedLine: $selectedLine)

          TrainStopPicker(selectedStop: $selectedStop)

          UUIDFilteredView(
            fetcher: fetcher,
            selectedLine: selectedLine,
            selectedStop: selectedStop
          )



//          Text(": \(selectedTrain?.isInMotion)")


        }.padding()
      }
    }

  }
}
#Preview{
  ContentView()
}
