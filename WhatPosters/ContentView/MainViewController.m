//
//  MainViewController.m
//  WhatPosters
//
//  Created by mac on 11/27/15.
//  Copyright © 2015 Xululabs. All rights reserved.
//
#define ApplicationTitle @"Flick Wiz"

#import "MainViewController.h"
#import "SearchViewController.h"
#import <MobileCoreServices/MobileCoreServices.h>
#import <QuartzCore/QuartzCore.h>
#import "PECropViewController.h"
#import "ASAlertView.h"

@interface MainViewController () < UIImagePickerControllerDelegate, UINavigationControllerDelegate,PECropViewControllerDelegate >
{
    int buttonTag;
    int squareImageStartY;
    UIImage *selectedImage;
    NSString *selectedImageUrl;
    NSString *selectednameString;
    NSArray *imagenameExtractArray;
    NSString *actulimageNameString;
    NSString *imageExentionString;
    NSUserDefaults *imageDef;
    UIBarButtonItem *editButton;
    NSDictionary *imageInfo;
}
@property (nonatomic, retain) UIImage *theImageTake;
@property (strong, nonatomic) IBOutlet UIButton *takeCameraPhoto;
@property (strong, nonatomic) IBOutlet UIButton *takeGallaryPhoto;
@property (nonatomic) UIPopoverController *popover;
@property (nonatomic, strong) UIBarButtonItem *editButton;
@end

@implementation MainViewController
@synthesize editButton,takeCameraPhoto,takeGallaryPhoto,theImageTake,popover;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Main View";
    editButton = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemEdit target:self action:@selector(openEditor:)];
    self.navigationItem.rightBarButtonItem.enabled=NO;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)pusingFunctionToSearchView {
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        [self updateEditButtonEnabled];
    }
    SearchViewController *searchController = [SearchViewController new];
    NSString *mediaType = imageInfo[UIImagePickerControllerMediaType];
    if ([mediaType isEqualToString:(__bridge NSString *)kUTTypeImage]){
        /* Let's get the metadata. This is only for images. Not videos */
        selectednameString = (__bridge NSString *)kUTTypeImage;
        imagenameExtractArray = [selectednameString componentsSeparatedByString:@"."];
        actulimageNameString = [imagenameExtractArray objectAtIndex:0];
        imageExentionString = [imagenameExtractArray objectAtIndex:1];
        searchController.imageName = actulimageNameString;
        searchController.imageExt = imageExentionString;
        UIImage *myResultImage = theImageTake;
        CGFloat imageHightB = myResultImage.size.height;
        CGFloat imageWeightB = myResultImage.size.width;
        searchController.imageHight = imageHightB;
        searchController.imageWeight = imageWeightB;
        searchController.theImage = myResultImage;

    }
    [self.navigationController pushViewController:searchController animated:YES];
}

#pragma mark - Action methods

- (void)updateEditButtonEnabled {
    editButton.enabled = !!theImageTake;
}

- (IBAction)takeCameraPhoto:(UIButton *)sender {
    UIButton *localButton = (UIButton *)sender;
    buttonTag = localButton.tag;
    [self didTakePhoto];
}

- (IBAction)takeGallaryPhoto:(UIButton *)sender{
    UIButton *localButton = (UIButton *)sender;
    buttonTag = localButton.tag;
    [self selectImageFromLibrary:localButton.frame];
}

#pragma mark - Photo Methodes -

- (void)didTakePhoto {
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        UIImagePickerController *controller = [[UIImagePickerController alloc] init];
        controller.delegate = self;
        controller.sourceType = UIImagePickerControllerSourceTypeCamera;
        controller.showsCameraControls = YES;
        [self presentViewController:controller animated:YES completion:nil];
    }
    else {
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

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    imageInfo= info;
    
    // originalImage's ratio is 3:4, size is 2448 * 3264
    UIImage *originalImage = [info objectForKey:UIImagePickerControllerOriginalImage];
    if (buttonTag == 100) {
        theImageTake = originalImage;
        [picker dismissViewControllerAnimated:YES completion:^{
            [self pusingFunctionToSearchView];
        }];
    }
    else {
        [picker dismissViewControllerAnimated:YES completion:^{
            theImageTake = originalImage;
            [self pusingFunctionToSearchView];
        }];
    }
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)image:(UIImage *)image finishedSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    if (error) {
        [self imagesavealertView];
    }
}

#pragma mark AlerView

- (void)cameralertview {
    [ASAlertView alertWithTitle:ApplicationTitle message:@"Camera is not available..."];
}
- (void)imagesavealertView {
    [ASAlertView alertWithTitle:ApplicationTitle message:@"Failed to save image..."];
}

@end
