import Foundation

// Top-level structure representing the entire JSON response
struct ApiResponse: Codable {
//  let metadata: Metadata
  let trips: TripsContainer

  enum CodingKeys: String, CodingKey {
//    case metadata = "Metadata"
    case trips = "Trips"
  }
}

struct TripsContainer: Codable {
  let trip: [Trip]

  enum CodingKeys: String, CodingKey {
    case trip = "Trip"
  }
}

// Detailed trip information
struct Trip: Codable & Identifiable & Hashable & CustomStringConvertible
{
  var cars: String
  var id: String
  var startTime: String
  var endTime: String
  var lineCode: String
  var routeNumber: String
  var variantDir: String
  var description: String
  var latitude: Double
  var longitude: Double
  var isInMotion: Bool
  var delaySeconds: Int
  var course: Double
  var firstStopCode: String
  var lastStopCode: String
  var prevStopCode: String
  var nextStopCode: String
  var atStationCode: String?
  var modifiedDate: String

  enum CodingKeys: String, CodingKey {
    case cars = "Cars"
    case id = "TripNumber"
    case startTime = "StartTime"
    case endTime = "EndTime"
    case lineCode = "LineCode"
    case routeNumber = "RouteNumber"
    case variantDir = "VariantDir"
    case description = "Display"
    case latitude = "Latitude"
    case longitude = "Longitude"
    case isInMotion = "IsInMotion"
    case delaySeconds = "DelaySeconds"
    case course = "Course"
    case firstStopCode = "FirstStopCode"
    case lastStopCode = "LastStopCode"
    case prevStopCode = "PrevStopCode"
    case nextStopCode = "NextStopCode"
    case atStationCode = "AtStationCode"
    case modifiedDate = "ModifiedDate"
  }
}
extension Trip: Equatable {
  static func == (lhs: Trip, rhs: Trip) -> Bool {
    return lhs.id == rhs.id
  }
}
