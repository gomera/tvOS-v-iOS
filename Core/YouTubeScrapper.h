//
//  YouTubeScrapper.h
//  NSConfAr2016 tvOS Demo App
//
//  Created by Diego Sebastian Mera on 3/27/16.
//  Copyright © 2016 Diego Sebastian Mera. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YouTubeScrapper : NSObject

+ (void) fetchYouTubeSteramURLFromLink:(NSURL*)videoURL withCompletion:(void(^)(NSURL *url))completion;

@end
