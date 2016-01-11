//
//  MoviewDetailController.m
//  FlickWiz
//
//  Created by mac on 12/30/15.
//  Copyright © 2015 Qazi. All rights reserved.
//

#import <UIKit/UIKit.h>
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

#import <Social/Social.h>


@interface MoviewDetailController () <UINavigationControllerDelegate, UITextViewDelegate,UIAlertViewDelegate> {
    
    // from old movie detail class
    /*
     IBOutlet UILabel *WriterNames;
     IBOutlet UILabel *dirctorName;
     IBOutlet UIImageView *movieImageView;
     IBOutlet UITextView *moviedecrptiontextView;
     IBOutlet UILabel *movieType;
     IBOutlet UILabel *movieNamerelsingDate;
     IBOutlet UILabel *moviedirectorNameLabel;
     IBOutlet UILabel *movieWriterName;
     */
    NSInteger index;
    NSInteger item;
    NSInteger convertselectItem;
    NSString *actorNameString;
    NSString *typeNameString;
    NSString *diractorNameString;
    NSString *writerNameString;
    
    // new code for array separation
    NSArray *actornameExtractArray;
    NSArray *directrnameExtractArray;
    NSArray *writernameExtractArray1;
    NSArray * movietypenameExtractArray;
    NSMutableArray *cominedArray;
    
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
            return 9;
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
        case 0:
        {
            if (indexPath.section == 0) {
                static NSString *CellIdentifier = @"PhotoCell";
                PhotoCell *cell = (PhotoCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
                cell = [[[NSBundle mainBundle] loadNibNamed:@"PhotoCell" owner:self options:nil] objectAtIndex:0];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.imageViewCell.image = selectedImage;
                return  cell;
            }
            if ((indexPath.section == 1) || (indexPath.section == 4)) {
                
                static NSString *CellIdentifier = @"LableCell";
                LableCell *cell = (LableCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
                if (cell == nil) {
                    cell = [[[NSBundle mainBundle] loadNibNamed:@"LableCell" owner:self options:nil] objectAtIndex:0];
                    cell.selectionStyle = UITableViewCellSelectionStyleNone;
                }
                if (indexPath.section == 1) {
                    cell.customLable.text = selectedMovieName;
                }
                if (indexPath.section == 4) {
                    cell.customLable.backgroundColor = [UIColor clearColor];
                    cell.customLable.text = _selectedmovieRaking;
                }
                return cell;
            }
            if (indexPath.section == 2) {
                PickLabelCell *cell = [self pickerLabelCellWithTableView:self.tableView];
                cell.textLabel.text = actorNameString;
                return cell;
            }
            if (indexPath.section == 3) {
                PickLabelCell *cell = [self pickerLabelCellWithTableView:self.tableView];
                cell.textLabel.text = typeNameString;
                return cell;
            }
            if (indexPath.section == 5) {
                PickLabelCell *cell = [self pickerLabelCellWithTableView:self.tableView];
                cell.textLabel.text = diractorNameString;
                return cell;
            }
            if (indexPath.section == 6) {
                PickLabelCell *cell = [self pickerLabelCellWithTableView:self.tableView];
                cell.textLabel.text = writerNameString;
                return cell;
            }
            
            if (indexPath.section == 7) {
                static NSString *CellIdentifier = @"TextViewCell";
                TextViewCell *cell = (TextViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
                if (cell == nil) {
                    cell = [[[NSBundle mainBundle] loadNibNamed:@"TextViewCell"owner:self options:nil] objectAtIndex:0];
                    cell.selectionStyle = UITableViewCellSelectionStyleNone;
                    //   cell.customTextView.delegate = self;
                }
                cell.customTextView.text = _selectedmovieDescrption;
                return cell;
            }
            if (indexPath.section == 8) {
                
                static NSString *CellButtonIdn = @"ButtonCell";
                ButtonCell *cell = (ButtonCell *)[tableView dequeueReusableCellWithIdentifier:CellButtonIdn];
                cell = [[[NSBundle mainBundle] loadNibNamed:@"ButtonCell"owner:self options:nil] objectAtIndex:0];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                [cell.faceBookButton addTarget:self action:@selector(facebookPostBtFunction) forControlEvents:UIControlEventTouchUpInside];
                [cell.twitterButton addTarget:self action:@selector(twitterPostButtonFunction) forControlEvents:UIControlEventTouchUpInside];
                return cell;
            }}
            break;
            
        default:
            break;
    }
    
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        return 180;
    }
    
    if (indexPath.section == 7) {
        return 75;
    }
    if(indexPath.section == 8){
        return 50;
    }
    return 40;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    switch (index) {
        case 0:
        {
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
            }}
            break;
            
        default:
            break;
    }
    
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    NSString *result = nil;
    
    switch (index) {
        case 0:
        {
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

#pragma  mark - All Cell Functions

- (PickLabelCell *)pickerLabelCellWithTableView:(UITableView *)tableView {
    static NSString *cellIdentifier = @"PickLabelCell";
    PickLabelCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if(cell == nil) {
        cell = [[PickLabelCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    return cell;
}

- (void)showActorNameFunction {
    NSInteger selectedIndex = [actornameExtractArray indexOfObject:actorNameString];
    if (selectedIndex > 30) {
        selectedIndex = 0;
    }
    [ActionSheetStringPicker showPickerWithTitle:@"Actor Name Selection"
                                            rows:actornameExtractArray
                                initialSelection:selectedIndex
     
                                       doneBlock:^(ActionSheetStringPicker *picker, NSInteger selectedIndex, id selectedValue) {
                                           NSLog(@"Picker: %@, Index: %ld, value: %@",
                                                 picker, (long)selectedIndex, selectedValue);
                                           actorNameString = selectedValue;
                                           [self.tableView reloadData];
                                           
                                           [self actorreloadIndex:selectedValue];
                                       }
                                     cancelBlock:^(ActionSheetStringPicker *picker) {
                                         NSLog(@"Block Picker Canceled");
                                     }
                                          origin:self.view];
}

- (void)typeNameFunction {
    NSInteger selectedIndex = [movietypenameExtractArray indexOfObject:typeNameString];
    if (selectedIndex > 30) {
        selectedIndex = 0;
    }
    [ActionSheetStringPicker showPickerWithTitle:@"Movie Type Selection"
                                            rows:movietypenameExtractArray
                                initialSelection:selectedIndex
     
                                       doneBlock:^(ActionSheetStringPicker *picker, NSInteger selectedIndex, id selectedValue) {
                                           NSLog(@"Picker: %@, Index: %ld, value: %@",
                                                 picker, (long)selectedIndex, selectedValue);
                                           typeNameString = selectedValue;
                                           [self.tableView reloadData];
                                           [self movietypereloadIndex:selectedValue];
                                       }
                                     cancelBlock:^(ActionSheetStringPicker *picker) {
                                         NSLog(@"Block Picker Canceled");
                                     }
                                          origin:self.view];
}

- (void)directorNameFunction {
    NSInteger selectedIndex = [directrnameExtractArray indexOfObject:diractorNameString];
    if (selectedIndex > 30) {
        selectedIndex = 0;
    }
    [ActionSheetStringPicker showPickerWithTitle:@"Director Name Selection"
                                            rows:directrnameExtractArray
                                initialSelection:selectedIndex
     
                                       doneBlock:^(ActionSheetStringPicker *picker, NSInteger selectedIndex, id selectedValue) {
                                           NSLog(@"Picker: %@, Index: %ld, value: %@",
                                                 picker, (long)selectedIndex, selectedValue);
                                           diractorNameString = selectedValue;
                                           [self.tableView reloadData];
                                           [self dirctorreloadIndex:selectedValue];
                                       }
                                     cancelBlock:^(ActionSheetStringPicker *picker) {
                                         NSLog(@"Block Picker Canceled");
                                     }
                                          origin:self.view];
}

- (void)writerNameFunction {
    NSInteger selectedIndex = [writernameExtractArray1 indexOfObject:writerNameString];
    if (selectedIndex > 30) {
        selectedIndex = 0;
    }
    [ActionSheetStringPicker showPickerWithTitle:@"Writer Name Selection"
                                            rows:writernameExtractArray1
                                initialSelection:selectedIndex
                                       doneBlock:^(ActionSheetStringPicker *picker, NSInteger selectedIndex, id selectedValue) {
                                           NSLog(@"Picker: %@, Index: %ld, value: %@",
                                                 picker, (long)selectedIndex, selectedValue);
                                           writerNameString = selectedValue;
                                           [self.tableView reloadData];
                                           [self writerreloadIndex:selectedValue];
                                       }
                                     cancelBlock:^(ActionSheetStringPicker *picker) {
                                         NSLog(@"Block Picker Canceled");
                                         
                                     }
                                          origin:self.view];
}

#pragma Mark Reload index Function

- (void)actorreloadIndex:(NSString *)Actorvalue {
    convertselectItem = 1;
    NSArray *items = actornameExtractArray;
    item = [items indexOfObject:Actorvalue];
    item = convertselectItem;
    index = item;
    [self.tableView reloadData];
}

- (void)movietypereloadIndex:(NSString *)movieTypevalue {
    convertselectItem = 2;
    NSArray *items = movietypenameExtractArray;
    item = [items indexOfObject:movieTypevalue];
    item = convertselectItem;
    index = item;
    
    [self.tableView reloadData];
}

- (void)dirctorreloadIndex:(NSString *)Directorvalue {
    convertselectItem = 3;
    NSArray *items = directrnameExtractArray;
    item = [items indexOfObject:Directorvalue];
    index = item;
    
    [self.tableView reloadData];
}

- (void)writerreloadIndex:(NSString *)Writervalue {
    convertselectItem = 4;
    NSArray *items = writernameExtractArray1;
    item = [items indexOfObject:Writervalue];
    index = item;
    
    [self.tableView reloadData];
}



-(void)twitterPostButtonFunction{
    
    if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter])
    {
        SLComposeViewController *tweetSheet = [SLComposeViewController
                                               composeViewControllerForServiceType:SLServiceTypeTwitter];
        [tweetSheet setInitialText:selectedMovieName];
        
        [tweetSheet addURL:[NSURL URLWithString:_selectedmoviedetailpathString]];
        
        [tweetSheet addImage:selectedImage];
        [self presentViewController:tweetSheet animated:YES completion:nil];
    }
    else
    {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Twitter" message:@"A Twitter account must be set up on your device. login within your device setting twitter account.." preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction* ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
        [alertController addAction:ok];
        [self presentViewController:alertController animated:YES completion:nil];
    }
}


//-(void)facebookPostBtFunction:(UIButton*)sender{

-(void)facebookPostBtFunction{
    
    if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeFacebook])
    {
        SLComposeViewController *fbookSheet = [SLComposeViewController
                                               composeViewControllerForServiceType:SLServiceTypeFacebook];
        [fbookSheet setInitialText:selectedMovieName];
        
        [fbookSheet addImage:selectedImage];
        [fbookSheet addURL:[NSURL URLWithString:_selectedmoviedetailpathString]];
        
        [self presentViewController:fbookSheet animated:YES completion:nil];
    }
    else
    {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"FaceBook" message:@"A FaceBook account must be set up on your device. login within your device setting FaceBook account.." preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction* ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
        [alertController addAction:ok];
        [self presentViewController:alertController animated:YES completion:nil];
    }
}



@end
