import SwiftUI


struct UUIDPickerView: View {
  @ObservedObject var selection: UUIDFetcher<ApiResponse>
  var selectedLine: TrainLine

  var body: some View {
    Picker("Select an id", selection: $selection.selectedUUID) {
      ForEach(selection.cachedUUIDs.values.filter { $0.lineCode == selectedLine }.sorted { $0.description < $1.description }, id: \.id) { uuidWrapper in
        Text(uuidWrapper.description).tag(uuidWrapper.id)
      }
    }
  }
}
