//
//  SearchViewController.h
//  WhatPosters
//
//  Created by mac on 11/27/15.
//  Copyright © 2015 Xululabs. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SearchViewController : UIViewController

@property (nonatomic, weak) UIImage *theImage;

@property (nonatomic, weak) NSString *imageName;
@property (nonatomic, weak) NSString *imageExt;
@property (nonatomic, readwrite) double imageHight;
@property (nonatomic, readwrite) double imageWeight;
@end
