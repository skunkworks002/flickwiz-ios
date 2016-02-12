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

#pragma mark - PECropViewControllerDelegate methods

- (void)cropViewController:(PECropViewController *)controller didFinishCroppingImage:(UIImage *)croppedImage transform:(CGAffineTransform)transform cropRect:(CGRect)cropRect
{
    theImageTake = croppedImage;
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        [self updateEditButtonEnabled];
    }
    [self pusingFunctionToSearchView];
    [controller dismissViewControllerAnimated:YES completion:NULL];
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
- (void)cropViewControllerDidCancel:(PECropViewController *)controller {
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        [self updateEditButtonEnabled];
    }
    [controller dismissViewControllerAnimated:YES completion:NULL];
    [self pusingFunctionToSearchView];
}

#pragma mark - Action methods

- (void)openEditor:(id)sender {
    PECropViewController *controller = [[PECropViewController alloc] init];
    controller.delegate = self;
    controller.image = theImageTake;
    UIImage *image = theImageTake;
    CGFloat width = image.size.width;
    CGFloat height = image.size.height;
    CGFloat length = MIN(width, height);
    controller.imageCropRect = CGRectMake((width - length) / 2,
                                          (height - length) / 2,
                                          length,
                                          length);
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:controller];
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        navigationController.modalPresentationStyle = UIModalPresentationFormSheet;
    }
    [self presentViewController:navigationController animated:YES completion:NULL];
}

- (void)updateEditButtonEnabled
{
    editButton.enabled = !!theImageTake;
}

#pragma mark - Button Action Methodes takeCameraPhoto  -

- (IBAction)takeCameraPhoto:(UIButton *)sender {
    [self didTakePhoto];
}

#pragma mark - Button Action Methodes takeGallaryPhoto -

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
        [self cameralertview];
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
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    theImageTake = image;
    imageInfo = info;
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        if (popover.isPopoverVisible) {
            [popover dismissPopoverAnimated:NO];
        }
        [self updateEditButtonEnabled];
        [self openEditor:nil];
    } else {
        [picker dismissViewControllerAnimated:YES completion:^{
            [self openEditor:nil];
        }];
    }
}

- (void)image:(UIImage *)image finishedSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    if (error) {
        [self imagesavealertView];
    }
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark AlerView

- (void)cameralertview {
    [ASAlertView alertWithTitle:ApplicationTitle message:@"Camera is not available..."];
}
- (void)imagesavealertView {
    
    [ASAlertView alertWithTitle:ApplicationTitle message:@"Failed to save image..."];
    
}

@end
