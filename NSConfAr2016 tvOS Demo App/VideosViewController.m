//
//  VideosViewController.m
//  NSConfAr2016 tvOS Demo App
//
//  Created by Diego Sebastian Mera on 3/15/16.
//  Copyright © 2016 Diego Sebastian Mera. All rights reserved.
//

#import "VideosViewController.h"

@interface VideosViewController()

@property(nonatomic, nullable, strong) NSIndexPath *focusedIndexPath;

@end

@implementation VideosViewController

-(void) tableView:(UITableView *)tableView didUpdateFocusInContext:(UITableViewFocusUpdateContext *)context withAnimationCoordinator:(UIFocusAnimationCoordinator *)coordinator {
    self.focusedIndexPath = [context nextFocusedIndexPath];
}


// Para que cuando apriete Play, automaticamente se ejecute el video donde estoy parado
-(void)pressesEnded:(NSSet<UIPress *> *)presses withEvent:(UIPressesEvent *)event {
    if (self.focusedIndexPath != nil) {
        for(UIPress *press in presses) {
            if (press.type == UIPressTypePlayPause) {
                [self playMovieAtIndexPath:self.focusedIndexPath];
            }
        }
    }
}


@end
