import SwiftUI
import MapKit

struct IdentifiableCoordinate: Identifiable {
  let id = UUID()
  let name: String
  var coordinate: CLLocationCoordinate2D
}

struct MapTrainView: View {
  // Array of identifiable coordinates
  @Binding var trains: [IdentifiableCoordinate]

  var body: some View {
    Map{
      ForEach(trains) { train in
        Marker(train.name, coordinate: train.coordinate)
      }
    }
  }

  private func regionForCoordinates() -> MKCoordinateRegion {
    var minLat = 90.0
    var maxLat = -90.0
    var minLon = 180.0
    var maxLon = -180.0

    for item in trains {
      let location = item.coordinate
      minLat = min(minLat, location.latitude)
      maxLat = max(maxLat, location.latitude)
      minLon = min(minLon, location.longitude)
      maxLon = max(maxLon, location.longitude)
    }

    let center = CLLocationCoordinate2D(latitude: (minLat + maxLat) / 2,
                                        longitude: (minLon + maxLon) / 2)
    let span = MKCoordinateSpan(latitudeDelta: (maxLat - minLat) * 1.1,
                                longitudeDelta: (maxLon - minLon) * 1.1)
    return MKCoordinateRegion(center: center, span: span)
  }
}


