//
//  SearchViewController.m
//  WhatPosters
//
//  Created by mac on 11/27/15.
//  Copyright © 2015 Xululabs. All rights reserved.
//

#import "SearchViewController.h"
#import "MainViewController.h"
#import "SeacrhResults.h"
#import "SVProgressHUD.h"
#import "GiFHUD.h"
#import "AFNetworking.h"
#import "AppDelegate.h"
#import "Base64.h"

/// service
static NSString *const  movieimagesUrl = @"http://52.5.222.145:9000/myservice/uploadme";

//static NSString *const  movieimagesUrl = @"http://52.5.222.145:9000/myservice/upload";
static NSString *const  tesmovieimagesUrl1 = @"http://52.5.222.145:9000/myservice/upload1";
static NSString *const  tesmovieimagesUrl2 = @"http://52.5.222.145:9000/myservice/uploaded";

@interface SearchViewController () //<WeatherHTTPClientDelegate>
{

    dispatch_queue_t backgroundqueee;
    NSArray *imagesUrlArray;
    NSMutableDictionary *responseJsonResult;
    NSString *imagerefUrl;
    NSData *imageData;
    NSUInteger imageSize;
    NSString *imagesizeString;
    NSString *strEncoded;
    NSDictionary *parameters;
    AFHTTPRequestOperationManager *manager;

}

@property (strong, nonatomic) IBOutlet UIImageView *imageView;
@property (strong, nonatomic) IBOutlet UIButton *searchButton;
@property (strong, nonatomic) IBOutlet UIButton *captureNewPhoto;
@end

@implementation SearchViewController
@synthesize imageName;
@synthesize imageExt;
@synthesize imageView;
@synthesize theImage;

- (void)viewDidLoad {
    [super viewDidLoad];
    //View Tittle
    self.title = @"SearchView";
    
    imageView.image = theImage;
    
    [GiFHUD setGifWithImageName:@"animation_mob.gif"];
}

#pragma mark NewPhotoButton

- (IBAction)newPhotoButton:(id)sender{
    MainViewController *nextView = [[MainViewController alloc] initWithNibName:@"MainViewController"bundle:[NSBundle mainBundle]];
        [self.navigationController pushViewController:nextView animated:YES];
}

#pragma mark Search Poster Button

- (IBAction)searchButton:(id)sender {
    
    [GiFHUD show];
    imageData = UIImageJPEGRepresentation(theImage, 1.0);
    imageSize   = imageData.length;
    imagesizeString = [NSString stringWithFormat:@"%lu",(unsigned long)imageSize];
    strEncoded = [Base64 encode:imageData];
    parameters = @{@"name":imageName, @"ext":imageExt, @"size":imagesizeString,@"base64Code":strEncoded};
    manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager POST:movieimagesUrl parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        responseJsonResult = responseObject;
        SeacrhResults *searchViewResult = [SeacrhResults new];
        searchViewResult.jsonResponsDic = responseJsonResult;
        [self.navigationController pushViewController:searchViewResult animated:YES];
          [GiFHUD dismiss];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
     [SVProgressHUD showErrorWithStatus:@"Error"];
        [SVProgressHUD showErrorWithStatus:@"Error"];
        [GiFHUD dismiss];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return NO;
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
