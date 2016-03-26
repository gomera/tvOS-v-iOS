//
//  FetchMoviesRequest.h
//  NSConfAr2016 tvOS Demo App
//
//  Created by Diego Sebastian Mera on 3/20/16.
//  Copyright © 2016 Diego Sebastian Mera. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Movie.h"

@interface FetchMoviesRequest : NSObject

- (void) executeWithCompletion:(void(^)(NSArray<Movie*> *movies, NSError *error))completion;

@end
