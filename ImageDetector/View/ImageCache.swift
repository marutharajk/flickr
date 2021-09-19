//
//  ImageCache.swift
//  ImageDetector
//
//  Created by Marutharaj K on 17/09/21.
//

import UIKit

protocol ImageCache {
    subscript(_ url: URL) -> UIImage? { get set }
}

// MARK: - Type - TemporaryImageCache -

/**
 TemporaryImageCache will cache loaded images for the future usage
 */
struct TemporaryImageCache: ImageCache {
    private let cache: NSCache<NSURL, UIImage> = {
        let cache = NSCache<NSURL, UIImage>()
        cache.countLimit = 100 // 100 items
        cache.totalCostLimit = 1024 * 1024 * 100 // 100 MB
        return cache
    }()
    
    subscript(_ key: URL) -> UIImage? {
        get { cache.object(forKey: key as NSURL) }
        set { newValue == nil ? cache.removeObject(forKey: key as NSURL) : cache.setObject(newValue!, forKey: key as NSURL) }
    }
}
