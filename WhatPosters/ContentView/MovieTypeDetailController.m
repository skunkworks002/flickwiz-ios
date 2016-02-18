//
//  MovieTypeDetailController.m
//  FlickWiz
//
//  Created by mac on 1/18/16.
//  Copyright © 2016 Qazi. All rights reserved.
//

#import "MovieTypeDetailController.h"
#import "MovieCell.h"
static const CGFloat cellHeight = 90;
static const CGFloat cellSpacing = 20;

@interface MovieTypeDetailController ()<UIAlertViewDelegate> {
    // NSStrings
    NSString *movieNameString;
    NSString *movieTypeImageString;
    NSString *DateReleaseString;
    //  Arrays
    NSArray *mainJsonArray;
    NSMutableArray *movieTypeImageArray;
    NSMutableArray *movieTypeImageListArray;
    NSMutableArray *movieNameArray;
    NSMutableArray *movieNameListArray;
    NSMutableArray *dateReleaseArray;
    NSMutableArray *movieDateListArray;
    NSMutableDictionary *myresult;
    NSMutableArray *genericArr;
    // image Data
    UIImage *imagesData;
    UIImage *myImage;
    NSData *imageDate;
}
@end

@implementation MovieTypeDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Movie Type List";
    // Array init
    genericArr = [[NSMutableArray alloc]init];
    movieDateListArray = [NSMutableArray array];
    dateReleaseArray = [NSMutableArray array];
    movieNameListArray = [NSMutableArray array];
    movieTypeImageListArray = [NSMutableArray array];
    [self responseFuncton];
    self.tableView.backgroundColor = [UIColor lightGrayColor];
    self.tableView.separatorColor = [UIColor clearColor];
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
    return [movieTypeImageListArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *simpleTableIdentifier = @"Cell";
    MovieCell *cell = (MovieCell *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    if (cell == nil) {
        NSArray *nibArray = [[NSBundle mainBundle] loadNibNamed:@"MovieCell" owner:self options:nil];
        cell = [nibArray objectAtIndex:0];
    }
    NSMutableDictionary *dataDict = [genericArr objectAtIndex:indexPath.row];
    imagesData =[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[dataDict objectForKey:@"movieImages"]]]];
    [cell.movieImages setImage:imagesData];
    cell.movienameLabel.text =    [dataDict objectForKey:@"movieNames"];
    cell.movieDateLabel.text = [dataDict objectForKey:@"movieDate"];
    cell.movieImages.backgroundColor=[UIColor whiteColor];
    cell.movieImages.layer.masksToBounds = YES;
    cell.selectionStyle = UITableViewCellAccessoryNone;
    return cell;
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

#pragma mark - Table view delegate

//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//}

-(void)responseFuncton {
    // json result
    NSUserDefaults *jasonRes = [NSUserDefaults standardUserDefaults];
    myresult = [jasonRes objectForKey:@"responsJsonDic"];
    // Movie Type Detail Main ARRAY
    mainJsonArray = [myresult objectForKey:@"names"];
    // use for loop here Movie type images url's path Count
    for (NSInteger i=0; i<[mainJsonArray count]; i++) {
        movieTypeImageArray = [mainJsonArray objectAtIndex:i];
        movieTypeImageString = [movieTypeImageArray objectAtIndex:0];
        [movieTypeImageListArray addObject:movieTypeImageString];
    }
    // use for loop here Movie Type Name's Count
    for (NSInteger i=0; i<[mainJsonArray count]; i++) {
        movieNameArray = [mainJsonArray objectAtIndex:i];
        movieNameString = [movieNameArray objectAtIndex:1];
        [movieNameListArray addObject:movieNameString];
    }
    // movie Type Realease Date loop
    for (NSInteger i=0; i<[mainJsonArray count]; i++) {
        dateReleaseArray = [mainJsonArray objectAtIndex:i];
        DateReleaseString = [dateReleaseArray objectAtIndex:2];
        [movieDateListArray addObject:DateReleaseString];
    }
    
    
    for (int i = 0; i < [movieTypeImageListArray count]; i++) {
        
        NSMutableDictionary *dataDict = [NSMutableDictionary dictionaryWithObjectsAndKeys:[movieTypeImageListArray objectAtIndex:i],@"movieImages",[movieNameListArray objectAtIndex:i],@"movieNames",[movieDateListArray objectAtIndex:i],@"movieDate", nil];
        [genericArr addObject:dataDict];
        
    }
    
}

@end
