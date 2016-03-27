//
//  AppDelegate.h
//  NSConfAr2016 tvOS Demo App (JS)
//
//  Created by Diego Sebastian Mera on 3/27/16.
//  Copyright © 2016 Diego Sebastian Mera. All rights reserved.
//

#import <UIKit/UIKit.h>
@import TVMLKit;

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property(nonatomic, nonnull, strong) TVApplicationController *tvController;

@end

