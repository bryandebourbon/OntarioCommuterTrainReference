import Combine
import Foundation

class TrainViewModel: ObservableObject {
  @Published var fetchedTrains: [Trip] = []
  @Published var selectedTrain: Trip?

  init() {
    Task {
      await fetchTrains()
    }
  }

  func fetchTrains() async {
    let urlString = "https://on-request-example-ikwdloanhq-uc.a.run.app"
    guard let url = URL(string: urlString) else {
      print("Invalid URL")
      return
    }

    do {
      let (data, _) = try await URLSession.shared.data(from: url)
      let response = try JSONDecoder().decode(ApiResponse.self, from: data)
      DispatchQueue.main.async { [weak self] in
        self?.fetchedTrains = response.trips.trip
        self?.selectedTrain = response.trips.trip.first
      }
    } catch {
      DispatchQueue.main.async {
        print("Error fetching trains: \(error.localizedDescription)")
      }
    }
  }
}
