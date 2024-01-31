import SwiftUI

enum TrainLine: String, CaseIterable, Identifiable {
  case BL
  case KT
  case LE
  case LW
  case MI
  case RH
  case ST
  case UP
  var id: Self { self }
}

struct RegionalTrainLinePicker: View {
  @State private var selectedLine: TrainLine = .BL

    var body: some View {
      VStack {
        Picker("TrainLine", selection: $selectedLine) {
          ForEach(TrainLine.allCases) { trainLine in
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

#Preview {
    RegionalTrainLinePicker()
}
