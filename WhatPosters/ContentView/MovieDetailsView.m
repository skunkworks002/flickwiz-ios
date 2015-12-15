//
//  MovieDetailsView.m
//  WhatPosters
//
//  Created by Qazi on 27/11/2015.
//  Copyright © 2015 Qazi. All rights reserved.
//

#import "MovieDetailsView.h"

@interface MovieDetailsView () <UITextViewDelegate> {

    IBOutlet UILabel *WriterNames;
    IBOutlet UILabel *dirctorName;
    IBOutlet UIImageView *movieImageView;
    IBOutlet UITextView *moviedecrptiontextView;
    IBOutlet UILabel *movieType;
    IBOutlet UILabel *movieNamerelsingDate;
}

@end

@implementation MovieDetailsView
@synthesize selectedImage;
@synthesize selectedMovieName;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Movie Detail";
    
    movieImageView.layer.cornerRadius = movieImageView.frame.size.width / 2;
    movieImageView.clipsToBounds = YES;
    
    movieImageView.image = selectedImage;
    movieNamerelsingDate.text = selectedMovieName;
    movieType.text = _selectedmovieType;
    moviedecrptiontextView.text = _selectedmovieDescrption;
    dirctorName.text = _selectedmovieMakers;
    WriterNames.text = _selectedmovieRaking;
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageWithContentsOfFile:[[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"ImageUploadedByModMyi1342057019.344337.jpg"]]];

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
