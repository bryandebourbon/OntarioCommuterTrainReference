import SwiftUI

struct TrainPicker: View {
  @ObservedObject var viewModel: TrainViewModel

  var body: some View {

    Picker("Select a Train", selection: $viewModel.selectedTrain) {
      ForEach(viewModel.fetchedTrains) { trip in
        Text(trip.description).tag(trip as Trip?)
      }
    }.background {
      RoundedRectangle(cornerRadius: 10)
    }

    .onAppear {
      Task {
        await viewModel.fetchTrains()
      }
    }
  }
}
