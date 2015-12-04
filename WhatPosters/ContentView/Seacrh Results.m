//
//  Seacrh Results.m
//  WhatPosters
//
//  Created by Qazi on 27/11/2015.
//  Copyright © 2015 Qazi. All rights reserved.
//

#import "Seacrh Results.h"
#import "MovieCell.h"
#import "MovieDetailsView.h"
#import "Venue.h"
#import "Utility.h"
#import "SVProgressHUD.h"

@interface Seacrh_Results (){

    NSArray *MoviePosterImagesArray;
    NSArray *MoviewPosterNamesArray;
    NSArray *MoviePosterDescrption;
    NSArray *imagearray;
    NSData *imageDate;
    NSArray *imagesUrlArray;
    NSArray *movienameArray;
    UIImage *imagesData;

}
@end

@implementation Seacrh_Results

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"Best Matches";
    
     NSUserDefaults *movieimagesDef = [NSUserDefaults standardUserDefaults];
     imagesUrlArray = [movieimagesDef objectForKey:@"moviearrya"];
     movienameArray = [movieimagesDef objectForKey:@"movieNamesArry"];

    // Table View Array
    //imagesUrlArray = [[Utility sharedManager] getVenueArray];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [imagesUrlArray count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *simpleTableIdentifier = @"Cell";
    MovieCell *cell = (MovieCell *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    if (cell == nil)
    {
        NSArray *nibArray = [[NSBundle mainBundle] loadNibNamed:@"MovieCell" owner:self options:nil];
        cell = [nibArray objectAtIndex:0];
        
    }
    imagesData =[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[imagesUrlArray objectAtIndex:indexPath.row]]]];
    [cell.movieImages setImage:imagesData];
    cell.movienameLabel.text = [movienameArray objectAtIndex:indexPath.row];
    cell.movieImages.layer.backgroundColor=[[UIColor clearColor] CGColor];
    cell.movieImages.layer.cornerRadius=20;
    cell.movieImages.layer.borderWidth=2.0;
    cell.movieImages.layer.masksToBounds = YES;
    cell.movieImages.layer.borderColor=[[UIColor grayColor] CGColor];
    [SVProgressHUD showSuccessWithStatus:@"Downloading Complete...."];
    return cell;

}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath

{
    return 81 ;
}
/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/


// Override to support editing the table view.
//- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
//    if (indexPath.row == 0) {
//        
//        MovieDetailsView *moviedetailView = [MovieDetailsView new];
//        [self.navigationController pushViewController:moviedetailView animated:YES];
//        
//    }
//   
//}


/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark - Table view delegate

// In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    MovieDetailsView *moviedetailView = [MovieDetailsView new];
     [self.navigationController pushViewController:moviedetailView animated:YES];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
