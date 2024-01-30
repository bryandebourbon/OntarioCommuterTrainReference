import Foundation



// Top-level structure
struct ApiResponse: Codable {
//  let metadata: Metadata
  let trips: TripsContainer

  enum CodingKeys: String, CodingKey {
    // case metadata = "Metadata" // Uncomment or handle Metadata if needed
    case trips = "Trips" // Ensure this matches the JSON structure
  }
}

// Metadata information
//struct Metadata: Codable {
//  let timeStamp: String
//  let errorCode: String
//  let errorMessage: String
//
//  enum CodingKeys: String, CodingKey {
//    case timeStamp = "TimeStamp"
//    case errorCode = "ErrorCode"
//    case errorMessage = "ErrorMessage"
//  }
//}

// Container for the trips array
struct TripsContainer: Codable {
  let trips: [Trip]

  enum CodingKeys: String, CodingKey {
    case trips = "Trip"
  }
}

// Individual trip information
struct Trip: Codable & Hashable {
  let cars: String
  let tripNumber: String
  let startTime: String
  let endTime: String
  let lineCode: String
  let routeNumber: String
  let variantDir: String
  let display: String?
  let latitude: Double
  let longitude: Double
  let isInMotion: Bool
  let delaySeconds: Int
  let course: Double
  let firstStopCode: String
  let lastStopCode: String
  let prevStopCode: String
  let nextStopCode: String
  let atStationCode: String?
  let modifiedDate: String

  enum CodingKeys: String, CodingKey {
    case cars = "Cars"
    case tripNumber = "TripNumber"
    case startTime = "StartTime"
    case endTime = "EndTime"
    case lineCode = "LineCode"
    case routeNumber = "RouteNumber"
    case variantDir = "VariantDir"
    case display = "Display"
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
