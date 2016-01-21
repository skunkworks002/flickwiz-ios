//
//  MovieTypeDetailController.m
//  FlickWiz
//
//  Created by mac on 1/18/16.
//  Copyright © 2016 Qazi. All rights reserved.
//

#import "MovieTypeDetailController.h"
#import "MovieCell.h"

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
    
    UIImage *imagesData;
    UIImage *myImage;
    NSData *imageDate;
}

@end

@implementation MovieTypeDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Movie Type Detail";

    // Array init
    movieDateListArray = [NSMutableArray array];
    dateReleaseArray = [NSMutableArray array];
    movieNameListArray = [NSMutableArray array];
    movieTypeImageListArray = [NSMutableArray array];
    
    // json result
    
    NSUserDefaults *jasonRes = [NSUserDefaults standardUserDefaults];
    myresult = [jasonRes objectForKey:@"responsJsonDic"];
    
    // Movie Type Detail Main ARRAY
    mainJsonArray = [myresult objectForKey:@"names"];
    if ([mainJsonArray count ]== 0) {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"FlickWiz" message:@"Data is not Avilable" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction* ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
        [alertController addAction:ok];
        NSLog(@"no data");
    }
    else {
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
    }}
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
    imagesData =[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[movieTypeImageListArray objectAtIndex:indexPath.row]]]];
    [cell.movieImages setImage:imagesData];
    cell.movienameLabel.text = [movieNameListArray objectAtIndex:indexPath.row];
    cell.movieDateLabel.text = [movieDateListArray objectAtIndex:indexPath.row];
    cell.movieImages.layer.backgroundColor=[[UIColor clearColor] CGColor];
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
