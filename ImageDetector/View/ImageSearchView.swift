//
//  ImageSearchView.swift
//  ImageDetector
//
//  Created by Marutharaj K on 16/09/21.
//

import SwiftUI

// MARK: - Categories -

/// Extends String to define user interface accessibility identifier
private extension String {
    static let feedSearchIdentifier = "FeedSearchIdentifier"
    static let feedListIdentifier = "FeedListIdentifier"
    static let feedListCellIdentifier = "FeedListCellIdentifier"
}

/// Extends String to define media key
private extension String {
    static let kMedia = "m"
}

/// Extends String to define user interface labels
private extension String {
    static let datePublished = "Date Published"
    static let author = "Author"
}

/// Extends String to get author name
private extension String {
    func authorName() -> String {
        
        guard let authorName = self.components(separatedBy: "(\"").last?.replacingOccurrences(of: "\")", with: "") else {
            return .init()
        }
        
        return authorName
    }
}

/// Extends String to define date format
private extension String {
    static let serverDateFormat = "yyyy-MM-dd HH:mm:ss"
    static let shortDateFormat = "MMM d, yyyy"
}

// MARK: - Type - ImageSearchView -

/**
 ImageSearchView will display list of public content matching tags that user entered/speeched on the search field
 */
struct ImageSearchView: View {
        
    @Environment(\.viewController) private var viewControllerHolder: UIViewController?
    @State private var tagTitle = "Recent Uploads tagged"
    @State private var searchText = ""
    @State private var publicFeedItems: [PublicFeedItems] = []
    
    var body: some View {
        VStack {
            Text(tagTitle)
                .font(.sfProTextBold(14.0))
            SearchBar(text: $searchText)
                .environmentObject(Speech())
                .onChange(of: searchText, perform: { tags in
                    DispatchQueue.main.async {
                        invokeFeedService(tags)
                    }
                })
                .padding(.top, 30)
                .accessibility(identifier: .feedSearchIdentifier)
            List(publicFeedItems) { feed in
                listItem(feed)
                    .accessibility(identifier: .feedListCellIdentifier)
                    .onTapGesture {
                        showFeedDetail(feed)
                    }
            }
                .accessibility(identifier: .feedListIdentifier)
        }
    }
    
    func listItem(_ feed: PublicFeedItems)-> some View {
        HStack {
            AsyncImage(
                url: URL(string: feed.media?[String.kMedia] ?? "")!,
                placeholder: { ActivityIndicator(isAnimating: .constant(true), style: .large) },
                image: { Image(uiImage: $0).resizable() }
            )
                .frame(width: 120.0, height: 120.0)
                .aspectRatio(contentMode: .fill)
            VStack(alignment: .leading) {
                Text(String.datePublished)
                    .font(.sfProTextRegular(14.0))
                    .foregroundColor(.darkBlackColor)
                Text(shortDate(dateString: feed.published ?? .init()))
                    .font(.sfProTextMedium(12.0))
                    .foregroundColor(.gray)
                Spacer()
                Text(String.author)
                    .font(.sfProTextRegular(14.0))
                    .foregroundColor(.darkBlackColor)
                Text(feed.author?.authorName() ?? .init())
                    .font(.sfProTextMedium(12.0))
                    .foregroundColor(.gray)
                Spacer()
            }
        }
    }
}

/// Extends ImageSearchView to  invoke feed service
private extension ImageSearchView {
    
    func invokeFeedService(_ tags: String) {
        Log.i(tags)

        let viewModel = PublicFeedViewModel(networkAdapter: NetworkAdapter(), tags: tags)
        
        viewModel.didReceivedFeeds = { response, isSuccess in
            if let publicFeed = response.publicFeed,
               let tagTitle = publicFeed.title,
               let feedItems = publicFeed.items {
                self.tagTitle = tagTitle
                self.publicFeedItems = feedItems
            }
        }
    }
}

/// Extends ImageSearchView to convert big date format to short date format
private extension ImageSearchView {
    
    func shortDate(dateString: String) -> String {
        let serverDateFormatter = DateFormatter()
        serverDateFormatter.dateFormat = .serverDateFormat
        let dateFromString = serverDateFormatter.date(from: dateString.replacingOccurrences(of: "T", with: " ").replacingOccurrences(of: "Z", with: ""))

        let shortDateFormatter = DateFormatter()
        shortDateFormatter.dateFormat = .shortDateFormat

        let stringFromDate = shortDateFormatter.string(from: dateFromString!)
        return stringFromDate
    }
}

/// Extends ImageSearchView to show feed detail when user tap feed from the list
private extension ImageSearchView {
    func showFeedDetail(_ feed: PublicFeedItems) {
        self.viewControllerHolder?.present(style: .popover, isModalPresent: true) {
            ImageDetailView(feedItem: feed)
        }
    }
}

#if DEBUG
struct ImageSearchView_Previews: PreviewProvider {
    static var previews: some View {
        ImageSearchView()
    }
}
#endif
