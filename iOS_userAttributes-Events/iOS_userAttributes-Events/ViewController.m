//
//  ViewController.m
//  iOS_userAttributes-Events
//
//  Created by Federico Casali on 6/7/16.
//  Copyright © 2016 Leanplum. All rights reserved.
//

#import <Leanplum/Leanplum.h>
#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController


- (void)trackEventButtonClicked:(UIButton*)sender
{
    NSLog(@"you clicked on track event button");
    [Leanplum track:@"Test_Event" withParameters:@{@"Test_Param": @"12345" }];
}

- (void) userAttributeButton_1:(UIButton*)sender
{
    NSLog(@"you clicked on the set user Attributes button");
    [Leanplum setUserAttributes:@{@"gender": @"Female", @"age": @30}];
}

- (void) userAttributeButton_2:(UIButton*)sender
{
    NSLog(@"you clicked on the set user Attributes button");
    [Leanplum setUserAttributes:@{@"gender": @"Male", @"age": @36}];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    UIButton *setUserAttributesBut_1 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [setUserAttributesBut_1 addTarget:self action:@selector(userAttributeButton_1:) forControlEvents:UIControlEventTouchUpInside];
    [setUserAttributesBut_1 setFrame:CGRectMake(30, 180, 150, 30)];
    [setUserAttributesBut_1 setTitle:@"Set UserAttributes_1" forState:UIControlStateNormal];
    [setUserAttributesBut_1 setExclusiveTouch:YES];
    [self.view addSubview:setUserAttributesBut_1];
    
    UIButton *setUserAttributesBut_2 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [setUserAttributesBut_2 addTarget:self action:@selector(userAttributeButton_2:) forControlEvents:UIControlEventTouchUpInside];
    [setUserAttributesBut_2 setFrame:CGRectMake(30, 230, 150, 30)];
    [setUserAttributesBut_2 setTitle:@"Set UserAttributes_2" forState:UIControlStateNormal];
    [setUserAttributesBut_2 setExclusiveTouch:YES];
    [self.view addSubview:setUserAttributesBut_2];
    
    UIButton *trackBut = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [trackBut addTarget:self action:@selector(trackEventButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [trackBut setFrame:CGRectMake(30, 300, 150, 30)];
    [trackBut setTitle:@"Track event" forState:UIControlStateNormal];
    [trackBut setExclusiveTouch:YES];
    [self.view addSubview:trackBut];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
