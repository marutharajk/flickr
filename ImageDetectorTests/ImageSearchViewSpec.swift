//
//  ImageSearchViewSpec.swift
//  ImageDetectorTests
//
//  Created by Marutharaj K on 18/09/21.
//

import XCTest

@testable import ImageDetector

// MARK: - Type - ImageSearchViewSpec -

/**
 ImageSearchViewSpec will verify image search view elements
*/
class ImageSearchViewSpec: XCTestCase {
        
    // MARK: - Test Methods -
    
    /// Verify UI Elements
    func testVerifyUIElements() throws {
        let subject = ImageSearchView()
        
        MockData.shared.isSuccessResponse = true
        MockData.shared.jsonFileName = UnitTestParams.StubJSONFileName.feedsSuccess.rawValue
        
        let viewModel = PublicFeedViewModel(networkAdapter: NetworkAdapter(), tags: "bird")
        while viewModel.publicFeed == nil {}
                
        let contentView = try subject.inspect().vStack()
        let tagTitle = try contentView.text(.zero)
        let searchBar = try contentView.view(SearchBar.self, 1)
        let feedList = try contentView.list(2)
        let feedItem = try feedList.forEach(.zero)
        let feedItemCell = subject.listItem(viewModel.publicFeed?.items?.first ?? PublicFeedItems())
        let feedItemCellContentView = try feedItemCell.inspect().hStack(.zero)
        let feedImage = try feedItemCellContentView.view(AsyncImage<ActivityIndicator>.self, .zero)
        let feedShortDetailStack = try feedItemCellContentView.vStack(1)
        let feedPublishedTitle = try feedShortDetailStack.text(.zero)
        let feedPublishedValue = try feedShortDetailStack.text(1)
        let feedPublishedString = try feedPublishedValue.string()
        let feedAuthorTitle = try feedShortDetailStack.text(3)
        let feedAuthorValue = try feedShortDetailStack.text(4)
        let feedAuthorString = try feedAuthorValue.string()

        XCTAssertNotNil(contentView)
        XCTAssertNotNil(tagTitle)
        XCTAssertNotNil(searchBar)
        XCTAssertNotNil(feedList)
        XCTAssertNotNil(feedItem)
        XCTAssertNotNil(feedItemCell)
        XCTAssertNotNil(feedItemCellContentView)
        XCTAssertNotNil(feedImage)
        XCTAssertNotNil(feedShortDetailStack)
        XCTAssertNotNil(feedPublishedTitle)
        XCTAssertNotNil(feedPublishedValue)
        XCTAssertEqual(feedPublishedString, "Sep 17, 2021")
        XCTAssertNotNil(feedAuthorTitle)
        XCTAssertNotNil(feedAuthorValue)
        XCTAssertEqual(feedAuthorString, "Bernie Tuffs - PhotoArtist")
    }
}
