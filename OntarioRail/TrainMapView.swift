import MapKit
import SwiftUI

struct TrainMapView: View {

  @ObservedObject var fetcher: UUIDFetcher<ApiResponse>

  var train: UUIDWrapper? {
    return fetcher.cachedUUIDs[fetcher.selectedLine]
  }

  var region: MKCoordinateRegion {
    return MKCoordinateRegion(
      center:  //train?.currentLocation ??
        CLLocationCoordinate2D(
          latitude: (train?.currentLocation.latitude ?? 0) - 0.15,
          longitude: (train?.currentLocation.longitude ?? 0) + 0.0
        ),
      span: MKCoordinateSpan(
        latitudeDelta: 0,
        longitudeDelta: 0
      )  //  700000
    )
  }

  var body: some View {
    if let unwrappedTrain = train {
      Map(
        bounds:
          MapCameraBounds(
            centerCoordinateBounds: region,
            minimumDistance: 100000
          )
      ) {
        Marker(
          unwrappedTrain.description,
          coordinate: unwrappedTrain.currentLocation
        )
      }
    }

  }

  private var trains: [UUIDWrapper] {
    if let selectedTrain = fetcher.cachedUUIDs[fetcher.selectedLine] {
      return [selectedTrain]
    }
    return []
  }

}
