//
//  String+LoremIpsum.swift
//  Homework6-2
//
//  Created by Andrey Yakovlev on 25.06.2022.
//

import Foundation

extension String {
    private static var texts = [
        "Vestibulum vulputate justo et ligula vehicula pellentesque quis sit amet elit. Aenean eu dignissim est, vitae ornare dui. Aliquam imperdiet finibus nunc eget hendrerit. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Morbi eget augue dolor. In id tempus ipsum, non molestie libero. Etiam pulvinar eros metus, sed vulputate urna elementum ac. Quisque ipsum nulla, accumsan ut elementum eget, congue vel odio.",
        "Curabitur gravida at massa id consequat. Nulla facilisi. Donec ornare massa ut sapien ullamcorper placerat. Ut eu enim ligula. In tincidunt lorem vel lacus laoreet, quis vehicula tellus fermentum. Aenean dictum ligula ac semper luctus. Nulla congue posuere nulla ut ullamcorper.",
        "Nunc vulputate urna quis ligula blandit dignissim. Mauris fringilla tellus a massa condimentum consectetur. Aenean lacinia, massa sit amet congue pulvinar",
        "Curabitur eros nisl, luctus ac consectetur vitae, dignissim ut quam. Vivamus in scelerisque felis. Cras felis urna, sagittis a egestas ut, sollicitudin eu massa. Phasellus ut nibh non sem faucibus aliquet eu eu felis. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia curae; Pellentesque posuere ut erat a ornare. Interdum et malesuada fames ac ante ipsum primis in faucibus. Etiam viverra, dui a mollis tempus, dolor ex scelerisque diam, ut porta dui felis in augue. Nullam vel lectus id orci pulvinar lacinia id sed sem.",
        "Aenean dictum ligula ac semper luctus. Nulla congue posuere nulla ut ullamcorper. Vestibulum vulputate justo et ligula vehicula pellentesque quis sit amet elit. Aenean eu dignissim est, vitae ornare dui. Aliquam imperdiet finibus nunc eget hendrerit."
    ]

    static func makeRandomText() -> String {
        Self.texts.randomElement()!
    }
}
