//
//  ImageDetailViewSpec.swift
//  ImageDetectorTests
//
//  Created by Marutharaj K on 18/09/21.
//

import XCTest

@testable import ImageDetector

// MARK: - Type - ImageDetailViewSpec -

/**
 ImageDetailViewSpec will verify image detail view elements
*/
class ImageDetailViewSpec: XCTestCase {
        
    // MARK: - Test Methods -
    
    /// Verify UI Elements
    func testVerifyUIElements() throws {
        MockData.shared.isSuccessResponse = true
        MockData.shared.jsonFileName = UnitTestParams.StubJSONFileName.feedsSuccess.rawValue
        
        let viewModel = PublicFeedViewModel(networkAdapter: NetworkAdapter(), tags: "bird")
        while viewModel.publicFeed == nil {}
                
        let subject = ImageDetailView(feedItem: viewModel.publicFeed?.items?.first ?? PublicFeedItems())
        
        let contentView = try subject.inspect().vStack()
        let navigationHeader = try contentView.hStack(.zero)
        let navigationHeaderBackImage = try navigationHeader.image(.zero)
        let navigationHeaderTitle = try navigationHeader.text(2)
        let navigationHeaderTitleString = try navigationHeaderTitle.string()
        let navigationHeaderShareImage = try navigationHeader.image(4)

        let feedImage = try contentView.view(AsyncImage<ActivityIndicator>.self, 1)
        let feedDescriptionContentView = try contentView.vStack(2)

        let feedTitle = try feedDescriptionContentView.hStack(.zero).text(.zero)
        let feedTitleValue = try feedDescriptionContentView.hStack(.zero).text(1)
        let feedTitleString = try feedTitleValue.string()
        
        let feedResolution = try feedDescriptionContentView.hStack(1).text(.zero)
        let feedResolutionValue = try feedDescriptionContentView.hStack(1).text(1)
        let feedResolutionString = try feedResolutionValue.string()

        let feedDescription = try feedDescriptionContentView.hStack(2).text(.zero)
        let feedDescriptionValue = try feedDescriptionContentView.hStack(2).view(HTMLStringView.self, 1)
        
        let feedDateTaken = try feedDescriptionContentView.hStack(3).text(.zero)
        let feedDateTakenValue = try feedDescriptionContentView.hStack(3).text(1)
        let feedDateTakenValueString = try feedDateTakenValue.string()
        
        let feedDatePublished = try feedDescriptionContentView.hStack(4).text(.zero)
        let feedDatePublishedValue = try feedDescriptionContentView.hStack(4).text(1)
        let feedDatePublishedValueString = try feedDatePublishedValue.string()
        
        let feedAuthor = try feedDescriptionContentView.hStack(5).text(.zero)
        let feedAuthorValue = try feedDescriptionContentView.hStack(5).text(1)
        let feedAuthorValueString = try feedAuthorValue.string()
        
        XCTAssertNotNil(contentView)
        XCTAssertNotNil(navigationHeader)
        XCTAssertNotNil(navigationHeaderBackImage)
        XCTAssertNotNil(navigationHeaderTitle)
        XCTAssertEqual(navigationHeaderTitleString, "Feed Detail")
        XCTAssertNotNil(navigationHeaderShareImage)
        
        XCTAssertNotNil(feedImage)
        XCTAssertNotNil(feedDescriptionContentView)
        
        XCTAssertNotNil(feedTitle)
        XCTAssertNotNil(feedTitleValue)
        XCTAssertEqual(feedTitleString, "Bernie Tuffs - Bedtime Story")
        
        XCTAssertNotNil(feedResolution)
        XCTAssertNotNil(feedResolutionValue)
        XCTAssertEqual(feedResolutionString, "240w x 240h")
        
        XCTAssertNotNil(feedDescription)
        XCTAssertNotNil(feedDescriptionValue)
        
        XCTAssertNotNil(feedDateTaken)
        XCTAssertNotNil(feedDateTakenValue)
        XCTAssertEqual(feedDateTakenValueString, "2021-09-17T07:04:40-08:00")
        
        XCTAssertNotNil(feedDatePublished)
        XCTAssertNotNil(feedDatePublishedValue)
        XCTAssertEqual(feedDatePublishedValueString, "2021-09-17T12:46:51Z")
        
        XCTAssertNotNil(feedAuthor)
        XCTAssertNotNil(feedAuthorValue)
        XCTAssertEqual(feedAuthorValueString, "nobody@flickr.com (\"Bernie Tuffs - PhotoArtist\")")
    }
}
