//
//  ImageService.swift
//  VService
//
//  Created by Virgilius Santos on 19/01/20.
//  Copyright © 2020 Virgilius Santos. All rights reserved.
//

import Kingfisher
import UIKit

public extension UIImageView {
    func setImage(with urlString: String, placeholder _: UIImage? = nil) {
        kf.setImage(with: URL(string: urlString),
                    placeholder: UIImage(),
                    options: [.transition(.fade(1)), .cacheOriginalImage])
    }

    func cancelRequest() {
        kf.cancelDownloadTask()
    }
}
