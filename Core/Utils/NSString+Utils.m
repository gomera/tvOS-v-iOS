//
//  NSString+Utils.m
//  ShortMovies
//
//  Created by Sebastian Borda on 9/19/15.
//  Copyright © 2015 Sebastian Borda. All rights reserved.
//

#import "NSString+Utils.h"

@implementation NSString (Utils)

- (NSString *)stringByReplacingPercentEscapes {
    return (NSString*)CFBridgingRelease(CFURLCreateStringByReplacingPercentEscapes(
                                                                                   kCFAllocatorDefault,
                                                                                   (CFStringRef)self,
                                                                                   CFSTR("")));
}

@end
