//
//  Movie.m
//  NSConfAr2016 tvOS Demo App
//
//  Created by Diego Sebastian Mera on 3/20/16.
//  Copyright © 2016 Diego Sebastian Mera. All rights reserved.
//

#import "Movie.h"

#define DICTIONARY_KEY_MOVIE_TITLE          @"title"
#define DICTIONARY_KEY_MOVIE_SUMMARY        @"summary"
#define DICTIONARY_KEY_MOVIE_THUMBNAIL      @"thumbnail"
#define DICTIONARY_KEY_MOVIE_VIDEO          @"video"

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


@end
