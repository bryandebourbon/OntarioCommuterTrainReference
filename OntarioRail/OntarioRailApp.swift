import Combine
import MapKit
import SwiftUI

@main
struct OntarioRailApp: App {

  var body: some Scene {
    WindowGroup {
      ContentView()
    }
  }
}

struct ContentView: View {
  @StateObject var viewModel = TrainViewModel()
  var body: some View {
    ZStack(alignment: .bottom) {

      MapTrainView(
        train: $viewModel.selectedTrain
      )

      VStack {
        if !viewModel.fetchedTrains.isEmpty {
          TrainPicker(viewModel: viewModel)
        } else {
          Text("No trains available")
        }
      }

    }
  }

}

#Preview{
  ContentView()
}
