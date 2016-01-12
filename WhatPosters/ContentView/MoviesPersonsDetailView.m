//
//  MoviesPersonsDetailView.m
//  FlickWiz
//
//  Created by mac on 1/12/16.
//  Copyright © 2016 Qazi. All rights reserved.
//

#import "MoviesPersonsDetailView.h"
#import "AFNetworking.h"
#import "PhotoCell.h"
#import "LableCell.h"
#import "TextViewCell.h"

@interface MoviesPersonsDetailView () {

    NSInteger index;
    
    AFHTTPRequestOperationManager *manager;
    
    NSDictionary *myJsonResult;

    NSArray *personNameDetailArray;
    
    UIImage *imageData;

}

@end

@implementation MoviesPersonsDetailView
@synthesize jsonResponsDic;


- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;

    myJsonResult = jsonResponsDic;
    
    personNameDetailArray = [myJsonResult objectForKey:@"names"];

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
        case 0: {
            if (indexPath.section == 0) {
                static NSString *CellIdentifier = @"PhotoCell";
                PhotoCell *cell = (PhotoCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
                cell = [[[NSBundle mainBundle] loadNibNamed:@"PhotoCell" owner:self options:nil] objectAtIndex:0];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                
              NSString *imageUrlString = personNameDetailArray[2];
                
                imageData =[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:imageUrlString]]];
                
                if ([imageData isEqual:@"no image available"] || imageData == nil) {

                    cell.imageViewCell.image = [UIImage imageNamed:@"No_Image_Available.png"];
                }
                else {
                [cell.imageViewCell setImage:imageData];

                }
                
             //   cell.imageViewCell.image = imageData;
                return  cell;
            }
            
            
            // For Lable Show
            if ((indexPath.section == 1) || (indexPath.section == 2) || (indexPath.section == 3) || (indexPath.section == 4) || (indexPath.section == 5) || (indexPath.section == 6) || (indexPath.section == 7)) {
                
                static NSString *CellIdentifier = @"LableCell";
                LableCell *cell = (LableCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
                cell = [[[NSBundle mainBundle] loadNibNamed:@"LableCell" owner:self options:nil] objectAtIndex:0];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                
                // Movie Person Name + details
                if (indexPath.section == 1) {
                    cell.customLable.text = @"Name";
                    [cell.customLable setFont:[UIFont boldSystemFontOfSize:17]];
                    return cell;
                }
                if (indexPath.section == 2) {
                   NSString *nameString = personNameDetailArray[1];

                    cell.customLable.text = nameString;
                    cell.customLable.frame = CGRectMake(30, 0, 270, 30);
                    return cell;
                }
                
                if (indexPath.section == 3) {
                    cell.customLable.text =@"Date Of Birth";
                    [cell.customLable setFont:[UIFont boldSystemFontOfSize:17]];
                    return cell;
                }
                
                if (indexPath.section == 4) {
                   NSString *dateOfBirthString = personNameDetailArray[8];
                    
                    cell.customLable.text = dateOfBirthString;
                    cell.customLable.frame = CGRectMake(30, 0, 270, 30);
                    return cell;
                }
                
                if (indexPath.section == 5) {
                    cell.customLable.text =@"Place Of Birth";
                    [cell.customLable setFont:[UIFont boldSystemFontOfSize:17]];
                    return cell;
                }
                
                if (indexPath.section == 6) {
                    NSString *placeOfBirthString = personNameDetailArray[10];
                    
                    cell.customLable.text = placeOfBirthString;
                    cell.customLable.frame = CGRectMake(30, 0, 270, 30);
                    return cell;
                }
                
                // Description
                if (indexPath.section == 7) {
                    cell.customLable.text =@"Description";
                    [cell.customLable setFont:[UIFont boldSystemFontOfSize:17]];
                    return cell;
                }
                return cell;
            }
                if (indexPath.section == 8) {
                static NSString *CellIdentifier = @"TextViewCell";
                TextViewCell *cell = (TextViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
                cell = [[[NSBundle mainBundle] loadNibNamed:@"TextViewCell"owner:self options:nil] objectAtIndex:0];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                //   cell.customTextView.delegate = self;
                
               NSString *descriptionString = personNameDetailArray[3];
                cell.customTextView.text = descriptionString;
                return cell;
            }
            
        }break;
        default:
            break;
    }
    return nil;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 250;
    }
    if (indexPath.section == 8) {
        return 75;
    }
    /*
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
    }*/
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



@end
