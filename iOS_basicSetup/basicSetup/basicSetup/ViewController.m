//
//  ViewController.m
//  basicSetup
//
//  Created by Federico Casali on 4/12/16.
//  Copyright © 2016 Federico Casali. All rights reserved.
//

#import "ViewController.h"
#import <Leanplum/Leanplum.h>

@interface ViewController ()

@end

@implementation ViewController

- (IBAction)inboxButton:(id)sender {
}

- (IBAction)pushButton:(id)sender {
    NSLog(@"you clicked on Push Notification registration button");
    
    id notificationCenterClass = NSClassFromString(@"UNUserNotificationCenter");
    if (notificationCenterClass) {
        // iOS 10.
        SEL selector = NSSelectorFromString(@"currentNotificationCenter");
        id notificationCenter =
        ((id (*)(id, SEL)) [notificationCenterClass methodForSelector:selector])
        (notificationCenterClass, selector);
        if (notificationCenter) {
            selector = NSSelectorFromString(@"requestAuthorizationWithOptions:completionHandler:");
            IMP method = [notificationCenter methodForSelector:selector];
            void (*func)(id, SEL, unsigned long long, void (^)(BOOL, NSError *__nullable)) =
            (void *) method;
            func(notificationCenter, selector,
                 0b111, /* badges, sounds, alerts */
                 ^(BOOL granted, NSError *__nullable error) {
                     if (error) {
                         NSLog(@"Leanplum: Failed to request authorization for user "
                               "notifications: %@", error);
                     }
                 });
        }
        [[UIApplication sharedApplication] registerForRemoteNotifications];
    } else if ([[UIApplication sharedApplication] respondsToSelector:
                @selector(registerUserNotificationSettings:)]) {
        // iOS 8-9.
        UIUserNotificationSettings *settings = [UIUserNotificationSettings
                                                settingsForTypes:UIUserNotificationTypeAlert |
                                                UIUserNotificationTypeBadge |
                                                UIUserNotificationTypeSound categories:nil];
        [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
        [[UIApplication sharedApplication] registerForRemoteNotifications];
    } else {
        // iOS 7 and below.
        #pragma clang diagnostic push
        #pragma clang diagnostic ignored "-Wdeprecated-declarations"
        [[UIApplication sharedApplication] registerForRemoteNotificationTypes:
        #pragma clang diagnostic pop
         UIUserNotificationTypeSound | UIUserNotificationTypeAlert | UIUserNotificationTypeBadge];
    }
}

- (IBAction)trackButtonClick:(id)sender {
    [Leanplum track:@"firstEvent"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
