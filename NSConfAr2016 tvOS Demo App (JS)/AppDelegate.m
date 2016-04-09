//
//  AppDelegate.m
//  NSConfAr2016 tvOS Demo App (JS)
//
//  Created by Diego Sebastian Mera on 3/27/16.
//  Copyright © 2016 Diego Sebastian Mera. All rights reserved.
//

#import "AppDelegate.h"
#import "Constants.h"
#import "MoviePlayer.h"

#define URL_JS  [NSString stringWithFormat:@"%@/application.js", BASE_URL]


@interface AppDelegate () <TVApplicationControllerDelegate>

@property(nonatomic, strong) TVApplicationControllerContext *tvContext;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    // Esto es unico codigo que se necesita del lado nativo cuando usamos TVMLKit, el resto es un plus para
    // hacer bridge entre JS y Nativo, lo que obviamente es opcional.
    self.tvContext = [[TVApplicationControllerContext alloc] init];
    self.tvContext.javaScriptApplicationURL = [NSURL URLWithString:URL_JS];
    self.tvContext.launchOptions = @{@"BASEURL": BASE_URL};
    self.tvController = [[TVApplicationController alloc] initWithContext:self.tvContext window:self.window delegate:self];
    
    
    // Entry point para poder registrar clases nativas y poder accederlas desde javascript (JSContext hace magia pero de la linda)
    // Para mas informacion, mirar MoviePlayer.h
    [self.tvController evaluateInJavaScriptContext:^(JSContext * _Nonnull context) {
        context[@"MoviePlayer"] = [MoviePlayer class];
    } completion:^(BOOL evaluated) {
        if (evaluated == NO) {
            NSLog(@"There was an error trying to evaluate MoviePlayer");
        }
    }];
        
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
