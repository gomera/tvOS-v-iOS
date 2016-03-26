//
//  BaseVideosViewController.h
//  NSConfAr2016 tvOS Demo App
//
//  Created by Diego Sebastian Mera on 3/15/16.
//  Copyright © 2016 Diego Sebastian Mera. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Movie;

@interface BaseVideosViewController : UITableViewController

- (void) playMovieAtIndexPath:(NSIndexPath *) indexPath;

@end
