//
//  AppDelegate.m
//  iOS_variables
//
//  Created by Federico Casali on 5/17/16.
//  Copyright © 2016 Leanplum. All rights reserved.
//

#import "AppDelegate.h"
#import <Leanplum/Leanplum.h>


@interface AppDelegate ()

@end

DEFINE_VAR_STRING(welcomeMessage, @"Welcome to Leanplum!");
DEFINE_VAR_BOOL(showAds, false);
DEFINE_VAR_FLOAT(floatvar, 1.5);
DEFINE_VAR_INT(intvalue, 20);

DEFINE_VAR_DICTIONARY_WITH_OBJECTS_AND_KEYS(
                                            powerup,
                                            @"Turbo Boost", @"name",
                                            @150, @"price",
                                            @1.5, @"speedMultiplier",
                                            @15, @"timeout",
                                            nil);


@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
#ifdef DEBUG
    LEANPLUM_USE_ADVERTISING_ID;
    [Leanplum setAppId:@"" withDevelopmentKey:@""];
#else
    [Leanplum setAppId:@"" withProductionKey:@""];
#endif
    
    [Leanplum onVariablesChanged:^{
        NSLog(@"%@", welcomeMessage.stringValue);
        NSLog(@" %s", showAds.boolValue ? "true" : "false");
        NSLog(@"%0.1f", floatvar.floatValue);
        NSLog(@"%d", intvalue.intValue);
        NSLog(@"%2f", [[powerup objectForKey:@"speedMultiplier"] floatValue]);
    }];

    
    [Leanplum start];

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
