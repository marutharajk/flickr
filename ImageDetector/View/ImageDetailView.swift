//
//  ImageDetailView.swift
//  ImageDetector
//
//  Created by Marutharaj K on 17/09/21.
//

import SwiftUI

// MARK: - Categories -

/// Extends String to define user interface label and images
private extension String {
    static let navigationTitle = "Feed Detail"
    static let feedTitle = "Title:"
    static let feedResolution = "Resolution: "
    static let feedDescription = "Description:"
    static let dateTaken = "Date Taken:"
    static let datePublished = "Date Published:"
    static let author = "Author:"
    static let tags = "Tags:"
    static let assetBack = "img_back"
    static let assetShare = "img_share"
}

/// Extends String to define user interface accessibility identifier
private extension String {
    static let feedImage = "FeedImage"
    static let feedTitleIdentifier = "FeedTitle"
    static let feedTitleValue = "FeedTitleValue"
    static let feedDescriptionIdentifier = "FeedDescription"
    static let feedDescriptionValue = "FeedDescriptionValue"
    static let feedDateTaken = "FeedDateTaken"
    static let feedDateTakenValue = "FeedDateTakenValue"
    static let feedDatePublished = "FeedDatePublished"
    static let feedDatePublishedValue = "FeedDatePublishedValue"
    static let feedAuthor = "FeedAuthor"
    static let feedAuthorValue = "FeedAuthorValue"
    static let feedTags = "FeedTags"
    static let feedTagsValue = "FeedTagsValue"
    static let navigationBackImage = "NavigationBackImage"
    static let navigationTitleIdentifier = "NavigationTitle"
    static let navigationShareImage = "NavigationShareImage"
    static let feedResolutionIdentifier = "FeedResolutionIdentifier"
    static let feedResolutionValue = "FeedResolutionValue"
}

/// Extends String to define media key
private extension String {
    static let kMedia = "m"
}

/// Extends String to get image width and height
private extension String {
    func getImageWidth() -> String {
        guard let width = self.components(separatedBy: "width=").last?.components(separatedBy: " ").first?.replacingOccurrences(of: "\"", with: ""),
              let height = self.components(separatedBy: "height=").last?.components(separatedBy: " ").first?.replacingOccurrences(of: "\"", with: "") else {
            return .init()
        }
        return "\(width)w x \(height)h"
    }
}

// MARK: - Type - ImageDetailView -

/**
 ImageDetailView will display feed detail such as feed image, feed title, feed description, feed published date, feed taken date, feed author and feed tags
 */
struct ImageDetailView: View {
    
    @Environment(\.viewController) private var viewControllerHolder: UIViewController?

    public var feedItem: PublicFeedItems
    
    var body: some View {
        VStack {
            navigationHeader
            feedImage

            VStack(alignment: .leading, spacing: 5.0) {
                feedTitle
                feedImageWidthAndHeight
                feedDescription
                feedDateTaken
                feedDatePublished
                feedAuthor
                feedTags
            }
            Spacer()
        }
    }
}

/// Extends ImageDetailView to frame user interface for display feed image, feed title, feed description, feed published date, feed taken date, feed author and feed tags
private extension ImageDetailView {
    var feedImage: some View {
        AsyncImage(
            url: URL(string: feedItem.media?[String.kMedia] ?? "")!,
            placeholder: { ActivityIndicator(isAnimating: .constant(true), style: .large) },
            image: { Image(uiImage: $0).resizable() }
        )
            .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height / 2.0)
            .accessibility(identifier: .feedImage)
    }
    
    var feedTitle: some View {
        HStack(alignment: .top) {
            Text(String.feedTitle)
                .font(.sfProTextBold(14.0))
                .accessibility(identifier: .feedTitleIdentifier)
            Text(feedItem.title ?? .init())
                .font(.sfProTextRegular(12.0))
                .accessibility(identifier: .feedTitleValue)

            Spacer()
        }
            .padding(.leading)
    }
    
    var feedImageWidthAndHeight: some View {
        HStack(alignment: .top) {
            Text(String.feedResolution)
                .font(.sfProTextBold(14.0))
                .accessibility(identifier: .feedResolutionIdentifier)
            Text(feedItem.description?.getImageWidth() ?? .init())
                .font(.sfProTextRegular(12.0))
                .accessibility(identifier: .feedResolutionValue)

            Spacer()
        }
            .padding(.leading)
    }
    
    var feedDescription: some View {
        HStack(alignment: .top) {
            Text(String.feedDescription)
                .font(.sfProTextBold(14.0))
                .accessibility(identifier: .feedDescriptionIdentifier)

            HTMLStringView(htmlContent: feedItem.description ?? .init())
                .frame(width: 150.0, height: 100.0)
                .accessibility(identifier: .feedDescriptionValue)

            Spacer()
        }
            .padding(.leading)
    }
    
    var feedDateTaken: some View {
        HStack(alignment: .top) {
            Text(String.dateTaken)
                .font(.sfProTextBold(14.0))
                .accessibility(identifier: .feedDateTaken)

            Text(feedItem.date_taken ?? .init())
                .font(.sfProTextRegular(12.0))
                .accessibility(identifier: .feedDateTakenValue)

            Spacer()
        }
            .padding(.leading)
    }
    
    var feedDatePublished: some View {
        HStack(alignment: .top) {
            Text(String.datePublished)
                .font(.sfProTextBold(14.0))
                .accessibility(identifier: .feedDatePublished)

            Text(feedItem.published ?? .init())
                .font(.sfProTextRegular(12.0))
                .accessibility(identifier: .feedDatePublishedValue)

            Spacer()
        }
            .padding(.leading)
    }
    
    var feedAuthor: some View {
        HStack(alignment: .top) {
            Text(String.author)
                .font(.sfProTextBold(14.0))
                .accessibility(identifier: .feedAuthor)

            Text(feedItem.author ?? .init())
                .font(.sfProTextRegular(12.0))
                .accessibility(identifier: .feedAuthorValue)

            Spacer()
        }
            .padding(.leading)
    }
    
    var feedTags: some View {
        HStack(alignment: .top) {
            Text(String.tags)
                .font(.sfProTextBold(14.0))
                .accessibility(identifier: .feedTags)

            Text(feedItem.tags ?? .init())
                .font(.sfProTextRegular(12.0))
                .accessibility(identifier: .feedTagsValue)

            Spacer()
        }
            .padding(.leading)
    }
}

/// Extends ImageDetailView to frame navigation header
private extension ImageDetailView {
    
    var navigationHeader: some View {
        HStack {
            navigationBackButton
            Spacer()
            navigationTitle
            Spacer()
            navigationShareButton
        }
            .padding(.top, 12.0)
    }
    
    var navigationBackButton: some View {
        Image(.assetBack)
            .renderingMode(.template)
            .foregroundColor(.darkBlackColor)
            .padding(.leading, 16.0)
            .onTapGesture {
                viewControllerHolder?.dismiss(animated: false)
            }
            .accessibility(identifier: .navigationBackImage)
    }
    
    var navigationTitle: some View {
        Text(String.navigationTitle)
            .font(.sfProTextBold(16.0))
            .foregroundColor(.darkBlackColor)
            .accessibility(identifier: .navigationTitleIdentifier)
    }
    
    var navigationShareButton: some View {
        Image(.assetShare)
            .renderingMode(.template)
            .foregroundColor(.darkBlackColor)
            .padding(.trailing, 16.0)
            .onTapGesture {
                trailingTapped()
            }
            .accessibility(identifier: .navigationShareImage)
    }
}

/// Extends ImageDetailView to define event handler for share button
private extension ImageDetailView {
    
    func trailingTapped() {
        let screenCaptureRect = CGRect(x: .zero,
                                       y: .zero,
                                       width: UIScreen.main.bounds.width,
                                       height: UIScreen.main.bounds.height)
        
        let data = takeScreenshot(screenCaptureRect: screenCaptureRect)
        let av = UIActivityViewController(activityItems: [data], applicationActivities: nil)
        self.viewControllerHolder?.present(av, animated: true, completion: nil)
    }
}

///Extends View to take screenshot
private extension View {
    
    func takeScreenshot(screenCaptureRect: CGRect ) -> Data {
        var image: UIImage?
        image = UIApplication.shared.snapshot(size: screenCaptureRect)
        
        guard let data = image?.pngData() else {
            return Data()
        }
        return data
    }
}

///Extends UIApplication to take screenshot from the window presented view controller
private extension UIApplication {
    
    func snapshot(size: CGRect) -> UIImage? {
        let keyWindow = UIApplication.shared.windows.first
        
        if var topController = keyWindow?.rootViewController {
            while let presentedViewController = topController.presentedViewController {
                topController = presentedViewController
                return topController.view.snapshot(rect: size)
            }
        }
        return nil
    }
}

///Extends UIView to get image from the given rect
private extension UIView {
    func snapshot(rect: CGRect) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(rect.size, isOpaque, .zero)
        if UIGraphicsGetCurrentContext() != nil {
            drawHierarchy(in: bounds, afterScreenUpdates: true)
            let screenshot = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            return screenshot
        }
        return nil
    }
}
