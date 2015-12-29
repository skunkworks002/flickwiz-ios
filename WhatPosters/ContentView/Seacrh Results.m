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
//#import "SVProgressHUD.h"
#import "WeatherHTTPClient.h"

// new code for app

@interface Seacrh_Results () <WeatherHTTPClientDelegate>{
    // NSString
    NSString *datePick;
    NSString *Datestring2;
    NSString *movieName;
    NSString *movieDescString;
    NSString *movietypestring;
    NSString *moviemakerString;
    NSString *movierakingString;
    NSString *moviedirectorString;
    NSString *moviewriterString;

    //  Arrays
    NSArray *MoviewPosterNamesArray;
    NSArray *imagearray;
    NSArray *imagesUrlArray;
    NSArray *movienameArray;
    NSMutableArray *movierakingListArray;
    NSMutableArray *dateStringArray;
    NSMutableArray *moviedecripArray;
    NSMutableArray *moviedecListArray;
    NSMutableArray *moviedateArray;
    NSMutableArray *movietypeArray;
    NSMutableArray *movietypeListArray;
    NSMutableArray *moviemakerArray;
    NSMutableArray *moviedirctorArray;
    NSMutableArray *moviewriterArray;

    NSMutableArray *moviemakerListArray;
    NSMutableArray *movierakingArray;
    NSMutableArray *moviedirectorListArray;
    NSMutableArray *moviewriterListArray;


    NSMutableDictionary *myresult;

    UIImage *imagesData;
    UIImage *myImage;
    NSData *imageDate;
}
@end

@implementation Seacrh_Results
@synthesize jsonResponsDic;

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
    
    // json result
    myresult = jsonResponsDic;
    
    self.title = @"Best Matches";
    // image's name & url
     imagesUrlArray = [myresult objectForKey:@"urls"];
     movienameArray = [myresult objectForKey:@"names"];

    // IMDBDETAIL ARRAY
    MoviewPosterNamesArray = [myresult objectForKey:@"imdbdetials"];
    
    // use for loop here Movie Date Count
    for (NSInteger i=0; i<[MoviewPosterNamesArray count]; i++) {
        dateStringArray = [MoviewPosterNamesArray objectAtIndex:i];
        Datestring2 = [dateStringArray objectAtIndex:2];
        [moviedateArray addObject:Datestring2];
    }
    
    ///movie Type loop
    for (NSInteger i=0; i<[MoviewPosterNamesArray count]; i++) {
        movietypeArray = [MoviewPosterNamesArray objectAtIndex:i];
        movietypestring = [movietypeArray objectAtIndex:4];
        [movietypeListArray addObject:movietypestring];
    }
    
    /// movie director name
    for (NSInteger i=0; i<[MoviewPosterNamesArray count]; i++) {
        moviedirctorArray = [MoviewPosterNamesArray objectAtIndex:i];
        moviedirectorString = [moviedirctorArray objectAtIndex:5];
        [moviedirectorListArray addObject:moviedirectorString];
        
    }
    
    /// movie writers name
    for (NSInteger i=0; i<[MoviewPosterNamesArray count]; i++) {
        moviewriterArray = [MoviewPosterNamesArray objectAtIndex:i];
        moviewriterString = [moviewriterArray objectAtIndex:6];
        [moviewriterListArray addObject:moviewriterString];
        
    }
    
    // movie Maker's loop
    for (NSInteger i=0; i<[MoviewPosterNamesArray count]; i++) {
        moviemakerArray = [MoviewPosterNamesArray objectAtIndex:i];
        moviemakerString = [moviemakerArray objectAtIndex:7];
        [moviemakerListArray addObject:moviemakerString];
        
    }

    // movie Description loop
    for (NSInteger i=0; i<[MoviewPosterNamesArray count]; i++) {
        moviedecripArray = [MoviewPosterNamesArray objectAtIndex:i];
        movieDescString = [moviedecripArray objectAtIndex:8];
        [moviedecListArray addObject:movieDescString];
    }
    
     // movie raking loop
    for (NSInteger i=0; i<[MoviewPosterNamesArray count]; i++) {
        movierakingArray = [MoviewPosterNamesArray objectAtIndex:i];
        movierakingString = [movierakingArray objectAtIndex:9];
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
    if (cell == nil)
    {
        NSArray *nibArray = [[NSBundle mainBundle] loadNibNamed:@"MovieCell" owner:self options:nil];
        cell = [nibArray objectAtIndex:0];
    }
    imagesData =[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[imagesUrlArray objectAtIndex:indexPath.row]]]];
    [cell.movieImages setImage:imagesData];
    cell.movienameLabel.text = [movienameArray objectAtIndex:indexPath.row];
    cell.movieDateLabel.text = [moviedateArray objectAtIndex:indexPath.row];
    cell.movieImages.layer.backgroundColor=[[UIColor clearColor] CGColor];
    cell.movieImages.layer.cornerRadius=20;
    cell.movieImages.layer.borderWidth=2.0;
    cell.movieImages.layer.masksToBounds = YES;
    cell.movieImages.layer.borderColor=[[UIColor grayColor] CGColor];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 81;
}

#pragma mark - Table view delegate

// In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    MovieDetailsView *moviedetailView = [MovieDetailsView new];
    // first access the cell
    static NSString *simpleTableIdentifier = @"Cell";
    MovieCell *cell = (MovieCell *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    if (cell == nil)
    {
        NSArray *nibArray = [[NSBundle mainBundle] loadNibNamed:@"MovieCell" owner:self options:nil];
        cell = [nibArray objectAtIndex:0];
    }
    imagesData =[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[imagesUrlArray objectAtIndex:indexPath.row]]]];
    [cell.movieImages setImage:imagesData];
    myImage = cell.movieImages.image;
    moviedetailView.selectedImage = myImage;
    cell.movienameLabel.text = [movienameArray objectAtIndex:indexPath.row];
    movieName = cell.movienameLabel.text;
    moviedetailView.selectedMovieName = movieName;
    moviedetailView.selectedmovieType = [movietypeListArray objectAtIndex:indexPath.row];
    moviedetailView.selectedmovieDescrption = [moviedecListArray objectAtIndex:indexPath.row];
    moviedetailView.selectedmovieMakers = [moviemakerListArray objectAtIndex:indexPath.row];
    moviedetailView.selectedmovieRaking = [movierakingListArray objectAtIndex:indexPath.row];
    moviedetailView.selectedmoviedirectorName = [moviedirectorListArray objectAtIndex:indexPath.row];
    moviedetailView.selectedmoviewriterName = [moviemakerListArray objectAtIndex:indexPath.row];

    [self.navigationController pushViewController:moviedetailView animated:YES];
}

@end
