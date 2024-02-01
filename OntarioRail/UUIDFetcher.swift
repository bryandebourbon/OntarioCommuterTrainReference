import Combine
import Foundation
import MapKit

class UUIDFetcher<T: Codable>: ObservableObject {

  @Published var stopCodeFiltered: [UUID] = []
  @Published var lineCodeFiltered: [UUID] = []
  @Published var selectedLine: UUID = UUID()
  @Published var selectedStop: UUID = UUID()
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
          firstStop: $0.firstStopCode,
          finalStop: $0.lastStopCode,
          variantDir: $0.variantDir,
          cars: $0.cars,
          routeStartTime: $0.startTime,
          routeEndTime: $0.endTime,
          compassCourse: $0.course,
          capacity: "n/a",
          prevStop: $0.atStationCode ?? "",
          nextStop: TrainStop(rawValue: $0.nextStopCode) ?? TrainStop.MA,
          atStation: $0.atStationCode ?? "",
          isInMotion: $0.isInMotion,
          delay: $0.delaySeconds,
          currentLocation: CLLocationCoordinate2D(
            latitude: $0.latitude,
            longitude: $0.longitude
          ),
          lineCode: TrainLine(rawValue: $0.lineCode) ?? TrainLine.BL,
          trip: $0
        )
      }

      self.cachedUUIDs = mappedTrains.reduce(into: [UUID: UUIDWrapper]()) {
        (dict, train) in dict[train.id] = train
      }

      if let selectedTrain = mappedTrains.first {
        self.selectedLine = selectedTrain.id
      }
    }
  }
}
