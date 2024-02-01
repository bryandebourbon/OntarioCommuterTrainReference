import SwiftUI

struct UUIDFilteredView: View {
  @ObservedObject var fetcher: UUIDFetcher<ApiResponse>
  var selectedLine: TrainLine
  var selectedStop: TrainStop

  var body: some View {
    List {
      ForEach(
        fetcher.cachedUUIDs.values.filter {
          $0.lineCode == selectedLine &&
          ($0.nextStop == selectedStop
           || $0.prevStop == selectedStop.rawValue
          )
        }.sorted { $0.description < $1.description }, id: \.id
      ) { uuidWrapper in
        Button(action: {
          fetcher.selectedLine = uuidWrapper.id
        }) {
          VStack(alignment: .leading) {
            Text(uuidWrapper.description)
            Text("Direction: \(uuidWrapper.variantDir)")
            Text("Cars: \(uuidWrapper.cars)s")

            Text("First Stop:\(uuidWrapper.firstStop )")
            Text("Final Stop:\(uuidWrapper.finalStop )")
            Text("Arrival Time:\(uuidWrapper.routeEndTime )")

            Text("Prev Stop: \(uuidWrapper.prevStop )")
            Text("Next Stop: \(uuidWrapper.nextStop.rawValue)")
            Text("isInMotion: \(uuidWrapper.isInMotion.description)")
            Text("delay: \(uuidWrapper.delay.description)s")

          }.tag(uuidWrapper.id)
        }
      }
    }
  }
}
