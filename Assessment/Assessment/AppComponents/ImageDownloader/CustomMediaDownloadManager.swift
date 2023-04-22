//
//  CustomMediaDownloadManager.swift
//  Assessment
//
//  Created by Prabhu on 20/04/23.
//

import UIKit

typealias ImageDownloadedCallback = (_ image: UIImage?, _ url: URL?, _ indexPath: IndexPath?, _ error: Error?) -> Void

class CustomDownloadManager {

    // MARK: Variables
    var completionCallback: ImageDownloadedCallback?
    let imageCache = NSCache<NSString, UIImage>()

    // Operation queue to execute download operations
    lazy var imageDownloadQueue: OperationQueue = {
       var queue = OperationQueue()
       queue.name = "com.custom.media.download.manager"
       queue.qualityOfService = .userInteractive
       return queue
    }()

    // MARK: Singleton Instance
    static let shared = CustomDownloadManager()
    private init () {}

    // To Download image with url
    func downloadImage(url: String?, indexPath: IndexPath? = nil, callback: @escaping ImageDownloadedCallback) {

        // callback to return the results
        self.completionCallback = callback

        // Check for the cahced image by using url, if it's present return the image
        guard let url = url else { return }
        if let cachedImage = imageCache.object(forKey: url as NSString) {

            //  print("Return cached Image for \(url)")
            self.completionCallback?(cachedImage, URL.init(string: url), indexPath, nil)

        } else {

            // Check the current image is downloading and increase the priority
            if let operations = (imageDownloadQueue.operations as? [DownloadOperation])?.filter({$0.imageUrl?.absoluteString == url && $0.isFinished == false && $0.isExecuting == true }), let operation = operations.first {

                // print("Increase the priority for \(url)")
                operation.queuePriority = .veryHigh

            } else {

                // Create a new task to download the image
                let operation = DownloadOperation(url: URL(string: url)!, indexPath: indexPath)

                if indexPath == nil {
                    operation.queuePriority = .high
                }

                operation.downloadCompletedCallback = { (image, url, indexPath, error) in

                    if let newImage = image {
                        self.imageCache.setObject(newImage, forKey: url?.absoluteString as NSString? ?? "" as NSString)
                    }
                    self.completionCallback?(image, url, indexPath, error)

                }

                // Add created operation to the operation queue
                imageDownloadQueue.addOperation(operation)

            }

        }
    }

    // Reduce the operation's priority incase user scrolls and image is no longer visible
    func slowDownImageDownloadTaskfor (imageURL: String?) {

        guard let imageURL = imageURL else {
           return
       }

       if let operations = (imageDownloadQueue.operations as? [DownloadOperation])?.filter({$0.imageUrl?.absoluteString == imageURL && $0.isFinished == false && $0.isExecuting == true }), let operation = operations.first {

           // Reduce the priority of the operation to slow down the operation
           operation.queuePriority = .low

       }

    }

    func cancelAll() {
       imageDownloadQueue.cancelAllOperations()
    }

}
