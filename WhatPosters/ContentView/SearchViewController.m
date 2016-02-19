//
//  SearchViewController.m
//  WhatPosters
//
//  Created by mac on 11/27/15.
//  Copyright © 2015 Xululabs. All rights reserved.
//
#import "SearchViewController.h"
#import "MainViewController.h"
#import "SearchResult.h"
#import "SVProgressHUD.h"
#import "AFNetworking.h"
#import "AppDelegate.h"
#import "Base64.h"
#import "IndicatorView.h"
// service
static NSString *const  movieimagesUrl =  @"http://52.5.222.145:9000/flickwiz/uploadImage";

@interface SearchViewController () <UIWebViewDelegate>

{
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
@end

@implementation SearchViewController
@synthesize imageName;
@synthesize imageExt;
@synthesize theImage;
@synthesize imageHight;
@synthesize imageWeight;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.searchButton.hidden = YES;
    
    self.title = @"Search";
    [self screenSizeSetting];
    [self.view addSubview:imageView];
    _indicator = [[IndicatorView alloc]initWithTarget:self.view.window
                                           userEnable:YES
                                              message:@"Processing"
                                      backgroundColor:[UIColor colorWithRed:0.0/255.0
                                                                      green:0.0/255.0
                                                                       blue:0.0/255.0 alpha:0]
                                            fontColor:[UIColor whiteColor]];
    
    // start
    [self.view addSubview:self.indicator];
    self.indicator.center = CGPointMake(CGRectGetMidX(self.view.bounds),
                                        CGRectGetMidY(self.view.bounds));
    [self searchButtonCalling];
}

#pragma mark Search Poster Button

//- (IBAction)searchButton:(id)sender {

-(void)searchButtonCalling {
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
        SearchResult *searchViewResult = [SearchResult new];
        searchViewResult.jsonResponsDic = responseJsonResult;
        searchViewResult.selectedImage1 = imageView.image;
        
        [_indicator stop];
        [self.view setUserInteractionEnabled:YES];
        [self.navigationController pushViewController:searchViewResult animated:YES];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        [SVProgressHUD showErrorWithStatus:@"Error"];
        [_indicator stop];
        [self.view setUserInteractionEnabled:YES];
    }];
}


-(void)screenSizeSetting {

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
                CGRect rect = CGRectMake(90,200,220,300);
                imageView =[[UIImageView alloc] initWithFrame:rect];
                imageView.contentMode = UIViewContentModeScaleAspectFit;
                [self compressImage];
            }
        }
        //for iphone 4 4s
        else {
            if (imageHightA <= 350 ) {
                CGRect rect = CGRectMake(60,140,200,150);
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
}

#pragma mark function For Larg image Compress

- (UIImage *)compressImage {
    CGSize newSize = CGSizeMake(600, 800);
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
