//
//  MoviePlayer.h
//  NSConfAr2016 tvOS Demo App
//
//  Created by Diego Sebastian Mera on 3/27/16.
//  Copyright © 2016 Diego Sebastian Mera. All rights reserved.
//

#import <Foundation/Foundation.h>
@import JavaScriptCore;

@protocol MoviePlayer <JSExport>

- (nullable instancetype) initWithVideoURL:(nonnull NSString *)videoURL;
+ (nullable instancetype) playerWithVideoURL:(nonnull NSString *)videoURL;
- (void) play;

@end

@interface MoviePlayer : NSObject<MoviePlayer>

@property (nonatomic, nonnull, strong, readonly) NSString *videoURL;

- (nullable instancetype) initWithVideoURL:(nonnull NSString *)videoURL;
+ (nullable instancetype) playerWithVideoURL:(nonnull NSString *)videoURL;
- (void) play;

@end
