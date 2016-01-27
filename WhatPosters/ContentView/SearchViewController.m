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
#import "AFNetworking.h"
#import "AppDelegate.h"
#import "Base64.h"

// service
static NSString *const  movieimagesUrl = @"http://52.5.222.145:9000/myservice/uploadme";
static NSString *const  tesmovieimagesUrl1 = @"http://52.5.222.145:9000/myservice/upload1";
static NSString *const  tesmovieimagesUrl2 = @"http://52.5.222.145:9000/myservice/uploaded";

@interface SearchViewController () <UIWebViewDelegate>
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
    UIImageView *imageView;

}
@property (strong, nonatomic) IBOutlet UIButton *searchButton;
@property (strong, nonatomic) IBOutlet UIButton *captureNewPhoto;
@property (nonatomic, retain) UIWebView *webViewBG;
@end

@implementation SearchViewController //(animatedGIF)
@synthesize imageName;
@synthesize imageExt;
@synthesize theImage;
@synthesize imageHight;
@synthesize imageWeight;
@synthesize webViewBG;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"SearchView";
    NSInteger imageHightA = imageHight;
    NSInteger imageWeightA = imageWeight;
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    CGFloat height = [UIScreen mainScreen].bounds.size.height;
    if (width < height) {
    //for iphone 6 6s
    if (height == 667) {
     if (imageHightA <= 400 && imageWeightA <= 220) {
         CGRect rect = CGRectMake(75.0f,120.0f,220,imageHightA);
            imageView =[[UIImageView alloc] initWithFrame:rect];
            webViewBG = [[UIWebView alloc] initWithFrame:rect];
            imageView.contentMode = UIViewContentModeCenter;
       }
       else {
           CGRect rect = CGRectMake(75,200,220,220);
           imageView =[[UIImageView alloc] initWithFrame:rect];
           imageView.contentMode = UIViewContentModeScaleAspectFit;
           webViewBG = [[UIWebView alloc] initWithFrame:rect];
       }
     }
        // for iphone 5 and 5s
    else if (height == 568) {
        if (imageHightA <= 400 && imageWeightA <= 220) {
            CGRect rect = CGRectMake(48,100,220,imageHightA);
            imageView =[[UIImageView alloc] initWithFrame:rect];
            imageView.contentMode = UIViewContentModeCenter;
            webViewBG = [[UIWebView alloc] initWithFrame:rect];
        }
        else {
            CGRect rect = CGRectMake(58,150,200,200);
            imageView =[[UIImageView alloc] initWithFrame:rect];
            imageView.contentMode = UIViewContentModeScaleAspectFit;
            webViewBG = [[UIWebView alloc] initWithFrame:rect];
        }
    }
        //for iphone 6s plus
    else if (height == 736) {
        if (imageHightA <= 400 && imageWeightA <= 230) {
            CGRect rect = CGRectMake(90,150,231,imageHightA);
            imageView =[[UIImageView alloc] initWithFrame:rect];
            imageView.contentMode = UIViewContentModeCenter;
            webViewBG = [[UIWebView alloc] initWithFrame:rect];
        }
        else {
            CGRect rect = CGRectMake(90,200,220,220);
            imageView =[[UIImageView alloc] initWithFrame:rect];
            imageView.contentMode = UIViewContentModeScaleAspectFit;
            webViewBG = [[UIWebView alloc] initWithFrame:rect];
        }
    }
     //for iphone 4 4s
        else {
       if (imageHightA <= 350 ) {
           CGRect rect = CGRectMake(50,80,220,imageHightA);
           imageView =[[UIImageView alloc] initWithFrame:rect];
           imageView.contentMode = UIViewContentModeCenter;
           webViewBG = [[UIWebView alloc] initWithFrame:rect];
       }
       else {
           CGRect rect = CGRectMake(50,100,200,200);
           imageView =[[UIImageView alloc] initWithFrame:rect];
           imageView.contentMode = UIViewContentModeScaleAspectFit;
           webViewBG = [[UIWebView alloc] initWithFrame:rect];
       }
      }
    }
    [self.view addSubview:imageView];
    imageView.image = theImage;
    [webViewBG.layer setBackgroundColor:[[UIColor colorWithWhite:0 alpha:0.5] CGColor]];
    webViewBG.scalesPageToFit = YES;
    webViewBG.delegate = self;
    [webViewBG setOpaque:NO];
    [self.view addSubview:webViewBG];
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"animation_mob" ofType:@"gif"];
    NSData *gif1 = [NSData dataWithContentsOfFile:filePath];
    [webViewBG loadData:gif1 MIMEType:@"image/gif" textEncodingName:nil baseURL:nil];
    webViewBG.hidden = YES;
}

#pragma mark NewPhotoButton

- (IBAction)newPhotoButton:(id)sender{
    MainViewController *nextView = [[MainViewController alloc] initWithNibName:@"MainViewController"bundle:[NSBundle mainBundle]];
        [self.navigationController pushViewController:nextView animated:YES];
}

#pragma mark Search Poster Button

- (IBAction)searchButton:(id)sender {
    webViewBG.hidden = NO;
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
        webViewBG.hidden = YES;
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
     [SVProgressHUD showErrorWithStatus:@"Error"];
        [SVProgressHUD showErrorWithStatus:@"Error"];
        webViewBG.hidden = YES;
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return NO;
}

@end
