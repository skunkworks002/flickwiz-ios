 //
//  PhotoCell.h
//  Scorefolio
//
//  Created by Atif Saeed on 22/07/2015.
//  Copyright (c) 2015 XULU Labs. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PhotoCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UIImageView *imageViewCell;
@property (strong, nonatomic) IBOutlet UILabel *rankingLabel;
@property (strong, nonatomic) IBOutlet UILabel *fullrankinglabel;
@property (strong, nonatomic) IBOutlet UIButton *starLabel;

@end
