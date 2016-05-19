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



- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor grayColor];
    self.myTextView = [[UITextView alloc] initWithFrame:self.view.bounds];
    self.myTextView.text = @"\nLEANPLUM\nInstrumenting Variables and retrieving their values\n\nVariables in this sample are defined in different classes.\nTheir values are then returned from inside a callback.\nThe following image and the text string below can be changed from the Leanplum Dashboard\n\nOther variables values defined are being displayed in Console Log.";
    self.myTextView.font = [UIFont systemFontOfSize:14.0f];
    self.myTextView.editable = NO;
    [self.view addSubview:self.myTextView];
    
    
    UITextView *LPTextView = [[UITextView alloc] initWithFrame: CGRectMake(30, 460, 300, 300)];
    LPTextView.editable = NO;
    [self.view addSubview:LPTextView];
    
    UIImageView *LPlogo = [[UIImageView alloc] initWithFrame: CGRectMake(30, 200, 200, 200)];
    [self.view addSubview:LPlogo];
    
    
    // Callback where handling the String value
    [Leanplum onVariablesChanged:^{
        LPTextView .text = sampleText.stringValue;
    }];
    
    // Callback where setting the image
    // Downloading files takes more time than loading variables, so the callback is different in this case
    [Leanplum onVariablesChangedAndNoDownloadsPending:^{
        LPlogo.image = LPsquarelogo.imageValue;
    }];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
