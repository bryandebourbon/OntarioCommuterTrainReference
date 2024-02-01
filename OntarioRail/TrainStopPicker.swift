import SwiftUI

enum TrainStop: String, CaseIterable, Identifiable {
  case KT = "KT"
  case MP
  case BR
  case MA
  case EN
  case WS
  case BL
  case UN
  var id: Self { self }
}



struct TrainStopPicker: View {
  @Binding var selectedStop: TrainStop

  var body: some View {
    VStack {
      Picker("TrainStop", selection: $selectedStop) {
        ForEach(TrainStop.allCases) { trainLine in
          Text(trainLine.rawValue.uppercased())
          //              .overlay(
          //                Color("\(trainLine.rawValue.uppercased())")
          //              )
        }
      }
    }
    .pickerStyle(.segmented)
  }
}


//#Preview{
//  TrainStopPicker(selection: <#UUIDFetcher<ApiResponse>#>, selectedStop: .constant(.MA))
//}
