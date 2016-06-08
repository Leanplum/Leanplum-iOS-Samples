//
//  ViewController.m
//  iOS_resourceSyncing
//
//  Created by Federico Casali on 6/7/16.
//  Copyright © 2016 Leanplum. All rights reserved.
//

#import "ViewController.h"
#import <Leanplum/Leanplum.h>

// Defining a file image variable
// In this case the 'goldStar' image is not automaticallty synced with Leanplum (since is a JPG file, while in the AppDelegate.m we are sepcifying only png, nib and json files
// It will be found in the Leanplum Variables section with the name of 'goldStar'

DEFINE_VAR_FILE(goldStar, @"goldstar.jpg");  // Location of Gold Star image file.

//+ (void)loadMedia {
//    // imageValue is compatible with Asset Catalogs.
//    self.splashView.image  = goldStar.imageValue;
//}

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Allocating an ImageView initializing it using the 'snoopy.png' image file
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"snoopy"]] ;
    
    // Allocating an ImageView only specifying the RectSize
    UIImageView *goldStarImage = [[UIImageView alloc] initWithFrame:CGRectMake(50, 300, 50, 50)];
    
    
    [Leanplum onVariablesChangedAndNoDownloadsPending:^() {
        
        // Inside the Leanplum Callback, we are setting the Image Views contents
        
        // In this case the imageView is just being displayed once the Callback is triggered.
        // This imageView is being already set with a file being synced using Automatic Resource Syncing, so just swapping in and out and restarting the app will change the image
        [self.view addSubview:imageView];
    
        
        // In this other case, the goldStarImage image view is being set in the callback, just like a String or another Variable changing value.
        goldStarImage.image  = goldStar.imageValue;
        [self.view addSubview:goldStarImage];
        
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
