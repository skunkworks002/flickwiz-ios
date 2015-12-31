//
//  PIckLabelCell.m
//  Scorefolio
//
//  Created by Atif Saeed on 15/08/2015.
//  Copyright (c) 2015 XULU Labs. All rights reserved.
//

#import "PickLabelCell.h"

@implementation PickLabelCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        NSArray *topLevelObjects;
        topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"PickLabelCell" owner:self options:nil];
        
        for (id currentObj in topLevelObjects ) {
            if ([currentObj isKindOfClass:[PickLabelCell class]]) {
                self = (PickLabelCell *) currentObj;
            }
        }
    } else {
        return nil;
    }
    
    self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    self.accessoryView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"downArrow.png"]highlightedImage:[UIImage imageNamed:@"downArrow.png"]];

    self.textLabel.textColor = [UIColor darkGrayColor];
   self.textLabel.font = [UIFont fontWithName:@"HelveticaNeue-Regular" size:17];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    return self;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
