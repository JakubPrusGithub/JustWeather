//
//  WeatherViewVCTests.swift
//  JustWeatherTests
//
//  Created by Jakub Prus on 05/05/2023.
//

import XCTest
@testable import JustWeather

// Naming Structure: test_UnitOfWork_StateUnderTest_ExpectedBehaviour

// Testing Structure: Given, When, Then

final class WeatherViewVCTests: XCTestCase {
    let weather = MockWeatherProvider()

    override func setUpWithError() throws { }

    override func tearDownWithError() throws { }
    func test_WeatherViewVC_getCurrentDate_correctlyInitiates() {
        // Given
        let weather = MockWeatherProvider()
        // When
        let viewController = WeatherViewVC(weatherSource: weather)
        // Then
        XCTAssertNotNil(viewController.weatherSource)
    }
    func test_WeatherViewVC_getCurrentDate_correctlyReturns() {
        // Given
        let viewController = WeatherViewVC(weatherSource: weather)
        // When
        let answer: String = viewController.getCurrentDate()
        // Then
        XCTAssertNotNil(answer)
    }
    func test_WeatherViewVC_generateURL_correctlyReturnsURL() {
        // Given
        let viewController = WeatherViewVC(weatherSource: weather)
        let lat: Double = 99.9
        let lon: Double = 9.9
        // When
        let answer: URL = viewController.generateURL(lat: lat, lon: lon)
        // Then
        XCTAssertNotNil(answer)
    }
}
