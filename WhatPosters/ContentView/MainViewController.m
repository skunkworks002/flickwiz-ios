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
    NSString *selectednameString;
    NSArray *imagenameExtractArray;
    NSString *actulimageNameString;
    NSString *imageExentionString;
    NSUserDefaults *imageDef;
}
@property (nonatomic, retain) UIImage *theImage;
@property (strong, nonatomic) IBOutlet UIButton *takeCameraPhoto;
@property (strong, nonatomic) IBOutlet UIButton *takeGallaryPhoto;

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Main View";
    
    //background image on view
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageWithContentsOfFile:[[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"background.jpg"]]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
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
    SearchViewController *searchController = [SearchViewController new];
    
    NSLog(@"%@", info);
    NSString *mediaType = info[UIImagePickerControllerMediaType];
    if ([mediaType isEqualToString:(__bridge NSString *)kUTTypeMovie]){
        NSURL *urlOfVideo = info[UIImagePickerControllerMediaURL];
        NSLog(@"Video URL = %@", urlOfVideo);
    }
    else if ([mediaType isEqualToString:(__bridge NSString *)kUTTypeImage]){
        /* Let's get the metadata. This is only for images. Not videos */
        selectednameString = (__bridge NSString *)kUTTypeImage;
        imagenameExtractArray = [selectednameString componentsSeparatedByString:@"."];
        actulimageNameString = [imagenameExtractArray objectAtIndex:0];
        imageExentionString = [imagenameExtractArray objectAtIndex:1];
        searchController.imageName = actulimageNameString;
        searchController.imageExt = imageExentionString;
        
        UIImage *theImageOriginal = info[UIImagePickerControllerOriginalImage];

        CGFloat imageHightB = theImageOriginal.size.height;
        CGFloat imageWeightB = theImageOriginal.size.width;
        searchController.imageHight = imageHightB;
        searchController.imageWeight = imageWeightB;
        [picker dismissViewControllerAnimated:YES completion:nil];
        UIImage *theImageEdit = info[UIImagePickerControllerEditedImage];
        selectedImage = theImageOriginal;
<<<<<<< Updated upstream
        
        if (theImageEdit) {
            selectedImage = theImageEdit;
            UIImageWriteToSavedPhotosAlbum(selectedImage, self, @selector(image:finishedSavingWithError:contextInfo:), nil);
        }

        else  {
            selectedImage = theImageOriginal;
            if (picker.sourceType != UIImagePickerControllerSourceTypeSavedPhotosAlbum) {
                UIImageWriteToSavedPhotosAlbum(selectedImage, self, @selector(image:finishedSavingWithError:contextInfo:), nil);
            }
        }
        if (theImageOriginal || theImageEdit) {
=======
        if (theImageOriginal) {
>>>>>>> Stashed changes
            searchController.theImage = selectedImage;
        }
        }
            [self.navigationController pushViewController:searchController animated:YES];

    }


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
