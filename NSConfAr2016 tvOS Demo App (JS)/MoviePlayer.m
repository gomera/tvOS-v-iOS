//
//  MoviePlayer.m
//  NSConfAr2016 tvOS Demo App
//
//  Created by Diego Sebastian Mera on 3/27/16.
//  Copyright © 2016 Diego Sebastian Mera. All rights reserved.
//

#import "MoviePlayer.h"
#import "AppDelegate.h"
#import "YouTubeScrapper.h"
@import AVKit;
@import AVFoundation;

static const NSString *MoviePlayerItemStatusContext;

@interface MoviePlayer()

@property (nonatomic, nonnull, strong) NSString *videoURL;
@property(nonatomic, strong) AVPlayer *player;

@end

@implementation MoviePlayer

- (nullable instancetype) initWithVideoURL:(nonnull NSString *)videoURL {
    self = [super init];
    if (self != nil) {
        self.videoURL = videoURL;
    }
    return self;
}

+ (nullable instancetype) playerWithVideoURL:(nonnull NSString *)videoURL {
    return [[MoviePlayer alloc]  initWithVideoURL:videoURL];
}

- (void) play {
    [YouTubeScrapper fetchYouTubeSteramURLFromLink:[NSURL URLWithString:self.videoURL] withCompletion:^(NSURL *url) {
        if (url != nil) {
            [self streamURL:url];
        }
    }];
}

- (void) streamURL:(NSURL*)url {
    AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
    AVPlayerViewController *playerViewController = [AVPlayerViewController new];
    
    self.player = [AVPlayer playerWithURL:url];
    [self.player addObserver:self forKeyPath:@"status" options:0 context:&MoviePlayerItemStatusContext];
    playerViewController.player = self.player;
    
    // Looks like a hack, it may actually be a really one :)
    [appDelegate.tvController.navigationController.viewControllers.lastObject presentViewController:playerViewController animated:YES completion:nil];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if (context == &MoviePlayerItemStatusContext) {
        if (self.player.status == AVPlayerStatusReadyToPlay) {
            [self.player removeObserver:self forKeyPath:@"status"];
            [self.player play];
        } else if (self.player.status == AVPlayerStatusFailed){
            
        }
    } else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

@end
