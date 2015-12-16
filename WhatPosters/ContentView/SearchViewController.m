//
//  SearchViewController.m
//  WhatPosters
//
//  Created by mac on 11/27/15.
//  Copyright © 2015 Xululabs. All rights reserved.
//

// remove some comted code from search view

#import "SearchViewController.h"
#import "MainViewController.h"
#import "Seacrh Results.h"
#import "SVProgressHUD.h"
#import "Utility.h"
#import "AFNetworking.h"
#import "WeatherHTTPClient.h"
#import "AppDelegate.h"
#import "Venue.h"
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
    NSString *imageName;
    NSString *imageExt;
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

- (void)viewDidLoad {
    [super viewDidLoad];
        
//    WeatherHTTPClient *sampleProtocol = (WeatherHTTPClient *)[[WeatherHTTPClient alloc]init];
//    sampleProtocol.delegate = self;
    
    //View Tittle
    self.title = @"SearchView";
    
    //  SET BACKGROUNG IMAGE OF VIEW
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageWithContentsOfFile:[[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"ImageUploadedByModMyi1342057019.344337.jpg"]]];
    self.imageView.image = _theImage;
    
    NSUserDefaults *imageDef = [NSUserDefaults standardUserDefaults];
    imageName = [imageDef objectForKey:@"actulimageName"];
    imageExt = [imageDef objectForKey:@"imageExention"];
    
    ///image animation
    _imageView.layer.cornerRadius = 60.0f;
    _imageView.layer.borderWidth = 2.0f;
    _imageView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    _imageView.clipsToBounds = YES;
    
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
    
    [SVProgressHUD showWithStatus:@"Progress...."];
    imageData = UIImageJPEGRepresentation(_theImage, 1.0);
    imageSize   = imageData.length;
    imagesizeString = [NSString stringWithFormat:@"%lu",(unsigned long)imageSize];
    strEncoded = [Base64 encode:imageData];
    parameters = @{@"name":imageName, @"ext":imageExt, @"size":imagesizeString,@"base64Code":strEncoded};
    manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager POST:movieimagesUrl parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        responseJsonResult = responseObject;
        Seacrh_Results *searchViewResult = [Seacrh_Results new];
        searchViewResult.jsonResponsDic = responseJsonResult;
        [self.navigationController pushViewController:searchViewResult animated:YES];
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
