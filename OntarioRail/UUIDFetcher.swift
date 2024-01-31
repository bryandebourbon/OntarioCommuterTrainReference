import Combine
import Foundation
import MapKit

class UUIDFetcher<T: Codable>: ObservableObject {

  @Published var selectedUUID: UUID = UUID()
  @Published var cachedUUIDs: [UUID: UUIDWrapper] = [:]

  let urlString = "https://on-request-example-ikwdloanhq-uc.a.run.app"
//  let uuidCompletion: () -> Void

  init() {
    Task.init {
      await self.fetch()
    }
  }

  func fetch() async {
    //print("Starting to fetch...")

    guard let url = URL(string: urlString) else {
      //print("Invalid URL")
      return
    }

    do {
      let (data, _) = try await URLSession.shared.data(from: url)
      let response = try JSONDecoder().decode(T.self, from: data)
      await MainActor.run {
        uuidCompletion(response: response as! ApiResponse)

      }
    } catch {
      //print("Error fetching trains: \(error.localizedDescription)")
    }
    @Sendable func uuidCompletion(response: ApiResponse) {
      let mappedTrains = response.trips.trips.map {
        UUIDWrapper(
          description: $0.display ?? "",
          finalStop: $0.lastStopCode,
          prevStop: $0.prevStopCode,
          nextStop: $0.nextStopCode,
          currentLocation: CLLocationCoordinate2D(
            latitude: $0.latitude,
            longitude: $0.longitude
          ),
          trip: $0
        )
      }

      self.cachedUUIDs = mappedTrains.reduce(into: [UUID: UUIDWrapper]()) {
        (dict, train) in dict[train.id] = train
      }

      if let selectedTrain = mappedTrains.first {
        self.selectedUUID = selectedTrain.id
      }
    }
  }
}

