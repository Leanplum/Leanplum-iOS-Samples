//
//  ViewController.m
//  OpenSecondViewController
//
//  Created by Federico Casali on 3/25/16.
//  Copyright © 2016 Federico Casali. All rights reserved.
//

#import "ViewController.h"
#import <Leanplum/Leanplum.h>

@interface ViewController ()

@property (strong, nonatomic) IBOutlet UITextField *loginField;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    secondViewController = [[SecondViewController alloc] initWithNibName:@"SecondViewController" bundle:nil];
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    NSLog(@"You entered %@",self.loginField.text);
    [self.loginField resignFirstResponder];
    return YES;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)buttonAction:(id)sender {
    
    [Leanplum setUserId:self.loginField.text];
    
    [self presentViewController:secondViewController animated:YES completion:nil];
}
@end
