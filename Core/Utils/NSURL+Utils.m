//
//  NSURL+Utils.m
//  ShortMovies
//
//  Created by Sebastian Borda on 9/19/15.
//  Copyright © 2015 Sebastian Borda. All rights reserved.
//

#import "NSURL+Utils.h"
#import "NSString+Utils.h"

static NSString *const uq_URLReservedChars  = @"￼=,!$&'()*+;@?\r\n\"<>#\t :/";
static NSString *const kQuerySeparator      = @"&";
static NSString *const kQueryDivider        = @"=";

@implementation NSURL (Utils)

- (NSDictionary *)queryParams {
    NSMutableDictionary *mute = [NSMutableDictionary new];
    for (NSString *query in [self.query componentsSeparatedByString:kQuerySeparator]) {
        NSArray *components = [query componentsSeparatedByString:kQueryDivider];
        if (components.count == 0) {
            continue;
        }
        NSString *key = [components[0] stringByReplacingPercentEscapes];
        id value = nil;
        if (components.count == 1) {
            // key with no value
            value = [NSNull null];
        }
        if (components.count == 2) {
            value = [components[1] stringByReplacingPercentEscapes];
            // cover case where there is a separator, but no actual value
            value = [value length] ? value : [NSNull null];
        }
        if (components.count > 2) {
            // invalid - ignore this pair. is this best, though?
            continue;
        }
        mute[key] = value ?: [NSNull null];
    }
    return mute.count ? mute.copy : nil;
}


@end
