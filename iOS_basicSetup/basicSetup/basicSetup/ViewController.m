//
//  ViewController.m
//  basicSetup
//
//  Created by Federico Casali on 4/12/16.
//  Copyright © 2016 Federico Casali. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

-(void) pushButtonClicked:(UIButton*)sender
{
    NSLog(@"you clicked on Push Notification registration button");
    
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 80000
    if ([[UIApplication sharedApplication] respondsToSelector:@selector(registerUserNotificationSettings:)]) {
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeAlert | UIUserNotificationTypeBadge | UIUserNotificationTypeSound categories:nil];
        [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
        [[UIApplication sharedApplication] registerForRemoteNotifications];
    } else {
        [[UIApplication sharedApplication] registerForRemoteNotificationTypes: UIUserNotificationTypeSound | UIUserNotificationTypeAlert | UIUserNotificationTypeBadge];
    }
#else
    [[UIApplication sharedApplication] registerForRemoteNotificationTypes: UIRemoteNotificationTypeSound | UIRemoteNotificationTypeAlert | UIRemoteNotificationTypeBadge];
#endif
}



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    UIButton *pushBut = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [pushBut addTarget:self action:@selector(pushButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [pushBut setFrame:CGRectMake(50, 50, 150, 30)];
    [pushBut setTitle:@"Register for Push" forState:UIControlStateNormal];
    [pushBut setExclusiveTouch:YES];
    [self.view addSubview:pushBut];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
