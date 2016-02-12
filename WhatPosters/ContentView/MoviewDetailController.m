//
//  MoviewDetailController.m
//  FlickWiz
//
//  Created by mac on 12/30/15.
//  Copyright © 2015 Qazi. All rights reserved.
//
#define ApplicationTitle @"Flick Wiz"

#import <UIKit/UIKit.h>
#import <Social/Social.h>
#import "MoviewDetailController.h"
#import "ASAlertView.h"
#import "LableCell.h"
#import "PhotoCell.h"
#import "TextViewCell.h"
#import "ASAlertView.h"
#import "ButtonCell.h"
#import "AFNetworking.h"
#import "MoviesPersonsDetailView.h"
#import "MovieTypeDetailController.h"
#import "SVProgressHUD.h"
#import "CustomButtonCell.h"

static const CGFloat cellSpacing = 20;

static NSString *const  movieSubDetailUrl = @"http://52.5.222.145:9000/flickwiz/persondetail";
static NSString *const  movietypeSubDetailUrl = @"http://52.5.222.145:9000/flickwiz/genredetail";

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
@end

@implementation MoviewDetailController
@synthesize selectedMovieName;
@synthesize selectedImage;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Details";
    index = 0;
    // Separate String by comma & create Array
    actornameExtractArray = [_selectedmovieMakers componentsSeparatedByString:@","];
    directrnameExtractArray = [_selectedmoviedirectorName componentsSeparatedByString:@","];
    writernameExtractArray1 = [_selectedmoviewriterName componentsSeparatedByString:@","];
    movietypenameExtractArray = [_selectedmovieType componentsSeparatedByString:@","];
    self.tableView.backgroundColor = [UIColor whiteColor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    switch (index) {
        case 0:
            return 23;
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
                cell.rankingLabel.text = _selectedmovieRaking;
                return  cell;
            }
            // For Lable Show
            if ((indexPath.section == 1) || (indexPath.section == 2) || (indexPath.section == 3) || (indexPath.section == 7) || (indexPath.section == 11) ||  (indexPath.section == 15) || (indexPath.section == 19) || (indexPath.section == 21)) {
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
                    cell.customLable.frame = CGRectMake(20, 0, 270, 30);
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
                    cell.customLable.text = @"Director Name";
                    [cell.customLable setFont:[UIFont boldSystemFontOfSize:17]];
                    return cell;
                }
                // Writer Names
                if (indexPath.section == 15) {
                    cell.customLable.text =@"Writer Name";
                    [cell.customLable setFont:[UIFont boldSystemFontOfSize:17]];
                    return cell;
                }
                // Description
                if (indexPath.section == 19) {
                    cell.customLable.text =@"Movie Description";
                    [cell.customLable setFont:[UIFont boldSystemFontOfSize:17]];
                    return cell;
                }
                // Share Options
                if (indexPath.section == 21) {
                    cell.customLable.text =@"Share Options";
                    [cell.customLable setFont:[UIFont boldSystemFontOfSize:17]];
                    return cell;
                }
                return cell;
            }
            if (indexPath.section == 20) {
                static NSString *CellIdentifier = @"TextViewCell";
                TextViewCell *cell = (TextViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
                cell = [[[NSBundle mainBundle] loadNibNamed:@"TextViewCell"owner:self options:nil] objectAtIndex:0];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.customTextView.text = _selectedmovieDescrption;
                return cell;
            }
            if (indexPath.section == 22) {
                ButtonCell *cell = [self facebookAndTwitterButtonFunction:tableView];
                [cell.faceBookButton addTarget:self action:@selector(facebookPostBtFunction) forControlEvents:UIControlEventTouchUpInside];
                [cell.twitterButton addTarget:self action:@selector(twitterPostButtonFunction) forControlEvents:UIControlEventTouchUpInside];
                return cell;
            }
            // Actor Names Buttons
            if (indexPath.section == 4) {
                CustomButtonCell *cell11 = [self customButtonFunction:tableView];
                cell11.customButton.tag = indexPath.row;
                NSString *actor1 = actornameExtractArray[0];
                [cell11.customButton setTitle:actor1 forState:UIControlStateNormal];
                
                return cell11;
            }
            if (indexPath.section == 5) {
                CustomButtonCell *cell2 = [self customButtonFunction:tableView];
                if ([actornameExtractArray count] <= 1) {
                    cell2.hidden = YES;
                    return cell2;
                }
                cell2.customButton.tag = indexPath.row +1;
                NSString *actor2 = actornameExtractArray[1];
                [cell2.customButton setTitle:actor2 forState:UIControlStateNormal];
                
                return cell2;
            }
            if (indexPath.section == 6) {
                CustomButtonCell *cell = [self customButtonFunction:tableView];
                if ([actornameExtractArray count] <= 2) {
                    cell.hidden = YES;
                    return cell;
                }
                cell.customButton.tag = indexPath.row +2;
                NSString *actor3 = actornameExtractArray[2];
                [cell.customButton setTitle:actor3 forState:UIControlStateNormal];
                self.tableView.separatorColor = [UIColor lightGrayColor];
                return cell;
            }
            // Movie Type Button + Actions
            if (indexPath.section == 8) {
                CustomButtonCell *cell = [self movieTpeButtonFunction:tableView];
                cell.customButton.tag = indexPath.row +3;
                NSString *movieType = movietypenameExtractArray[0];
                [cell.customButton setTitle:movieType forState:UIControlStateNormal];
                
                return cell;
            }
            if (indexPath.section == 9) {
                CustomButtonCell *cell = [self movieTpeButtonFunction:tableView];
                if ([movietypenameExtractArray count] <= 1){
                    cell.hidden = YES;
                    return cell;
                }
                cell.customButton.tag = indexPath.row +4;
                NSString *movieType = movietypenameExtractArray[1];
                [cell.customButton setTitle:movieType forState:UIControlStateNormal];
                
                return cell;
            }
            if (indexPath.section == 10) {
                CustomButtonCell *cell = [self movieTpeButtonFunction:tableView];
                if ([movietypenameExtractArray count] <= 2) {
                    cell.hidden = YES;
                    return cell;
                }
                cell.customButton.tag = indexPath.row +5;
                NSString *movieType = movietypenameExtractArray[2];
                [cell.customButton setTitle:movieType forState:UIControlStateNormal];
                return cell;
            }
            // Diractor Names Buttons + Actions
            if (indexPath.section == 12) {
                CustomButtonCell *cell = [self customButtonFunction:tableView];
                cell.customButton.tag = indexPath.row +6;
                NSString *movieDiractor = directrnameExtractArray[0];
                [cell.customButton setTitle:movieDiractor forState:UIControlStateNormal];
                
                return cell;
            }
            if (indexPath.section == 13) {
                CustomButtonCell *cell = [self customButtonFunction:tableView];
                if ([directrnameExtractArray count] <= 1) {
                    cell.hidden = YES;
                    return cell;
                }
                cell.customButton.tag = indexPath.row +7;
                NSString *movieDiractor = directrnameExtractArray[1];
                [cell.customButton setTitle:movieDiractor forState:UIControlStateNormal];
                return cell;
            }
            if (indexPath.section == 14) {
                CustomButtonCell *cell = [self customButtonFunction:tableView];
                if ([directrnameExtractArray count] <= 2) {
                    cell.hidden = YES;
                    return cell;
                }
                cell.customButton.tag = indexPath.row +8;
                NSString *movieDiractor = directrnameExtractArray[2];
                [cell.customButton setTitle:movieDiractor forState:UIControlStateNormal];
                return cell;
            }
            // Writer Names Button + Actions
            if (indexPath.section == 16) {
                CustomButtonCell *cell = [self customButtonFunction:tableView];
                cell.customButton.tag = indexPath.row +9;
                NSString *movieWriter = writernameExtractArray1[0];
                [cell.customButton setTitle:movieWriter forState:UIControlStateNormal];
                return cell;
            }
            if (indexPath.section == 17) {
                CustomButtonCell *cell = [self customButtonFunction:tableView];
                if ([writernameExtractArray1 count] <= 1) {
                    cell.hidden = YES;
                    return cell;
                }
                cell.customButton.tag = indexPath.row +10;
                NSString *movieWriter = writernameExtractArray1[1];
                [cell.customButton setTitle:movieWriter forState:UIControlStateNormal];
                return cell;
            }
            if (indexPath.section == 18) {
                CustomButtonCell *cell = [self customButtonFunction:tableView];
                if ([writernameExtractArray1 count] <= 2) {
                    cell.hidden = YES;
                    return cell;
                }
                cell.customButton.tag = indexPath.row +11;
                NSString *movieWriter = writernameExtractArray1[2];
                [cell.customButton setTitle:movieWriter forState:UIControlStateNormal];
                return cell;
            }
        }break;
        default:
            break;
    }
    return nil;
}


-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return cellSpacing;
}

- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section
{
    view.tintColor = [UIColor clearColor];
}



- (ButtonCell *)facebookAndTwitterButtonFunction:(UITableView *)tableView {
    static NSString *CellIdentifier = @"ButtonCell";
    ButtonCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"ButtonCell" owner:self options:nil] objectAtIndex:0];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}

- (CustomButtonCell *)customButtonFunction:(UITableView *)tableView {
    static NSString *CellIdentifier = @"CustomButtonCell";
    CustomButtonCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    cell = [[[NSBundle mainBundle] loadNibNamed:@"CustomButtonCell" owner:self options:nil] objectAtIndex:0];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell.customButton addTarget:self action:@selector(movieResponse:)forControlEvents:UIControlEventTouchUpInside];
    return cell;
}

- (CustomButtonCell *)movieTpeButtonFunction:(UITableView *)tableView {
    static NSString *CellIdentifier = @"CustomButtonCell";
    CustomButtonCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    cell = [[[NSBundle mainBundle] loadNibNamed:@"CustomButtonCell" owner:self options:nil] objectAtIndex:0];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell.customButton addTarget:self action:@selector(movietypeResponse:)forControlEvents:UIControlEventTouchUpInside];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 250;
    }
    if (indexPath.section == 20) {
        return 75;
    }
    if(indexPath.section == 22){
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
    if (indexPath.section == 13) {
        if ([directrnameExtractArray count] <= 1) {
            return 0;
        }
    }
    if (indexPath.section == 14) {
        if ([directrnameExtractArray count] <= 2) {
            return 0;
        }
    }
    // code for nill index for Writer
    if (indexPath.section == 17) {
        if ([writernameExtractArray1 count] <= 1) {
            return 0;
        }
    }
    if (indexPath.section == 18) {
        if ([writernameExtractArray1 count] <= 2) {
            return 0;
        }
    }
    return 40;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma Mark Share Twitter Button

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
        [self twitterAlertView];
    }
}

#pragma Mark Share FaceBook Button

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
        [self facebookAlertView];
    }
}

#pragma movietypeResponse
- (void)movietypeResponse:(UIButton *)sender {
    NSInteger abcd1 = sender.tag;;
    NSString *mymovienametype;
    // Movie Type Button Click
    if (abcd1 == 3){
        NSString *actor2 = movietypenameExtractArray[0];
        mymovienametype = actor2;
    }
    else if (abcd1 == 4){
        NSString *actor2 = movietypenameExtractArray[1];
        mymovienametype = actor2;
    }
    else if (abcd1 == 5){
        NSString *actor2 = movietypenameExtractArray[2];
        mymovienametype = actor2;
    }
    NSDictionary *parameters =  @{@"genre":mymovienametype};
    manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [SVProgressHUD show];
    [manager GET:movietypeSubDetailUrl parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSMutableDictionary *responsJsonDic = responseObject;
        NSMutableArray *listSearch = [responsJsonDic objectForKey:@"names"];
        if ([listSearch count] == 0) {
            [self alertView];
            [SVProgressHUD dismiss];
        }else {
            MovieTypeDetailController *jsonResponseDetails2 = [MovieTypeDetailController new];
            NSUserDefaults *jasonRes = [NSUserDefaults standardUserDefaults];
            [jasonRes setObject:responsJsonDic forKey:@"responsJsonDic"];
            [self.navigationController pushViewController:jsonResponseDetails2 animated:YES];
            [SVProgressHUD dismiss];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        [self alertView];
        [SVProgressHUD dismiss];
    }];
}

#pragma mark MovieMainResponse

-(void)movieResponse:(UIButton*)sender {
    NSInteger abcd = sender.tag;;
    NSString *myname;
    // For Actor Button Click
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
    NSDictionary *parameters =  @{@"personName":myname};
    manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [SVProgressHUD show];
    [manager GET:movieSubDetailUrl parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *jsonResponseDetails = responseObject;
        MoviesPersonsDetailView *moviesPersonDetails = [MoviesPersonsDetailView new];
        moviesPersonDetails.jsonResponsDic = jsonResponseDetails;
        [self.navigationController pushViewController:moviesPersonDetails animated:YES];
        [SVProgressHUD dismiss];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        [self alertView];
        [SVProgressHUD dismiss];
    }];
}



#pragma mark AlertView

- (void)alertView {
    [ASAlertView alertWithTitle:ApplicationTitle message:@"Data is not available..."];
}

- (void)facebookAlertView {
    
    [ASAlertView alertWithTitle:ApplicationTitle message:@"A FaceBook account must be set up on your device. login within your device setting FaceBook account.."];
    
}

- (void)twitterAlertView {
    
    [ASAlertView alertWithTitle:ApplicationTitle message:@"A Twitter account must be set up on your device. login within your device setting twitter account.."];
    
}
@end
