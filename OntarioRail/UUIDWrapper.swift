import Combine
import Foundation
import MapKit

struct UUIDWrapper: Identifiable & Equatable & Hashable & CustomStringConvertible {
  let id = UUID()
  var description: String

  var firstStop: String
  var finalStop: String
  var variantDir: String
  var cars: String

  var routeStartTime: String // Date
  var routeEndTime: String //Date
  var compassCourse: Double
  var capacity: String



  var prevStop: String
  var nextStop: TrainStop
  var atStation: String
  var isInMotion:Bool
  var delay:Int // seconds

  var currentLocation: CLLocationCoordinate2D
  var lineCode: TrainLine
  var trip: Trip


  static func == (
    lhs: UUIDWrapper,
    rhs: UUIDWrapper) -> Bool {
      return lhs.id == rhs.id
    }

  func hash(into hasher: inout Hasher) {
    hasher.combine(id)
  }
}
