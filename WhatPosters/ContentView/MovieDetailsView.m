//
//  MovieDetailsView.m
//  WhatPosters
//
//  Created by Qazi on 27/11/2015.
//  Copyright © 2015 Qazi. All rights reserved.
//

#import "MovieDetailsView.h"
#import <Social/Social.h>

@interface MovieDetailsView () <UITextViewDelegate> {

    IBOutlet UILabel *WriterNames;
    IBOutlet UILabel *dirctorName;
    IBOutlet UIImageView *movieImageView;
    IBOutlet UITextView *moviedecrptiontextView;
    IBOutlet UILabel *movieType;
    IBOutlet UILabel *movieNamerelsingDate;
    IBOutlet UILabel *moviedirectorNameLabel;
    IBOutlet UILabel *movieWriterName;
}

@end

@implementation MovieDetailsView
@synthesize selectedImage;
@synthesize selectedMovieName;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Movie Detail";
//    NSString *s = @"Qazi Saqib";
//    NSString *secondString = [s stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    movieImageView.layer.cornerRadius = movieImageView.frame.size.width / 2;
    movieImageView.clipsToBounds = YES;
    
    movieImageView.image = selectedImage;
    movieNamerelsingDate.text = selectedMovieName;
    movieType.text = _selectedmovieType;
    moviedecrptiontextView.text = _selectedmovieDescrption;
    dirctorName.text = _selectedmovieMakers;
    WriterNames.text = _selectedmovieRaking;
    moviedirectorNameLabel.text = _selectedmoviedirectorName;
    movieWriterName.text = _selectedmoviewriterName;
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageWithContentsOfFile:[[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"ImageUploadedByModMyi1342057019.344337.jpg"]]];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Button Action Methodes twitterPostButton  -

-(IBAction)twitterPostButton:(id)sender{
    
    if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter])
    {
        SLComposeViewController *tweetSheet = [SLComposeViewController
                                               composeViewControllerForServiceType:SLServiceTypeTwitter];
        [tweetSheet setInitialText:selectedMovieName];
        //[tweetSheet addImage:[UIImage imageNamed:@"images.jpeg"]];
       // [tweetSheet setInitialText:_selectedmovieDescrption];
        [tweetSheet addURL:[NSURL URLWithString:@"https://en.wikipedia.org/wiki/Iron_Man_2"]];

        [tweetSheet addImage:selectedImage];
        [self presentViewController:tweetSheet animated:YES completion:nil];
    }
    else
    {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Twitter" message:@"A Twitter account must be set up on your device. login within your device setting twitter account.." preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction* ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
        [alertController addAction:ok];
        [self presentViewController:alertController animated:YES completion:nil];
    }
}

#pragma mark - Button Action Methodes faceBookPostButton  -

-(IBAction)faceBookPostButton:(id)sender{
    
    if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeFacebook])
    {
        SLComposeViewController *fbookSheet = [SLComposeViewController
                                               composeViewControllerForServiceType:SLServiceTypeFacebook];
        [fbookSheet setInitialText:selectedMovieName];

      //  [fbookSheet setTitle:_selectedmovieDescrption];
        
        [fbookSheet addImage:selectedImage];
        [fbookSheet addURL:[NSURL URLWithString:@"https://en.wikipedia.org/wiki/Iron_Man_2"]];
        
        [self presentViewController:fbookSheet animated:YES completion:nil];
    }
    else
    {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"FaceBook" message:@"A FaceBook account must be set up on your device. login within your device setting FaceBook account.." preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction* ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
        [alertController addAction:ok];
        [self presentViewController:alertController animated:YES completion:nil];
    }
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
