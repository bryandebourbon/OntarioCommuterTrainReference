import Combine
import Foundation
import MapKit

struct UUIDWrapper: Identifiable & Equatable & Hashable & CustomStringConvertible {

  let id = UUID()
  var description: String
  var finalStop: String
  var prevStop:String
  var nextStop: String
  var currentLocation: CLLocationCoordinate2D
  var trip:Trip

  static func == (
    lhs: UUIDWrapper,
    rhs: UUIDWrapper) -> Bool {
      return lhs.id == rhs.id
    }

  func hash(into hasher: inout Hasher) {
    hasher.combine(id)
  }
}
