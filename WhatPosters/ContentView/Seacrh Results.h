//
//  Seacrh Results.h
//  WhatPosters
//
//  Created by Qazi on 27/11/2015.
//  Copyright © 2015 Qazi. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol GetmovieimagesnameArray <NSObject>

- (void)GetmoviesArray :(NSDictionary *)movieimagesDictr ;

@end
@interface Seacrh_Results : UITableViewController

@property (assign, nonatomic) id<GetmovieimagesnameArray> delegateMC;
@end
