//
//  MovieTypeDetailController.m
//  FlickWiz
//
//  Created by mac on 1/18/16.
//  Copyright © 2016 Qazi. All rights reserved.
//

#import "MovieTypeDetailController.h"
#import "MovieCell.h"

@interface MovieTypeDetailController () {

    // NSStrings
    NSString *datePick;
    NSString *Datestring2;
    NSString *movieName;
    NSString *movieDescString;
    NSString *movietypestring;
    NSString *moviemakerString;
    NSString *movierakingString;
    NSString *moviedirectorString;
    NSString *moviewriterString;
    NSString *moviedetailpathString;
    
    //  Arrays
    NSArray *MoviewPosterNamesArray;
    NSArray *imagearray;
    NSArray *imagesUrlArray;
    NSArray *movienameArray;
    NSMutableArray *movierakingListArray;
    NSMutableArray *dateArray;
    NSMutableArray *moviedecripArray;
    NSMutableArray *moviedecListArray;
    NSMutableArray *moviedateArray;
    NSMutableArray *movietypeArray;
    NSMutableArray *movietypeListArray;
    NSMutableArray *moviemakerArray;
    NSMutableArray *moviedirctorArray;
    NSMutableArray *moviewriterArray;
    NSMutableArray *moviedetailpathArray;
    NSMutableArray *moviemakerListArray;
    NSMutableArray *movierakingArray;
    NSMutableArray *moviedirectorListArray;
    NSMutableArray *moviewriterListArray;
    NSMutableArray *moviedetailpathListArray;
    
    NSDictionary *myresult;
    
    UIImage *imagesData;
    UIImage *myImage;
    NSData *imageDate;
}

@end

@implementation MovieTypeDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Array init
    moviedateArray = [NSMutableArray array];
    movietypeListArray = [NSMutableArray array];
    moviedecListArray = [NSMutableArray array];
    moviemakerListArray = [NSMutableArray array];
    movierakingListArray = [NSMutableArray array];
    moviewriterListArray = [NSMutableArray array];
    moviedirectorListArray = [NSMutableArray array];
    moviedetailpathListArray = [NSMutableArray array];
    
    // json result
    
    
    
    
    NSUserDefaults *jasonRes = [NSUserDefaults standardUserDefaults];

    myresult = [jasonRes objectForKey:@"jsonResponseDetails2"];
    
    self.title = @"Movie Type Detail";
    // image's name & url
    

    
    
    imagesUrlArray = [myresult objectForKey:@"names"];

    //movienameArray = [imagesUrlArray objectForKey:@"value"];
    
    
    // IMDBDETAIL ARRAY
    //MoviewPosterNamesArray = [myresult objectForKey:@"imdbdetials"];
    
    // use for loop here Movie Detail path Count
    for (NSInteger i=0; i<[MoviewPosterNamesArray count]; i++) {
        moviedetailpathArray = [MoviewPosterNamesArray objectAtIndex:i];
        moviedetailpathString = [moviedetailpathArray objectAtIndex:0];
        [moviedetailpathListArray addObject:moviedetailpathString];
    }
    
    // use for loop here Movie Date Count
    for (NSInteger i=0; i<[MoviewPosterNamesArray count]; i++) {
        dateArray = [MoviewPosterNamesArray objectAtIndex:i];
        Datestring2 = [dateArray objectAtIndex:3];
        [moviedateArray addObject:Datestring2];
    }
    
    // movie Type loop
    for (NSInteger i=0; i<[MoviewPosterNamesArray count]; i++) {
        movietypeArray = [MoviewPosterNamesArray objectAtIndex:i];
        movietypestring = [movietypeArray objectAtIndex:5];
        [movietypeListArray addObject:movietypestring];
    }
    
    /// movie director name
    for (NSInteger i=0; i<[MoviewPosterNamesArray count]; i++) {
        moviedirctorArray = [MoviewPosterNamesArray objectAtIndex:i];
        moviedirectorString = [moviedirctorArray objectAtIndex:6];
        [moviedirectorListArray addObject:moviedirectorString];
        
    }
    
    /// movie writers name
    for (NSInteger i=0; i<[MoviewPosterNamesArray count]; i++) {
        moviewriterArray = [MoviewPosterNamesArray objectAtIndex:i];
        moviewriterString = [moviewriterArray objectAtIndex:7];
        [moviewriterListArray addObject:moviewriterString];
        
    }
    
    // movie Maker's loop
    for (NSInteger i=0; i<[MoviewPosterNamesArray count]; i++) {
        moviemakerArray = [MoviewPosterNamesArray objectAtIndex:i];
        moviemakerString = [moviemakerArray objectAtIndex:8];
        [moviemakerListArray addObject:moviemakerString];
        
    }
    
    // movie Description loop
    for (NSInteger i=0; i<[MoviewPosterNamesArray count]; i++) {
        moviedecripArray = [MoviewPosterNamesArray objectAtIndex:i];
        movieDescString = [moviedecripArray objectAtIndex:9];
        [moviedecListArray addObject:movieDescString];
    }
    
    // movie raking loop
    for (NSInteger i=0; i<[MoviewPosterNamesArray count]; i++) {
        movierakingArray = [MoviewPosterNamesArray objectAtIndex:i];
        movierakingString = [movierakingArray objectAtIndex:10];
        [movierakingListArray addObject:movierakingString];
    }

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
    if (cell == nil) {
        NSArray *nibArray = [[NSBundle mainBundle] loadNibNamed:@"MovieCell" owner:self options:nil];
        cell = [nibArray objectAtIndex:0];
    }
    imagesData =[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[imagesUrlArray objectAtIndex:indexPath.row]]]];
    [cell.movieImages setImage:imagesData];
    cell.movienameLabel.text = [movienameArray objectAtIndex:indexPath.row];
    cell.movieDateLabel.text = [moviedateArray objectAtIndex:indexPath.row];
    cell.movieImages.layer.backgroundColor=[[UIColor clearColor] CGColor];
    //    cell.movieImages.layer.cornerRadius=20;
    //    cell.movieImages.layer.borderWidth=2.0;
    cell.movieImages.layer.masksToBounds = YES;
    cell.movieImages.layer.borderColor=[[UIColor grayColor] CGColor];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 91;
}

#pragma mark - Table view delegate

// In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
 
    //[self.navigationController pushViewController:moviedetailView animated:YES];
}


@end
