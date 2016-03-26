//
//  Movie.m
//  NSConfAr2016 tvOS Demo App
//
//  Created by Diego Sebastian Mera on 3/20/16.
//  Copyright © 2016 Diego Sebastian Mera. All rights reserved.
//

#import "Movie.h"
#import "XCDYouTubeClient.h"
#import "NSURL+Utils.h"

#define DICTIONARY_KEY_MOVIE_TITLE          @"title"
#define DICTIONARY_KEY_MOVIE_SUMMARY        @"summary"
#define DICTIONARY_KEY_MOVIE_THUMBNAIL      @"thumbnail"
#define DICTIONARY_KEY_MOVIE_VIDEO          @"video"

@interface Movie ()

@property (nonatomic, strong) NSURL *youtubeURL;

@end

@implementation Movie

-(instancetype) initWithDictionary:(NSDictionary*)dictionary {
    self = [super init];
    if (self != nil) {
        self.title = dictionary[DICTIONARY_KEY_MOVIE_TITLE];
        self.summary = dictionary[DICTIONARY_KEY_MOVIE_SUMMARY];
        self.thumbnail = [NSURL URLWithString:dictionary[DICTIONARY_KEY_MOVIE_THUMBNAIL]];
        self.videoURL = [NSURL URLWithString:dictionary[DICTIONARY_KEY_MOVIE_VIDEO]];
    }
    return self;
}


- (void) youtubeURLWithCompletion:(void(^)(NSURL *url))completion {
    
    if (self.youtubeURL == nil) {
        [[XCDYouTubeClient defaultClient] getVideoWithIdentifier:self.videoURL.queryParams[@"v"] completionHandler:^(XCDYouTubeVideo * _Nonnull video, NSError * _Nonnull error) {
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
        completion(self.youtubeURL);
    }
}

- (NSArray *) preferredVideoQualities {
    return @[ XCDYouTubeVideoQualityHTTPLiveStreaming, @(XCDYouTubeVideoQualityHD720), @(XCDYouTubeVideoQualityMedium360), @(XCDYouTubeVideoQualitySmall240) ];
    
}

@end
