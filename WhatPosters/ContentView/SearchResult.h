//
//  SearchResult.h
//  FlickWiz
//
//  Created by Qazi on 16/02/2016.
//  Copyright © 2016 Qazi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SearchResult : UIViewController
@property (strong, nonatomic) IBOutlet UITableView *CustomeTableView;
@property (weak, nonatomic) NSMutableDictionary *jsonResponsDic;
@property (strong, nonatomic) IBOutlet UILabel *navigationlabel;
@property (strong, nonatomic) IBOutlet UIImageView *QueryimageView;
@property (strong, nonatomic)  UIImage *selectedImage1;

@end
