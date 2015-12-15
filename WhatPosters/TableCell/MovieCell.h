//
//  MovieCell.h
//  WhatPosters
//
//  Created by Qazi on 27/11/2015.
//  Copyright © 2015 Qazi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MovieCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *movienameLabel;
@property (strong, nonatomic) IBOutlet UILabel *movieDateLabel;
@property (strong, nonatomic) IBOutlet UIImageView *movieImages;
@end
