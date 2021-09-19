//
//  ImageDetectorUITests.swift
//  ImageDetectorUITests
//
//  Created by Marutharaj K on 16/09/21.
//

import XCTest

class ImageDetectorUITests: XCTestCase {

    let app = XCUIApplication()

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testImageSearchView() throws {
        // UI tests must launch the application that they test.
        app.launch()

        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        let searchBar = app.textFields["FeedSearchIdentifier"]
        XCTAssert(searchBar.exists)
        searchBar.tap()
        searchBar.typeText("Bir")
        dismissKeyboardIfPresent()
        
        let list = app.tables["FeedListIdentifier"]
        XCTAssertTrue(list.waitForExistence(timeout: 10))
       
        let cell = list.cells.element(boundBy: .zero)
        XCTAssertTrue(cell.waitForExistence(timeout: 10))
        sleep(1)
        cell.tap()
    }
    
    func testImageDetailView() throws {
        try testImageSearchView()
                
        let navigationBackImage = app.images["NavigationBackImage"]
        XCTAssertTrue(navigationBackImage.waitForExistence(timeout: 10))

        let navigationTitle = app.staticTexts["NavigationTitle"]
        XCTAssert(navigationTitle.exists)
        
        let navigationShareImage = app.images["NavigationShareImage"]
        XCTAssert(navigationShareImage.exists)
        
        verifyFeedDetailUIElements()
    }
    
    func verifyFeedDetailUIElements() {
        let app = XCUIApplication()

        let feedTitle = app.staticTexts["FeedTitle"]
        XCTAssert(feedTitle.exists)

        let feedTitleValue = app.staticTexts["FeedTitleValue"]
        XCTAssert(feedTitleValue.exists)
        
        let feedDescription = app.staticTexts["FeedDescription"]
        XCTAssert(feedDescription.exists)

        let feedDescriptionValue = app.webViews["FeedDescriptionValue"]
        XCTAssert(feedDescriptionValue.exists)
        
        let feedDateTaken = app.staticTexts["FeedDateTaken"]
        XCTAssert(feedDateTaken.exists)

        let feedDateTakenValue = app.staticTexts["FeedDateTakenValue"]
        XCTAssert(feedDateTakenValue.exists)
        
        let feedDatePublished = app.staticTexts["FeedDatePublished"]
        XCTAssert(feedDatePublished.exists)
        
        let feedDatePublishedValue = app.staticTexts["FeedDatePublishedValue"]
        XCTAssert(feedDatePublishedValue.exists)
        
        let feedAuthor = app.staticTexts["FeedAuthor"]
        XCTAssert(feedAuthor.exists)
        
        let feedAuthorValue = app.staticTexts["FeedAuthorValue"]
        XCTAssert(feedAuthorValue.exists)
        
        let feedTags = app.staticTexts["FeedTags"]
        XCTAssert(feedTags.exists)
        
        let feedTagsValue = app.staticTexts["FeedTagsValue"]
        XCTAssert(feedTagsValue.exists)
    }
    
    func dismissKeyboardIfPresent() {
        let app = XCUIApplication()
        if app.keys.element(boundBy: 0).exists {
            app.typeText("\n")
        }
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
