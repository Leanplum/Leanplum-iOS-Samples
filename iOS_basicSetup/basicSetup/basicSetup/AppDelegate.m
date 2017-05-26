//
//  AppDelegate.m
//  basicSetup
//
//  Created by Federico Casali on 4/12/16.
//  Copyright © 2016 Federico Casali. All rights reserved.
//

#import "AppDelegate.h"
#import "Keys.h"
#import <Leanplum/Leanplum.h>

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    // Define LP_APP_ID, LP_DEVELOPMENT_KEY and LP_PRODUCTION_KEY in Keys.h
#ifdef DEBUG
    LEANPLUM_USE_ADVERTISING_ID;
    [Leanplum setAppId:LP_APP_ID withDevelopmentKey:LP_DEVELOPMENT_KEY];
#else
    [Leanplum setAppId:LP_APP_ID withProductionKey:LP_PRODUCTION_KEY];
#endif
    
    // In case a DeviceID needs to be customized, it should be put here, before [Leanplum start].
    // setDeviceID will pass a DeviceID as string and set it only when the app is installed from scratch.
    // Is not possible to change the DeviceID of an already installed application.
    
//     [Leanplum setDeviceId:@"new_DeviceID"];
    
    [Leanplum setVerboseLoggingInDevelopmentMode:YES];
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


//(Optional) You may choose to enable the Remote Notifications background mode on iOS 7+ to preload the notification action. This is configurable in your XCode project settings > Capabilities > Background Modes. If you have this enabled, you must tell Leanplum to explicitly handle notifications in your app delegate:

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler
{
    [Leanplum handleNotification:userInfo fetchCompletionHandler:completionHandler];
}

@end
