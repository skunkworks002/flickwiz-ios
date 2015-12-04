//
//  SearchViewController.h
//  WhatPosters
//
//  Created by mac on 11/27/15.
//  Copyright © 2015 Xululabs. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol GetmovieimagesnameArray <NSObject>

- (void)GetmoviesArray :(NSDictionary *)movieimagesDictr ;

@end

@interface SearchViewController : UIViewController

@property (assign, nonatomic) id<GetmovieimagesnameArray> delegateMC;

@property (nonatomic, retain) UIImage *theImage;

@property (strong, nonatomic) IBOutlet UIImageView *imageView;

@property (strong, nonatomic) IBOutlet UIButton *searchButton;
@property (strong, nonatomic) IBOutlet UIButton *captureNewPhoto;

-(void)setImage:(UIImage *)image;

@end
