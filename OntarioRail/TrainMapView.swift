import MapKit
import SwiftUI

struct TrainMapView: View {

  @ObservedObject var fetcher: UUIDFetcher<ApiResponse>

  var train: UUIDWrapper? {
    return fetcher.cachedUUIDs[fetcher.selectedUUID]
  }

  var region: MKCoordinateRegion {
    return MKCoordinateRegion(
      center: train?.currentLocation
        ?? CLLocationCoordinate2D(latitude: 43.644535, longitude: -79.490000),
      span: MKCoordinateSpan(
        latitudeDelta: 0, longitudeDelta: 0) //  700000
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
    if let selectedTrain = fetcher.cachedUUIDs[fetcher.selectedUUID] {
      return [selectedTrain]
    }
    return []
  }

}
