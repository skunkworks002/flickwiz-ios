//
//  TextViewCell.m
//  Scorefolio
//
//  Created by Atif Saeed on 22/07/2015.
//  Copyright (c) 2015 XULU Labs. All rights reserved.
//

#import "TextViewCell.h"

@implementation TextViewCell

- (void)awakeFromNib {
    // Initialization code
    [_customTextView.layer setCornerRadius:2.0f];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
