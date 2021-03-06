
//
//  SearchResult.m
//  FlickWiz
//
//  Created by Qazi on 16/02/2016.
//  Copyright © 2016 Qazi. All rights reserved.
//

#import "SearchResult.h"
#import "MovieCell.h"
#import "MoviewDetailController.h"
#import "MainViewController.h"
#import "CustomImageView.h"

static const CGFloat cellHeight = 100;
static const CGFloat cellSpacing = 0;

@interface SearchResult ()<UITableViewDataSource,UITableViewDelegate> {
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
    NSArray *imagearray;
    NSArray *imagesUrlArray;
    NSArray *movienameArray;
    NSArray *MoviewPosterNamesArray;
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
    NSMutableDictionary *myresult;
    UIImage *imagesData;
    UIImage *myImage;
    NSData *imageDate;
}
@end

@implementation SearchResult
@synthesize jsonResponsDic,QueryimageView;


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Best Matches";
    moviedateArray = [NSMutableArray array];
    movietypeListArray = [NSMutableArray array];
    moviedecListArray = [NSMutableArray array];
    moviemakerListArray = [NSMutableArray array];
    movierakingListArray = [NSMutableArray array];
    moviewriterListArray = [NSMutableArray array];
    moviedirectorListArray = [NSMutableArray array];
    moviedetailpathListArray = [NSMutableArray array];
    self.QueryimageView.image = _selectedImage1;
    [self callingFunctionAllLoops];
    
    // Do any additional setup after loading the view from its nib.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UIView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [imagesUrlArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *simpleTableIdentifier = @"Cell";
    MovieCell *cell = (MovieCell *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    if (cell == nil) {
        NSArray *nibArray = [[NSBundle mainBundle] loadNibNamed:@"MovieCell" owner:self options:nil];
        cell = [nibArray objectAtIndex:0];
        
    }
    [cell.movieImages startLoading:[imagesUrlArray objectAtIndex:indexPath.row]];
    cell.movienameLabel.text = [movienameArray objectAtIndex:indexPath.row];
    cell.movieDateLabel.text = [moviedateArray objectAtIndex:indexPath.row];
    cell.movieImages.layer.masksToBounds = YES;
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    MoviewDetailController *moviedetailView = [MoviewDetailController new];
    // first access the cell
    static NSString *simpleTableIdentifier = @"Cell";
    MovieCell *cell = (MovieCell *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    if (cell == nil) {
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
    moviedetailView.selectedmoviewriterName = [moviewriterListArray objectAtIndex:indexPath.row];
    moviedetailView.selectedmoviedetailpathString = [moviedetailpathListArray objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:moviedetailView animated:YES];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return cellHeight;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return cellSpacing;
}

- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section
{
    view.tintColor = [UIColor clearColor];
}

-(void)callingFunctionAllLoops {
    // json result
    myresult = jsonResponsDic;
    imagesUrlArray = [myresult objectForKey:@"urls"];
    movienameArray = [myresult objectForKey:@"names"];
    // IMDBDETAIL ARRAY
    MoviewPosterNamesArray = [myresult objectForKey:@"imdbdetials"];
    // use for loop here Movie Detail path Count
    for (NSInteger i=0; i<[MoviewPosterNamesArray count]; i++) {
        moviedetailpathArray = [MoviewPosterNamesArray objectAtIndex:i];
        moviedetailpathString = [moviedetailpathArray objectAtIndex:0];
        [moviedetailpathListArray addObject:moviedetailpathString];
    }
    //  use for loop here Movie Date Count
    for (NSInteger i=0; i<[MoviewPosterNamesArray count]; i++) {
        dateArray = [MoviewPosterNamesArray objectAtIndex:i];
        Datestring2 = [dateArray objectAtIndex:3];
        [moviedateArray addObject:Datestring2];
    }
    //  movie Type loop
    for (NSInteger i=0; i<[MoviewPosterNamesArray count]; i++) {
        movietypeArray = [MoviewPosterNamesArray objectAtIndex:i];
        movietypestring = [movietypeArray objectAtIndex:5];
        [movietypeListArray addObject:movietypestring];
    }
    //  movie director name
    for (NSInteger i=0; i<[MoviewPosterNamesArray count]; i++) {
        moviedirctorArray = [MoviewPosterNamesArray objectAtIndex:i];
        moviedirectorString = [moviedirctorArray objectAtIndex:6];
        [moviedirectorListArray addObject:moviedirectorString];
    }
    //  movie writers name
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

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
