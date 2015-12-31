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
    
    NSMutableArray *actorName;
    NSMutableArray *typeArray;
    NSMutableArray *directorArray;
    NSMutableArray *writerArray;
    
    NSString *actorNameString;
    NSString *typeNameString;
    NSString *diractorNameString;
    NSString *writerNameString;

}
@property (nonatomic, strong) AbstractActionSheetPicker *actionSheetPicker;

@end

@implementation MoviewDetailController
@synthesize selectedMovieName;
@synthesize selectedImage;

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"Movie Details";
   
    /// Picker Array's
    actorName =[NSMutableArray arrayWithObjects:@"Salman Khan",@"Aamir Khan",@"Shahid Kapoor",@"SRK",@"Wordcloud", nil];
    typeArray =[NSMutableArray arrayWithObjects:@"Action",@"Commedy", nil];
    directorArray =[NSMutableArray arrayWithObjects:@"Rohit Shitty",@"Karan Johar", nil];
    writerArray =[NSMutableArray arrayWithObjects:@"Ismail Shah",@"Saleem Khan",@"Akash Mannia",@"Rana Arani", nil];
    
    // from old movie detail class code
    //  moviedirectorNameLabel.text = _selectedmoviedirectorName;
    
    // self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageWithContentsOfFile:[[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"ImageUploadedByModMyi1342057019.344337.jpg"]]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 9;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  
    if (indexPath.section == 0) {
        
        static NSString *CellIdentifier = @"PhotoCell";
        PhotoCell *cell = (PhotoCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
            cell = [[[NSBundle mainBundle] loadNibNamed:@"PhotoCell" owner:self options:nil] objectAtIndex:0];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
       // cell.imageViewCell.image = [UIImage imageNamed:@""];
       
      // new code
      //  cell.imageViewCell.layer.cornerRadius = cell.imageViewCell.frame.size.width / 2;
       // cell.imageViewCell.clipsToBounds = YES;
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
          //  cell.customLable.text = @"Name";
            cell.customLable.text = selectedMovieName;

        }
        if (indexPath.section == 4) {
//            cell.customLable.text = @"Ranking";

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
        cell.textLabel.text = _selectedmovieType;
        return cell;
    }
    if (indexPath.section == 5) {
        PickLabelCell *cell = [self pickerLabelCellWithTableView:self.tableView];
     //   cell.textLabel.text = diractorNameString;

        cell.textLabel.text = _selectedmovieMakers;

        
//        dirctorName.text = _selectedmovieMakers;

        return cell;
    }
    if (indexPath.section == 6) {
        PickLabelCell *cell = [self pickerLabelCellWithTableView:self.tableView];
        cell.textLabel.text = writerNameString;
        cell.backgroundColor = [UIColor clearColor];


//        movieWriterName.text = _selectedmoviewriterName;

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
    //    cell.customTextView.text = @"coming description text from server";
      
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
        
        
        //cell.restBtn.frame = CGRectMake(20, 5, 280, 25);
        //[cell.restBtn setTitle:@"Login" forState:UIControlStateNormal];
        return cell;
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
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    NSString *result = nil;
   
            switch (section) {
                case 1:
                    result = @"Name of Movie";
                    break;
                case 2:
                    result = @"Actor Name";
                    break;
                case 3:
                    result = @"Type";
                    break;
                case 4:
                    result = @"Ranking";
                    break;
                case 5:
                    result = @"Diractor";
                    break;
                case 6:
                    result = @"Writer";
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
    NSInteger selectedIndex = [actorName indexOfObject:actorNameString];
    if (selectedIndex > 30) {
        selectedIndex = 0;
    }
    [ActionSheetStringPicker showPickerWithTitle:@"Site Selection"
                                            rows:actorName
                                initialSelection:selectedIndex
     
                                       doneBlock:^(ActionSheetStringPicker *picker, NSInteger selectedIndex, id selectedValue) {
                                           NSLog(@"Picker: %@, Index: %ld, value: %@",
                                                 picker, (long)selectedIndex, selectedValue);
                                           actorNameString = selectedValue;
                                            [self.tableView reloadData];
                                          
                                           //[self reloadIndex:selectedValue];
                                       }
                                     cancelBlock:^(ActionSheetStringPicker *picker) {
                                         NSLog(@"Block Picker Canceled");
                                     }
                                          origin:self.view];
}

- (void)typeNameFunction {
    NSInteger selectedIndex = [typeArray indexOfObject:typeNameString];
    if (selectedIndex > 30) {
        selectedIndex = 0;
    }
    [ActionSheetStringPicker showPickerWithTitle:@"Site Selection"
                                            rows:typeArray
                                initialSelection:selectedIndex
     
                                       doneBlock:^(ActionSheetStringPicker *picker, NSInteger selectedIndex, id selectedValue) {
                                           NSLog(@"Picker: %@, Index: %ld, value: %@",
                                                 picker, (long)selectedIndex, selectedValue);
                                           typeNameString = selectedValue;
                                            [self.tableView reloadData];
                                       //    [self reloadIndex:selectedValue];
                                       }
                                     cancelBlock:^(ActionSheetStringPicker *picker) {
                                         NSLog(@"Block Picker Canceled");
                                     }
                                          origin:self.view];
}

- (void)directorNameFunction {
    NSInteger selectedIndex = [directorArray indexOfObject:diractorNameString];
    if (selectedIndex > 30) {
        selectedIndex = 0;
    }
    [ActionSheetStringPicker showPickerWithTitle:@"Site Selection"
                                            rows:directorArray
                                initialSelection:selectedIndex
     
                                       doneBlock:^(ActionSheetStringPicker *picker, NSInteger selectedIndex, id selectedValue) {
                                           NSLog(@"Picker: %@, Index: %ld, value: %@",
                                                 picker, (long)selectedIndex, selectedValue);
                                           diractorNameString = selectedValue;
                                           [self.tableView reloadData];
                                           // [self reloadIndex:selectedValue];
                                       }
                                     cancelBlock:^(ActionSheetStringPicker *picker) {
                                         NSLog(@"Block Picker Canceled");
                                     }
                                          origin:self.view];
}

- (void)writerNameFunction {
    NSInteger selectedIndex = [writerArray indexOfObject:writerNameString];
    if (selectedIndex > 30) {
        selectedIndex = 0;
    }
    [ActionSheetStringPicker showPickerWithTitle:@"Site Selection"
                                            rows:writerArray
                                initialSelection:selectedIndex
                                       doneBlock:^(ActionSheetStringPicker *picker, NSInteger selectedIndex, id selectedValue) {
                                           NSLog(@"Picker: %@, Index: %ld, value: %@",
                                                 picker, (long)selectedIndex, selectedValue);
                                           writerNameString = selectedValue;
                                           [self.tableView reloadData];
                                          // [self reloadIndex:selectedValue];
                                       }
                                     cancelBlock:^(ActionSheetStringPicker *picker) {
                                         NSLog(@"Block Picker Canceled");
                                         
                                     }
                                          origin:self.view];
}

-(void)twitterPostButtonFunction{

    if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter])
    {
        SLComposeViewController *tweetSheet = [SLComposeViewController
                                               composeViewControllerForServiceType:SLServiceTypeTwitter];
        [tweetSheet setInitialText:selectedMovieName];
       
        [tweetSheet addURL:[NSURL URLWithString:@"https://en.wikipedia.org/wiki/Iron_Man_2"]];
        
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
        [fbookSheet addURL:[NSURL URLWithString:@"https://en.wikipedia.org/wiki/Iron_Man_2"]];
        
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
