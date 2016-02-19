//
//  MoviesPersonsDetailView.h
//  FlickWiz
//
//  Created by mac on 1/12/16.
//  Copyright © 2016 Qazi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MoviesPersonsDetailView : UITableViewController

@property (nonatomic, weak) NSString *titleName;

@property (strong, nonatomic) NSDictionary *jsonResponsDic;

@end
