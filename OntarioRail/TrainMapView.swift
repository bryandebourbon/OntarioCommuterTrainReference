import MapKit
import SwiftUI

struct MapTrainView: View {
  @Binding var train: Trip?

  var body: some View {
    // Attempt to unwrap all optionals
    if let unwrappedTrain = train {
      // All values are present, render the map
      mapWithMarker(
        title: unwrappedTrain.description, latitude: unwrappedTrain.latitude,
        longitude: unwrappedTrain.longitude)
    } else {
      // Fallback content when one or more values are missing
      Text("Location data not available.")
    }
  }

  // Private view builder function for map
  private func mapWithMarker(title: String, latitude: Double, longitude: Double) -> some View {
    Map(
//      bounds: MapCameraBounds(centerCoordinateBounds:MKMapRect()
//        )
    ) {
      Marker(
        title,
        coordinate:
          CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
      )
    }
  }
}
