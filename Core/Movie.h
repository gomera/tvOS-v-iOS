//
//  Movie.h
//  NSConfAr2016 tvOS Demo App
//
//  Created by Diego Sebastian Mera on 3/20/16.
//  Copyright © 2016 Diego Sebastian Mera. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Movie : NSObject

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *summary;
@property (nonatomic, strong) NSURL *thumbnail;
@property (nonatomic, strong) NSURL *videoURL;


-(instancetype) initWithDictionary:(NSDictionary*)dictionary;

@end
