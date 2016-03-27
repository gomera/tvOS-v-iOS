//
//  YouTubeScrapper.m
//  NSConfAr2016 tvOS Demo App
//
//  Created by Diego Sebastian Mera on 3/27/16.
//  Copyright © 2016 Diego Sebastian Mera. All rights reserved.
//

#import "YouTubeScrapper.h"
#import "XCDYouTubeClient.h"
#import "NSURL+Utils.h"

@implementation YouTubeScrapper

+ (void) fetchYouTubeSteramURLFromLink:(NSURL*)videoURL withCompletion:(void(^)(NSURL *url))completion {
    
    if (videoURL != nil) {
        [[XCDYouTubeClient defaultClient] getVideoWithIdentifier:videoURL.queryParams[@"v"] completionHandler:^(XCDYouTubeVideo *video, NSError *error) {
            if (video) {
                
                NSURL *streamURL = nil;
                for (NSNumber *videoQuality in [self preferredVideoQualities]) {
                    streamURL = video.streamURLs[videoQuality];
                    if (streamURL) {
                        break;
                    }
                }
                completion(streamURL);
            } else {
                NSLog(@"Something was wrong while fetching the real Youtube link");
                completion(nil);
            }
            
        }];
    } else {
        completion(nil);
    }
}

+ (NSArray *) preferredVideoQualities {
    return @[ XCDYouTubeVideoQualityHTTPLiveStreaming, @(XCDYouTubeVideoQualityHD720), @(XCDYouTubeVideoQualityMedium360), @(XCDYouTubeVideoQualitySmall240) ];
    
}

@end
