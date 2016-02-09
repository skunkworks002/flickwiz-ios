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
#import "IndicatorView.h"
// service
static NSString *const  movieimagesUrl =  @"http://52.5.222.145:9000/flickwiz/uploadImage";

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
@property (nonatomic,strong) IndicatorView *indicator;
@property (strong, nonatomic) IBOutlet UIButton *searchButton;
@property (strong, nonatomic) IBOutlet UIButton *captureNewPhoto;
@end

@implementation SearchViewController
@synthesize imageName;
@synthesize imageExt;
@synthesize theImage;
@synthesize imageHight;
@synthesize imageWeight;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"SearchView";
    self.view.backgroundColor = [UIColor colorWithRed:44.0 / 255.0 green:42.f / 255.f blue:54.f / 255.f alpha:1];

    //Size's of imageView's diffetrnts ios screens
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
                imageView.contentMode = UIViewContentModeCenter;
                imageView.image = theImage;
            }
            else {
                CGRect rect = CGRectMake(75,150,220,300);
                imageView =[[UIImageView alloc] initWithFrame:rect];
                imageView.contentMode = UIViewContentModeScaleAspectFit;
                [self compressImage];
            }
        }
        // for iphone 5 and 5s
        else if (height == 568) {
            if (imageHightA <= 400 && imageWeightA <= 220) {
                CGRect rect = CGRectMake(48,100,220,imageHightA);
                imageView =[[UIImageView alloc] initWithFrame:rect];
                imageView.contentMode = UIViewContentModeCenter;
                imageView.image = theImage;
            }
            else {
                CGRect rect = CGRectMake(50,100,220,300);
                imageView =[[UIImageView alloc] initWithFrame:rect];
                imageView.contentMode = UIViewContentModeScaleToFill;
                [self compressImage];
            }
        }
        //for iphone 6s plus
        else if (height == 736) {
            if (imageHightA <= 400 && imageWeightA <= 230) {
                CGRect rect = CGRectMake(90,150,231,imageHightA);
                imageView =[[UIImageView alloc] initWithFrame:rect];
                imageView.contentMode = UIViewContentModeCenter;
                imageView.image = theImage;
            }
            else {
                CGRect rect = CGRectMake(90,200,220,220);
                imageView =[[UIImageView alloc] initWithFrame:rect];
                imageView.contentMode = UIViewContentModeScaleAspectFit;
                [self compressImage];
            }
        }
        //for iphone 4 4s
        else {
            if (imageHightA <= 350 ) {
                CGRect rect = CGRectMake(50,80,220,imageHightA);
                imageView =[[UIImageView alloc] initWithFrame:rect];
                imageView.contentMode = UIViewContentModeCenter;
                imageView.image = theImage;
            }
            else {
                CGRect rect = CGRectMake(50,100,200,200);
                imageView =[[UIImageView alloc] initWithFrame:rect];
                imageView.contentMode = UIViewContentModeScaleAspectFit;
                [self compressImage];
            }
        }
    }
    [self.view addSubview:imageView];
}

#pragma mark NewPhotoButton

- (IBAction)newPhotoButton:(id)sender{
    MainViewController *nextView = [[MainViewController alloc] initWithNibName:@"MainViewController"bundle:[NSBundle mainBundle]];
    [self.navigationController pushViewController:nextView animated:YES];
}

#pragma mark Search Poster Button

- (IBAction)searchButton:(id)sender {
    _indicator = [[IndicatorView alloc]initWithTarget:self.view.window
                                           userEnable:YES
                                              message:@"Processing"
                                      backgroundColor:[UIColor colorWithRed:0.0/255.0
                                                                      green:0.0/255.0
                                                                       blue:0.0/255.0 alpha:0]
                                            fontColor:[UIColor whiteColor]];
    // start
    [_indicator start];
    imageData = UIImageJPEGRepresentation(imageView.image, 1.0);
    imageSize = imageData.length;
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
        [_indicator stop];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        [SVProgressHUD showErrorWithStatus:@"Error"];
        [_indicator stop];
    }];
}

// function For Larg image Compress
- (UIImage *)compressImage {
    CGSize newSize = CGSizeMake(300, 500);
    UIGraphicsBeginImageContext(newSize);// a CGSize that has the size you want
    [theImage drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    //image is the original UIImage
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    imageView.image = newImage;
    return newImage;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (BOOL)shouldAutorotate
{
    return NO;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait;
}

@end
