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

    func test_WeatherViewVC_getCurrentDate_correctlyReturns() {
        // Given
        let vc = WeatherViewVC(weatherSource: weather)
        
        // When
        let answer = vc.getCurrentDate()
        
        // Then
        XCTAssertNotNil(answer)
    }
    
}
