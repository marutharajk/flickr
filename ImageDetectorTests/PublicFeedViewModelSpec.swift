//
//  PublicFeedViewModelSpec.swift
//  ImageDetectorTests
//
//  Created by Marutharaj K on 17/09/21.
//

import XCTest

@testable import ImageDetector

// MARK: - Type - PublicFeedViewModelSpec -

/**
 PublicFeedViewModelSpec will verify 'feeds' service request and response
*/
class PublicFeedViewModelSpec: XCTestCase {
    
    var subject: PublicFeedViewModel?
    
    // MARK: - Test Methods -
    
    /// Verify 'feeds' service success response
    func testVerifyFeedsSuccess() {
                
        MockData.shared.isSuccessResponse = true
        MockData.shared.jsonFileName = UnitTestParams.StubJSONFileName.feedsSuccess.rawValue
        
        subject = PublicFeedViewModel(networkAdapter: NetworkAdapter(), tags: "bird")
        
        while subject?.publicFeed == nil {}
        
        let publicFeed = subject?.publicFeed
        XCTAssertEqual(publicFeed?.title, "Recent Uploads tagged forest and bird")
        XCTAssertEqual(publicFeed?.link, "https://www.flickr.com/photos/")
        XCTAssertEqual(publicFeed?.description, "")
        XCTAssertEqual(publicFeed?.modified, "2021-09-17T12:46:51Z")
        XCTAssertEqual(publicFeed?.generator, "https://www.flickr.com")
        XCTAssertEqual(publicFeed?.items?.count, 20)
        
        let publicFeedItem = subject?.publicFeed?.items?.first
        XCTAssertEqual(publicFeedItem?.title, "Bernie Tuffs - Bedtime Story")
        XCTAssertEqual(publicFeedItem?.link, "https://www.flickr.com/photos/73666725@N07/51486249563/")
        XCTAssertEqual(publicFeedItem?.media?.keys.first, "m")
        XCTAssertEqual(publicFeedItem?.media?.values.first, "https://live.staticflickr.com/65535/51486249563_26c33098b5_m.jpg")
        XCTAssertEqual(publicFeedItem?.date_taken, "2021-09-17T07:04:40-08:00")
        XCTAssertEqual(publicFeedItem?.description, " <p><a href=\"https://www.flickr.com/people/73666725@N07/\">Bernie Tuffs - PhotoArtist</a> posted a photo:</p> <p><a href=\"https://www.flickr.com/photos/73666725@N07/51486249563/\" title=\"Bernie Tuffs - Bedtime Story\"><img src=\"https://live.staticflickr.com/65535/51486249563_26c33098b5_m.jpg\" width=\"240\" height=\"240\" alt=\"Bernie Tuffs - Bedtime Story\" /></a></p> <p>Bedtime Story<br /> <br /> Created purely for fun!<br /> <br /> Love this piece!</p>")
        XCTAssertEqual(publicFeedItem?.published, "2021-09-17T12:46:51Z")
        XCTAssertEqual(publicFeedItem?.author, "nobody@flickr.com (\"Bernie Tuffs - PhotoArtist\")")
        XCTAssertEqual(publicFeedItem?.authorId, "73666725@N07")
        XCTAssertEqual(publicFeedItem?.tags, "photoartistry photoshopartistry conceptualart child forest bedtimestory readingg dog deer bird lamp darkness light girl")
    }
    
    /// Verify 'feeds' service failure response
    func testVerifyFeedsFailure() {
        
        MockData.shared.isSuccessResponse = false
        MockData.shared.jsonFileName = UnitTestParams.StubJSONFileName.feedsFailure.rawValue
        
        subject = PublicFeedViewModel(networkAdapter: NetworkAdapter(), tags: "bird")

        while subject?.error == nil {}

        XCTAssertEqual(subject?.error?.localizedDescription, "The operation couldn’t be completed. (ImageDetector.NetworkError error 5.)")
    }
}
