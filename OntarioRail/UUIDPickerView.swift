import SwiftUI


struct UUIDPickerView: View {

  @ObservedObject var selection: UUIDFetcher<ApiResponse>

  var body: some View {
    Picker("Select an id", selection: $selection.selectedUUID) {
      ForEach(Array(selection.cachedUUIDs.keys.sorted()), id: \.self) { key in
        Text(selection.cachedUUIDs[key]?.description ?? "Unknown Train").tag(key)
      }
    }
  }
}
