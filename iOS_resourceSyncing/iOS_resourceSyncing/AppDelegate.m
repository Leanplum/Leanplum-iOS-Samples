//
//  AppDelegate.m
//  iOS_resourceSyncing
//
//  Created by Federico Casali on 6/7/16.
//  Copyright © 2016 Leanplum. All rights reserved.
//

#import "AppDelegate.h"
#import <Leanplum/Leanplum.h>


@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
#ifdef DEBUG
    LEANPLUM_USE_ADVERTISING_ID;
    [Leanplum setAppId:@"" withDevelopmentKey:@""];
#else
    [Leanplum setAppId:@"" withProductionKey:@""];
#endif
    
    // Add the following to enable the Automatic Respource Sync for all the file Resources with Leanplum
    // [Leanplum syncResourcesAsync:YES];
    
    
    // Add the following to only Automatically Resource Sync certain file resources with Leanplum
    // In the following example we are syncing only png, nib and json files. 
    [Leanplum syncResourcePaths:@[@"\\.(png|nib|json)$"] excluding:nil async:YES];
    
    
    [Leanplum onVariablesChangedAndNoDownloadsPending:^{
        // Inside the Leanplum Callback I should put the code for handling a JSON file on testJSON.json
        // In this sample the testJSON.json file is synced using the Automatic Resource Sync.
        
        // In this case I'm accessing to the testJSON.json file I have in my app and printing out one of its values.
        // If then you change the JSON file on the Dashboard and restart the app, the new file will be used (try to use another JSON file with a different 'age' value for example
       
        NSString *filePath = [[NSBundle mainBundle] pathForResource:@"testJSON" ofType:@"json"];
        NSData *myData = [NSData dataWithContentsOfFile:filePath];
        if (myData) {
            NSArray *json = [NSJSONSerialization JSONObjectWithData:myData options:kNilOptions error:nil];
            NSString *age = json[0][@"person"][@"age"];
            NSLog(@"### Test JSON. Age value is: %@", age);
        }
        
        
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
