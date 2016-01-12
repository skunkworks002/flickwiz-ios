 //
//  MoviewDetailController.m
//  FlickWiz
//
//  Created by mac on 12/30/15.
//  Copyright © 2015 Qazi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Social/Social.h>
#import "MoviewDetailController.h"
#import "ASAlertView.h"
#import "LableCell.h"
#import "PhotoCell.h"
#import "TextViewCell.h"
#import "PickLabelCell.h"
#import "ActionSheetPicker.h"
#import "ActionSheetPicker.h"
#import "ActionSheetDatePicker.h"
#import "ASAlertView.h"
#import "ButtonCell.h"
#import "AFNetworking.h"
#import "MoviesPersonsDetailView.h"

static NSString *const  movieSubDetailUrl = @"http://52.5.222.145:9000/myservice/persondetail";

@interface MoviewDetailController () <UINavigationControllerDelegate, UITextViewDelegate,UIAlertViewDelegate> {
    
    NSInteger index;
    NSInteger item;
    NSInteger convertselectItem;
    NSString *actorNameString;
    NSString *typeNameString;
    NSString *diractorNameString;
    NSString *writerNameString;
    
    // array separation
    NSArray *actornameExtractArray;
    NSArray *directrnameExtractArray;
    NSArray *writernameExtractArray1;
    NSArray *movietypenameExtractArray;
    
    AFHTTPRequestOperationManager *manager;

}
@property (nonatomic, strong) AbstractActionSheetPicker *actionSheetPicker;

@end

@implementation MoviewDetailController
@synthesize selectedMovieName;
@synthesize selectedImage;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Movie Details";
    index = 0;
    
    // self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageWithContentsOfFile:[[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"ImageUploadedByModMyi1342057019.344337.jpg"]]];
    
    // Separate String by comma & create Array for picker
    actornameExtractArray = [_selectedmovieMakers componentsSeparatedByString:@","];
    directrnameExtractArray = [_selectedmoviedirectorName componentsSeparatedByString:@","];
    writernameExtractArray1 = [_selectedmoviewriterName componentsSeparatedByString:@","];
    movietypenameExtractArray = [_selectedmovieType componentsSeparatedByString:@","];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    switch (index) {
        case 0:
            return 25;
            break;
        default:
            break;
    }
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (index) {
        case 0: {
            if (indexPath.section == 0) {
                static NSString *CellIdentifier = @"PhotoCell";
                PhotoCell *cell = (PhotoCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
                cell = [[[NSBundle mainBundle] loadNibNamed:@"PhotoCell" owner:self options:nil] objectAtIndex:0];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.imageViewCell.image = selectedImage;
                return  cell;
            }
            // For Lable Show
            if ((indexPath.section == 1) || (indexPath.section == 2) || (indexPath.section == 3) || (indexPath.section == 7) || (indexPath.section == 11) || (indexPath.section == 12) || (indexPath.section == 13) || (indexPath.section == 17) || (indexPath.section == 21) || (indexPath.section == 23)) {
                
                static NSString *CellIdentifier = @"LableCell";
                LableCell *cell = (LableCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
                cell = [[[NSBundle mainBundle] loadNibNamed:@"LableCell" owner:self options:nil] objectAtIndex:0];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                
                // Movie Name
                if (indexPath.section == 1) {
                    cell.customLable.text = @"Movie Name";
                    [cell.customLable setFont:[UIFont boldSystemFontOfSize:17]];
                    return cell;
                }
                if (indexPath.section == 2) {
                    cell.customLable.text = selectedMovieName;
                    cell.customLable.frame = CGRectMake(30, 0, 270, 30);
                    return cell;
                }
                
                // Actor Names
                if (indexPath.section == 3) {
                    cell.customLable.text =@"Actor Name";
                    [cell.customLable setFont:[UIFont boldSystemFontOfSize:17]];
                    return cell;
                }
                
                // Movie Types
                if (indexPath.section == 7) {
                    cell.customLable.text = @"Movie Type";
                    [cell.customLable setFont:[UIFont boldSystemFontOfSize:17]];
                    return cell;
                }
                
                // Movie Ranking
                if (indexPath.section == 11) {
                    cell.customLable.text = @"Movie Ranking";
                    [cell.customLable setFont:[UIFont boldSystemFontOfSize:17]];
                    return cell;
                }
                if (indexPath.section == 12) {
                    cell.customLable.text = _selectedmovieRaking;
                    
                    cell.customLable.frame = CGRectMake(30, 0, 270, 30);
                    
                    return cell;
                }
                
                // Diractor Names
                if (indexPath.section == 13) {
                    cell.customLable.text =@"Diractor Name";
                    [cell.customLable setFont:[UIFont boldSystemFontOfSize:17]];
                    return cell;
                }
                
                // Writer Names
                if (indexPath.section == 17) {
                    cell.customLable.text =@"Writer Name";
                    [cell.customLable setFont:[UIFont boldSystemFontOfSize:17]];
                    return cell;
                }
                
                // Description
                if (indexPath.section == 21) {
                    cell.customLable.text =@"Movie Description";
                    [cell.customLable setFont:[UIFont boldSystemFontOfSize:17]];
                    return cell;
                }
                
                // Share Options
                if (indexPath.section == 23) {
                    cell.customLable.text =@"Share Options";
                    [cell.customLable setFont:[UIFont boldSystemFontOfSize:17]];
                    return cell;
                }
                return cell;
            }
            
            if (indexPath.section == 22) {
                static NSString *CellIdentifier = @"TextViewCell";
                TextViewCell *cell = (TextViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
                cell = [[[NSBundle mainBundle] loadNibNamed:@"TextViewCell"owner:self options:nil] objectAtIndex:0];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                //   cell.customTextView.delegate = self;
                cell.customTextView.text = _selectedmovieDescrption;
                return cell;
            }
            
            if (indexPath.section == 24) {
                ButtonCell *cell = [self textFieldCellWithTableView:tableView];
                    [cell.faceBookButton addTarget:self action:@selector(facebookPostBtFunction) forControlEvents:UIControlEventTouchUpInside];
                    [cell.twitterButton addTarget:self action:@selector(twitterPostButtonFunction) forControlEvents:UIControlEventTouchUpInside];
                    cell.twitterButton.backgroundColor = [UIColor grayColor];
                    cell.faceBookButton.backgroundColor = [UIColor grayColor];
                    return cell;
                }
            
            // Actor Names Buttons + actions
            if (indexPath.section == 4) {
                ButtonCell *cell11 = [self textFieldCellWithTableView:tableView];
                cell11.faceBookButton.tag = indexPath.row;
                NSString *actor1 = actornameExtractArray[0];
                [cell11.faceBookButton setTitle:actor1 forState:UIControlStateNormal];
                cell11.faceBookButton.frame = CGRectMake(30, 0, 270, 30);
                cell11.faceBookButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
                [cell11.faceBookButton addTarget:self action:@selector(movieResponse:) forControlEvents:UIControlEventTouchUpInside];
                cell11.twitterButton.hidden = YES;
                return cell11;
            }
            if (indexPath.section == 5) {
                ButtonCell *cell2 = [self textFieldCellWithTableView:tableView];
                if ([actornameExtractArray count] <= 1) {
                    cell2.hidden = YES;
                    return cell2;
                }
                cell2.faceBookButton.tag = indexPath.row +1;
                NSString *actor2 = actornameExtractArray[1];
                [cell2.faceBookButton setTitle:actor2 forState:UIControlStateNormal];
                cell2.faceBookButton.frame = CGRectMake(30, 0, 270, 30);
                cell2.faceBookButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
                [cell2.faceBookButton addTarget:self action:@selector(movieResponse:)forControlEvents:UIControlEventTouchUpInside];
                cell2.twitterButton.hidden = YES;
                return cell2;
                }
                if (indexPath.section == 6) {
                ButtonCell *cell = [self textFieldCellWithTableView:tableView];
                if ([actornameExtractArray count] <= 2) {
                    cell.hidden = YES;
                    return cell;
                }
                cell.faceBookButton.tag = indexPath.row +2;
                NSString *actor3 = actornameExtractArray[2];
                [cell.faceBookButton setTitle:actor3 forState:UIControlStateNormal];
                cell.faceBookButton.frame = CGRectMake(30, 0, 270, 30);
                cell.faceBookButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
                [cell.faceBookButton addTarget:self action:@selector(movieResponse:)forControlEvents:UIControlEventTouchUpInside];
                cell.twitterButton.hidden = YES;
                return cell;
            }
            
            // Movie Type Button + Actions
            if (indexPath.section == 8) {
                ButtonCell *cell = [self textFieldCellWithTableView:tableView];
                cell.faceBookButton.tag = indexPath.row +3;
                NSString *movieType = movietypenameExtractArray[0];
                [cell.faceBookButton setTitle:movieType forState:UIControlStateNormal];
                cell.faceBookButton.frame = CGRectMake(30, 0, 270, 30);
                cell.faceBookButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
                [cell.faceBookButton addTarget:self action:@selector(movieResponse:)forControlEvents:UIControlEventTouchUpInside];
                cell.twitterButton.hidden = YES;
                return cell;
            }
            if (indexPath.section == 9) {
                ButtonCell *cell = [self textFieldCellWithTableView:tableView];
                if ([movietypenameExtractArray count] <= 1){
                    cell.hidden = YES;
                    return cell;
                }
                cell.faceBookButton.tag = indexPath.row +4;
                NSString *movieType = movietypenameExtractArray[1];
                [cell.faceBookButton setTitle:movieType forState:UIControlStateNormal];
                cell.faceBookButton.frame = CGRectMake(30, 0, 270, 30);
                cell.faceBookButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
                [cell.faceBookButton addTarget:self action:@selector(movieResponse:)forControlEvents:UIControlEventTouchUpInside];
                cell.twitterButton.hidden = YES;
                return cell;
            }
            if (indexPath.section == 10) {
                ButtonCell *cell = [self textFieldCellWithTableView:tableView];
                if ([movietypenameExtractArray count] <= 2) {
                    cell.hidden = YES;
                    return cell;
                }
                cell.faceBookButton.tag = indexPath.row +5;
                NSString *movieType = movietypenameExtractArray[2];
                [cell.faceBookButton setTitle:movieType forState:UIControlStateNormal];
                cell.faceBookButton.frame = CGRectMake(30, 0, 270, 30);
                cell.faceBookButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
                [cell.faceBookButton addTarget:self action:@selector(movieResponse:)forControlEvents:UIControlEventTouchUpInside];
                cell.twitterButton.hidden = YES;
                return cell;
            }
            
            // Diractor Names Buttons + Actions
            if (indexPath.section == 14) {
                ButtonCell *cell = [self textFieldCellWithTableView:tableView];
                cell.faceBookButton.tag = indexPath.row +6;
                NSString *movieDiractor = directrnameExtractArray[0];
                [cell.faceBookButton setTitle:movieDiractor forState:UIControlStateNormal];
                cell.faceBookButton.frame = CGRectMake(30, 0, 270, 30);
                cell.faceBookButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
                [cell.faceBookButton addTarget:self action:@selector(movieResponse:)forControlEvents:UIControlEventTouchUpInside];
                cell.twitterButton.hidden = YES;
                return cell;
            }
            if (indexPath.section == 15) {
                ButtonCell *cell = [self textFieldCellWithTableView:tableView];
                if ([directrnameExtractArray count] <= 1) {
                    cell.hidden = YES;
                    return cell;
                }
                cell.faceBookButton.tag = indexPath.row +7;

                NSString *movieDiractor = directrnameExtractArray[1];
                [cell.faceBookButton setTitle:movieDiractor forState:UIControlStateNormal];
                cell.faceBookButton.frame = CGRectMake(30, 0, 270, 30);
                cell.faceBookButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
                [cell.faceBookButton addTarget:self action:@selector(movieResponse:)forControlEvents:UIControlEventTouchUpInside];
                cell.twitterButton.hidden = YES;
                return cell;
            }
            if (indexPath.section == 16) {
                ButtonCell *cell = [self textFieldCellWithTableView:tableView];
                if ([directrnameExtractArray count] <= 2) {
                    cell.hidden = YES;
                    return cell;
                }
                cell.faceBookButton.tag = indexPath.row +8;
                NSString *movieDiractor = directrnameExtractArray[2];
                [cell.faceBookButton setTitle:movieDiractor forState:UIControlStateNormal];
                cell.faceBookButton.frame = CGRectMake(30, 0, 270, 30);
                cell.faceBookButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
                [cell.faceBookButton addTarget:self action:@selector(movieResponse:)forControlEvents:UIControlEventTouchUpInside];
                cell.twitterButton.hidden = YES;
                return cell;
            }
            
            // Writer Names Button + Actions
            if (indexPath.section == 18) {
                ButtonCell *cell = [self textFieldCellWithTableView:tableView];
                cell.faceBookButton.tag = indexPath.row +9;

                NSString *movieWriter = writernameExtractArray1[0];
                [cell.faceBookButton setTitle:movieWriter forState:UIControlStateNormal];
                cell.faceBookButton.frame = CGRectMake(30, 0, 270, 30);
                cell.faceBookButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
                [cell.faceBookButton addTarget:self action:@selector(movieResponse:)forControlEvents:UIControlEventTouchUpInside];
                cell.twitterButton.hidden = YES;
                return cell;
            }
            if (indexPath.section == 19) {
                ButtonCell *cell = [self textFieldCellWithTableView:tableView];
                if ([writernameExtractArray1 count] <= 1) {
                    cell.hidden = YES;
                    return cell;
                }
                cell.faceBookButton.tag = indexPath.row +10;

                NSString *movieWriter = writernameExtractArray1[1];
                [cell.faceBookButton setTitle:movieWriter forState:UIControlStateNormal];
                cell.faceBookButton.frame = CGRectMake(30, 0, 270, 30);
                cell.faceBookButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
                [cell.faceBookButton addTarget:self action:@selector(movieResponse:)forControlEvents:UIControlEventTouchUpInside];
                cell.twitterButton.hidden = YES;
                return cell;
            }
            if (indexPath.section == 20) {
                    ButtonCell *cell = [self textFieldCellWithTableView:tableView];
                    if ([writernameExtractArray1 count] <= 2) {
                        cell.hidden = YES;
                        return cell;
                    }
                    cell.faceBookButton.tag = indexPath.row +11;
                    NSString *movieWriter = writernameExtractArray1[2];
                    [cell.faceBookButton setTitle:movieWriter forState:UIControlStateNormal];
                    cell.faceBookButton.frame = CGRectMake(30, 0, 270, 30);
                    cell.faceBookButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
                     [cell.faceBookButton addTarget:self action:@selector(movieResponse:)forControlEvents:UIControlEventTouchUpInside];
                    cell.twitterButton.hidden = YES;
                    return cell;
                }
        }break;
        default:
            break;
    }
    return nil;
}

- (ButtonCell *)textFieldCellWithTableView:(UITableView *)tableView {
    static NSString *CellIdentifier = @"ButtonCell";
    ButtonCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"ButtonCell" owner:self options:nil] objectAtIndex:0];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 250;
    }
    if (indexPath.section == 22) {
        return 75;
    }
    if(indexPath.section == 24){
        return 50;
    }
    
    // code for nill index for Movie Type
    if (indexPath.section == 5) {
        if ([actornameExtractArray count] <= 1) {
            return 0;
        }
    }
    if (indexPath.section == 6) {
        if ([actornameExtractArray count] <= 2) {
            return 0;
        }
    }

    // code for nill index for Movie Type
    if (indexPath.section == 9) {
        if ([movietypenameExtractArray count] <= 1) {
            return 0;
        }
    }
    if (indexPath.section == 10) {
        if ([movietypenameExtractArray count] <= 2) {
            return 0;
        }
    }
    
    // code for nill index for diractor
    if (indexPath.section == 15) {
     if ([directrnameExtractArray count] <= 1) {
          return 0;
        }
      }
    if (indexPath.section == 16) {
      if ([directrnameExtractArray count] <= 2) {
          return 0;
        }
    }
    
    // code for nill index for Writer
    if (indexPath.section == 19) {
        if ([writernameExtractArray1 count] <= 1) {
            return 0;
        }
    }
    if (indexPath.section == 20) {
        if ([writernameExtractArray1 count] <= 2) {
            return 0;
        }
    }
    return 40;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    /*
     switch (index) {
     case 0: {
     if (indexPath.section == 2) {
     [self showActorNameFunction];
     }
     else if (indexPath.section == 3){
     [self typeNameFunction];
     }
     else if(indexPath.section == 5){
     [self directorNameFunction];
     }
     else if (indexPath.section == 6){
     [self writerNameFunction];
     }
     }break;
     default:
     break;
     }
     */
}

/*
 - (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
 NSString *result = nil;
 switch (index) {
 case 0: {
 switch (section) {
 case 1:
 result = @"Name of Movie";
 break;
 case 2:
 result = @"Actor Name Picker";
 break;
 case 3:
 result = @"Movie Type Picker";
 break;
 case 4:
 result = @"Ranking";
 break;
 case 5:
 result = @"Diractor Name Picker";
 break;
 case 6:
 result = @"Writer Name Picker";
 break;
 case 7:
 result = @"Descripton";
 break;
 case 8:
 result = @"Sharing Option";
 break;
 default:
 break;
 }
 }break;
 default:
 break;
 }
 return result;
 }
 */

#pragma Mark Share To FaceBook and Twitter

-(void)twitterPostButtonFunction {
    if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter]) {
        SLComposeViewController *tweetSheet = [SLComposeViewController
                                               composeViewControllerForServiceType:SLServiceTypeTwitter];
        [tweetSheet setInitialText:selectedMovieName];
        [tweetSheet addURL:[NSURL URLWithString:_selectedmoviedetailpathString]];
        [tweetSheet addImage:selectedImage];
        [self presentViewController:tweetSheet animated:YES completion:nil];
    }
    else {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Twitter" message:@"A Twitter account must be set up on your device. login within your device setting twitter account.." preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction* ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
        [alertController addAction:ok];
        [self presentViewController:alertController animated:YES completion:nil];
    }
}

-(void)facebookPostBtFunction{
    if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeFacebook]) {
        SLComposeViewController *fbookSheet = [SLComposeViewController
                                               composeViewControllerForServiceType:SLServiceTypeFacebook];
        [fbookSheet setInitialText:selectedMovieName];
        [fbookSheet addImage:selectedImage];
        [fbookSheet addURL:[NSURL URLWithString:_selectedmoviedetailpathString]];
        [self presentViewController:fbookSheet animated:YES completion:nil];
    }
    else {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"FaceBook" message:@"A FaceBook account must be set up on your device. login within your device setting FaceBook account.." preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction* ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
        [alertController addAction:ok];
        [self presentViewController:alertController animated:YES completion:nil];
    }
}


-(void)movieResponse:(UIButton*)sender {
 
    NSInteger abcd = sender.tag;;

    NSString *myname;
    
    // Fpr Actor Button Click
    if (abcd == 0) {
        NSString *actor1 = actornameExtractArray[0];
        myname = actor1;
    }
    else if (abcd == 1){
        NSString *actor2 = actornameExtractArray[1];
        myname = actor2;
        
    }
    else if (abcd == 2){
        NSString *actor2 = actornameExtractArray[2];
        myname = actor2;
        
    }
    
    // Movie Type Button Click
    else if (abcd == 3){
        NSString *actor2 = movietypenameExtractArray[0];
        myname = actor2;
        
    }
    else if (abcd == 4){
        NSString *actor2 = movietypenameExtractArray[1];
        myname = actor2;
        
    }
    else if (abcd == 5){
        NSString *actor2 = movietypenameExtractArray[2];
        myname = actor2;
        
    }
    
    // Diractor Name Button Click
    else if (abcd == 6){
        NSString *actor2 = directrnameExtractArray[0];
        myname = actor2;
        
    }
    else if (abcd == 7){
        NSString *actor2 = directrnameExtractArray[1];
        myname = actor2;
        
    }
    else if (abcd == 8){
        NSString *actor2 = directrnameExtractArray[2];
        myname = actor2;
        
    }
    
    
    // Writer Names Button Click
    else if (abcd == 9){
        NSString *actor2 = writernameExtractArray1[0];
        myname = actor2;
        
    }
    else if (abcd == 10){
        NSString *actor2 = writernameExtractArray1[1];
        myname = actor2;
        
    }
    else if (abcd == 11){
        NSString *actor2 = writernameExtractArray1[2];
        myname = actor2;
        
    }
    
        // NSString *myname = @"EmilioFernándezRomo";
        NSDictionary *parameters =  @{@"personName":myname};
        manager = [AFHTTPRequestOperationManager manager];
        manager.requestSerializer = [AFJSONRequestSerializer serializer];
        [manager GET:movieSubDetailUrl parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
       
            NSDictionary *jsonResponseDetails = responseObject;
      //   NSLog(@"Error: %@", jsonResponseForActorNames);
            
            MoviesPersonsDetailView *moviesPersonDetails = [MoviesPersonsDetailView new];
            moviesPersonDetails.jsonResponsDic = jsonResponseDetails;
         [self.navigationController pushViewController:moviesPersonDetails animated:YES];

     } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         NSLog(@"Error: %@", error);
         
         UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"FlickWiz" message:@"Data is not Avilable" preferredStyle:UIAlertControllerStyleAlert];
         
         UIAlertAction* ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
         [alertController addAction:ok];
         
         [self presentViewController:alertController animated:YES completion:nil];
         
         
     }];
    
}
     

@end
