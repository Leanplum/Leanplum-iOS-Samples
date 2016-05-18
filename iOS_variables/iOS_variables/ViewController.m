//
//  ViewController.m
//  iOS_variables
//
//  Created by Federico Casali on 5/17/16.
//  Copyright © 2016 Leanplum. All rights reserved.
//

#import "ViewController.h"
#import <Leanplum/Leanplum.h>

DEFINE_VAR_STRING(sampleText, @"This is some text we can change from the Dashboard!");
DEFINE_VAR_FILE(LPsquarelogo, @"leanplum-squarelogo.png");


@interface ViewController ()

@end

@implementation ViewController

NSString *myText = @"your  long text here";


+ (void) loadMedia {
//    self.
}



- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor grayColor];
    self.myTextView = [[UITextView alloc] initWithFrame:self.view.bounds];
    self.myTextView.text = @"\n\nLEANPLUM\nInstrumenting Variables and retrieving their values\n\nVariables in this sample are defined in different classes.\nTheir value is then returned from inside a callback. ";
    self.myTextView.font = [UIFont systemFontOfSize:16.0f];
    self.myTextView.editable = NO;
    [self.view addSubview:self.myTextView];
    
    
    UITextView *LPTextView = [[UITextView alloc] initWithFrame: CGRectMake(30, 460, 300, 300)];
    LPTextView.editable = NO;
    [self.view addSubview:LPTextView];
    
    UIImageView *LPlogo = [[UIImageView alloc] initWithFrame: CGRectMake(30, 200, 200, 200)];
    [self.view addSubview:LPlogo];
    
    
//    self.LPlogoImage = [[UIImageView alloc] initWithFrame: CGRectMake(30, 200, 300, 300)];
    
    
    [Leanplum onVariablesChangedAndNoDownloadsPending:^{
        
        LPTextView .text = sampleText.stringValue;
        LPlogo.image = LPsquarelogo.imageValue;
    }];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
