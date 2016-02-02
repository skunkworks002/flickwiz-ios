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
#import "PECropViewController.h"


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
@property (nonatomic, weak) UIBarButtonItem *editButton;

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Main View";
    
    editButton = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemEdit target:self action:@selector(openEditor:)];
    self.navigationItem.rightBarButtonItem.enabled=NO;
    
    //background image on view
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageWithContentsOfFile:[[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"background.jpg"]]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - PECropViewControllerDelegate methods

- (void)cropViewController:(PECropViewController *)controller didFinishCroppingImage:(UIImage *)croppedImage transform:(CGAffineTransform)transform cropRect:(CGRect)cropRect
{
    self.theImageTake = croppedImage;
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        [self updateEditButtonEnabled];
    }
    
    
    
       SearchViewController *searchController = [SearchViewController new];
    //
      //  NSLog(@"%@", imageInfo);
        NSString *mediaType = imageInfo[UIImagePickerControllerMediaType];
    //    if ([mediaType isEqualToString:(__bridge NSString *)kUTTypeMovie]){
    //        NSURL *urlOfVideo = info[UIImagePickerControllerMediaURL];
    //        NSLog(@"Video URL = %@", urlOfVideo);
    //    }
        if ([mediaType isEqualToString:(__bridge NSString *)kUTTypeImage]){
            /* Let's get the metadata. This is only for images. Not videos */
            selectednameString = (__bridge NSString *)kUTTypeImage;
            imagenameExtractArray = [selectednameString componentsSeparatedByString:@"."];
            actulimageNameString = [imagenameExtractArray objectAtIndex:0];
            imageExentionString = [imagenameExtractArray objectAtIndex:1];
            searchController.imageName = actulimageNameString;
            searchController.imageExt = imageExentionString;
    //        UIImage *theImageOriginal = imageInfo[UIImagePickerControllerOriginalImage];
    
    UIImage *myResultImage = self.theImageTake;
    
            CGFloat imageHightB = myResultImage.size.height;
            CGFloat imageWeightB = myResultImage.size.width;
            searchController.imageHight = imageHightB;
            searchController.imageWeight = imageWeightB;
    //        [picker dismissViewControllerAnimated:YES completion:nil];
    //        UIImage *theImageEdit = info[UIImagePickerControllerEditedImage];
    //        selectedImage = theImageOriginal;
    //
    //        if (theImageEdit) {
    //            selectedImage = theImageEdit;
    //        }
    //
    //        else  {
    //            selectedImage = theImageOriginal;
    //        }
    //        if (theImageOriginal || theImageEdit) {
                searchController.theImage = myResultImage;
        
 
        [self.navigationController pushViewController:searchController animated:YES];
        }
    
    
    [controller dismissViewControllerAnimated:YES completion:NULL];


    
    
    
    
}

- (void)cropViewControllerDidCancel:(PECropViewController *)controller
{
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        [self updateEditButtonEnabled];
    }
    
    [controller dismissViewControllerAnimated:YES completion:NULL];
}

#pragma mark - Action methods

- (void)openEditor:(id)sender
{
    PECropViewController *controller = [[PECropViewController alloc] init];
    controller.delegate = self;
    controller.image = self.theImageTake;
    
    UIImage *image = self.theImageTake;
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
    self.editButton.enabled = !!self.theImageTake;
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
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    self.theImageTake = image;
    imageInfo = info;
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        if (self.popover.isPopoverVisible) {
            [self.popover dismissPopoverAnimated:NO];
        }
        
        [self updateEditButtonEnabled];
        
        [self openEditor:nil];
    } else {
        [picker dismissViewControllerAnimated:YES completion:^{
            [self openEditor:nil];
        }];
    }
}

//    SearchViewController *searchController = [SearchViewController new];
//
//    NSLog(@"%@", info);
//    NSString *mediaType = info[UIImagePickerControllerMediaType];
//    if ([mediaType isEqualToString:(__bridge NSString *)kUTTypeMovie]){
//        NSURL *urlOfVideo = info[UIImagePickerControllerMediaURL];
//        NSLog(@"Video URL = %@", urlOfVideo);
//    }
//    else if ([mediaType isEqualToString:(__bridge NSString *)kUTTypeImage]){
//        /* Let's get the metadata. This is only for images. Not videos */
//        selectednameString = (__bridge NSString *)kUTTypeImage;
//        imagenameExtractArray = [selectednameString componentsSeparatedByString:@"."];
//        actulimageNameString = [imagenameExtractArray objectAtIndex:0];
//        imageExentionString = [imagenameExtractArray objectAtIndex:1];
//        searchController.imageName = actulimageNameString;
//        searchController.imageExt = imageExentionString;
//        UIImage *theImageOriginal = info[UIImagePickerControllerOriginalImage];
//        CGFloat imageHightB = theImageOriginal.size.height;
//        CGFloat imageWeightB = theImageOriginal.size.width;
//        searchController.imageHight = imageHightB;
//        searchController.imageWeight = imageWeightB;
//        [picker dismissViewControllerAnimated:YES completion:nil];
//        UIImage *theImageEdit = info[UIImagePickerControllerEditedImage];
//        selectedImage = theImageOriginal;
//
//        if (theImageEdit) {
//            selectedImage = theImageEdit;
//        }
//
//        else  {
//            selectedImage = theImageOriginal;
//        }
//        if (theImageOriginal || theImageEdit) {
//            searchController.theImage = selectedImage;
//
//
//        }
//    }
//    [self.navigationController pushViewController:searchController animated:YES];




- (void)image:(UIImage *)image finishedSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    if (error) {
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle: @"Save failed"
                              message: @"Failed to save image"
                              delegate: nil
                              cancelButtonTitle:@"OK"
                              otherButtonTitles:nil];
        [alert show];
    }
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
