//
//  SearchViewController.m
//  WhatPosters
//
//  Created by mac on 11/27/15.
//  Copyright © 2015 Xululabs. All rights reserved.
//


#import "SearchViewController.h"
#import "MainViewController.h"
#import "Seacrh Results.h"
#import "SVProgressHUD.h"
#import "WeatherHTTPClient.h"
#import "Utility.h"
#import "AFNetworking.h"
#import "AppDelegate.h"

static NSString *const  movieimagesUrl = @"http://52.5.222.145:9000/myservice/upload";

@interface SearchViewController () <GetmovieimagesnameArray>{

    dispatch_queue_t backgroundqueee;
    NSArray *imagesUrlArray;

}
@end
@implementation SearchViewController
@synthesize imageView;
@synthesize theImage;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //View Tittle
    self.title = @"SearchView";
    //imagesUrlArray = [[Utility sharedManager] getVenueArray];
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageWithContentsOfFile:[[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"ImageUploadedByModMyi1342057019.344337.jpg"]]];
    
    self.imageView.image = theImage;
    
    ///image animation
    imageView.layer.cornerRadius = 60.0f;
    imageView.layer.borderWidth = 2.0f;
    imageView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    imageView.clipsToBounds = YES;
    
    self.searchButton.layer.cornerRadius = self.searchButton.bounds.size.width/6.0;
    self.searchButton.layer.borderWidth = 3.0;
    self.searchButton.layer.borderColor = self.searchButton.titleLabel.textColor.CGColor;
    self.searchButton.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:18];
    
    
    self.captureNewPhoto.layer.cornerRadius = self.captureNewPhoto.bounds.size.width/6.0;
    self.captureNewPhoto.layer.borderWidth = 3.0;
    self.captureNewPhoto.layer.borderColor = self.captureNewPhoto.titleLabel.textColor.CGColor;
    self.captureNewPhoto.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:18];
}

#pragma mark NewPhotoButton

- (IBAction)newPhotoButton:(id)sender{

    MainViewController *nextView = [[MainViewController alloc] initWithNibName:@"MainViewController"bundle:[NSBundle mainBundle]];
        [self.navigationController pushViewController:nextView animated:YES];

}

#pragma mark Search Poster Button

- (IBAction)searchButton:(id)sender {
   // [[WeatherHTTPClient sharedWeatherHTTPClient]MovieResponse];
    [SVProgressHUD show];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    AFJSONResponseSerializer *responseSerializer = [AFJSONResponseSerializer serializer];
    AFJSONRequestSerializer *requestSerializer = [AFJSONRequestSerializer serializer];
    [requestSerializer setValue:@"Content-Type" forHTTPHeaderField:@"application/json"];
    responseSerializer.acceptableContentTypes = [responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
    [manager GET:movieimagesUrl parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"JSON: %@", responseObject);
        NSArray *moviearrya = [responseObject objectForKey:@"bestOptionsList"];
        NSArray *movieNamesArry = [responseObject objectForKey:@"movieNames"];
        NSUserDefaults *movieimagesDef = [NSUserDefaults standardUserDefaults];
        [movieimagesDef setObject:moviearrya forKey:@"moviearrya"];
        [movieimagesDef setObject:movieNamesArry forKey:@"movieNamesArry"];
         Seacrh_Results *searchView = [Seacrh_Results new];
        [self.navigationController pushViewController:searchView animated:YES];
        [SVProgressHUD dismissWithDelay:1.0];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        [SVProgressHUD showErrorWithStatus:@"Error"];

    }];

     }


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
