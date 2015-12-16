//
//  MainViewController.m
//  WhatPosters
//
//  Created by mac on 11/27/15.
//  Copyright © 2015 Xululabs. All rights reserved.
//

#import "MainViewController.h"
#import "SearchViewController.h"
#import <MobileCoreServices/MobileCoreServices.h>
#import <QuartzCore/QuartzCore.h>


@interface MainViewController () < UIImagePickerControllerDelegate, UINavigationControllerDelegate >
{
    UIImage *selectedImage;
    NSString *selectedImageUrl;
}
@property (nonatomic, retain) SearchViewController *secondView;
@property (nonatomic, retain) UIImage *theImage;
@property (strong, nonatomic) IBOutlet UIButton *takeCameraPhoto;
@property (strong, nonatomic) IBOutlet UIButton *takeGallaryPhoto;

@end

@implementation MainViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Main View";
    
    ///animation
//    self.takeCameraPhoto.layer.cornerRadius = self.takeCameraPhoto.bounds.size.width/6.0;
//    self.takeCameraPhoto.layer.borderWidth = 3.0;
//    self.takeCameraPhoto.layer.borderColor = self.takeCameraPhoto.titleLabel.textColor.CGColor;
//    self.takeCameraPhoto.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:18];
//
//    self.takeGallaryPhoto.layer.cornerRadius = self.takeCameraPhoto.bounds.size.width/6.0;
//    self.takeGallaryPhoto.layer.borderWidth = 3.0;
//    self.takeGallaryPhoto.layer.borderColor = self.takeCameraPhoto.titleLabel.textColor.CGColor;
//    self.takeGallaryPhoto.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:18];
    
    //background image on view
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageWithContentsOfFile:[[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"background.jpg"]]];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Button Action Methodes -

- (IBAction)takeCameraPhoto:(UIButton *)sender {
        [self didTakePhoto];
}

- (IBAction)takeGallaryPhoto:(UIButton *)sender{
        UIButton *localButton = (UIButton *)sender;
        [self selectImageFromLibrary:localButton.frame];
}

#pragma mark - Photo Methodes -

- (void)didTakePhoto {
    
    if ([self isCameraAvailable] && [self doesCameraSupportTakingPhotos]) {
        UIImagePickerController *controller = [[UIImagePickerController alloc] init];
        controller.sourceType = UIImagePickerControllerSourceTypeCamera;
        NSString *requiredMediaType = (__bridge NSString *)kUTTypeImage;
        controller.mediaTypes = [[NSArray alloc]
                                 initWithObjects:requiredMediaType, nil];
        controller.allowsEditing = YES;
        controller.delegate = self;
        [self presentViewController:controller animated:YES completion:nil];
    } else {
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Done" message:@"Camera is not available." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:@"Cancel", nil];
        [alert show];

    }
}

- (BOOL)isCameraAvailable {
    return [UIImagePickerController isSourceTypeAvailable:
            UIImagePickerControllerSourceTypeCamera];
}

- (BOOL)doesCameraSupportTakingPhotos {
    return [self cameraSupportsMedia:(__bridge NSString *)kUTTypeImage
                          sourceType:UIImagePickerControllerSourceTypeCamera];
}



- (BOOL)cameraSupportsMedia:(NSString *)paramMediaType
                 sourceType:(UIImagePickerControllerSourceType)paramSourceType {
    
    __block BOOL result = NO;
    if ([paramMediaType length] == 0){
        NSLog(@"Media type is empty.");
        return NO;
    }
    NSArray *availableMediaTypes =
    [UIImagePickerController
     availableMediaTypesForSourceType:paramSourceType];
    
    [availableMediaTypes enumerateObjectsUsingBlock:
     ^(id obj, NSUInteger idx, BOOL *stop) {
         
         NSString *mediaType = (NSString *)obj;
         if ([mediaType isEqualToString:paramMediaType]){
             result = YES;
             *stop= YES;
         }
     }];
    
    return result;
}


-(void) selectImageFromLibrary:(CGRect)frameRect {
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        [self presentViewController:picker animated:YES completion:NULL];
    }
}

#pragma mark --- UIImagePickerControllerDelegate Method
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    selectedImage = [info objectForKey:UIImagePickerControllerOriginalImage];
    selectedImageUrl = [info objectForKey:UIImagePickerControllerReferenceURL ];
    NSString *selectedname = [selectedImageUrl lastPathComponent];
    NSArray *imagenameExtract = [selectedname componentsSeparatedByString:@"."];
    NSString *actulimageName = [imagenameExtract objectAtIndex:0];
    NSString *imageExention = [imagenameExtract objectAtIndex:1];
    NSUserDefaults *imageDef = [NSUserDefaults standardUserDefaults];
    [imageDef setObject:actulimageName forKey:@"actulimageName"];
    [imageDef setObject:imageExention forKey:@"imageExention"];
    [self dismissModalViewControllerAnimated:YES];
    
    if(self.secondView == nil)
    {
        SearchViewController *nextView = [[SearchViewController alloc] initWithNibName:@"SearchViewController" bundle:[NSBundle mainBundle]];
        self.secondView = nextView;
        nextView.theImage = selectedImage;
        //nextView.theImageUrl = temimageString;
    }
    [self.navigationController pushViewController:_secondView animated:YES];
}


/*
#pragma mark --- UIImagePickerControllerDelegate Method

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    selectedImage = [info objectForKey:UIImagePickerControllerOriginalImage];
    [self dismissModalViewControllerAnimated:YES];
    
    if(self.secondView == nil)
    {
        SearchViewController *nextView = [[SearchViewController alloc] initWithNibName:@"SearchViewController" bundle:[NSBundle mainBundle]];
        self.secondView = nextView;
        nextView.theImage = selectedImage;
    }
    [self.navigationController pushViewController:secondView animated:YES];
}
 */

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [self dismissModalViewControllerAnimated:YES];
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
