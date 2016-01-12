//
//  MoviewDetailController.h
//  FlickWiz
//
//  Created by mac on 12/30/15.
//  Copyright © 2015 Qazi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MoviewDetailController : UITableViewController

@property (weak, nonatomic) UIImage *selectedImage;
@property (weak, nonatomic) IBOutlet UIImageView *avatar;

@property (weak, nonatomic) NSString *selectedMovieName;
@property (weak, nonatomic) NSString *selectedDescip;
@property (weak, nonatomic) NSString *selectedmovieType;
@property (weak, nonatomic) NSString *selectedmovieDescrption;
@property (weak, nonatomic) NSString *selectedmovieMakers;
@property (weak, nonatomic) NSString *selectedmovieRaking;
@property (weak, nonatomic) NSString *selectedmoviedirectorName;
@property (weak, nonatomic) NSString *selectedmoviewriterName;
@property (weak, nonatomic) NSString *selectedmoviedetailpathString;

-(IBAction)twitterPostButton:(id)sender;
-(IBAction)faceBookPostButton:(id)sender;

@end
