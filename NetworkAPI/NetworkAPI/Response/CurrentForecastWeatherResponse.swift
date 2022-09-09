import Foundation

// MARK: - DailyForecastWeatherResponse
public struct CurrentForecastWeatherResponse: Codable {
    let coord: Coord?
  public let weather: [Weather]?
    let base: String?
  public let main: Main?
    let visibility: Int?
    let wind: Wind?
    let clouds: Clouds?
    let dt: Int?
    let sys: Sys?
    let timezone, id: Int?
    let name: String?
    let cod: Int?
}
