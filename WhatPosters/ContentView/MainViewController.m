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
    int buttonTag;
    int squareImageStartY;
    UIImage *selectedImage;
    NSString *selectedImageUrl;
    NSString *selectednameString;
    NSArray *imagenameExtractArray;
    NSString *actulimageNameString;
    NSString *imageExentionString;
    NSUserDefaults *imageDef;
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
    //background image on view
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageWithContentsOfFile:[[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"background.jpg"]]];
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
    return [self.navigationController pushViewController:searchController animated:YES];
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
    UIButton *localButton = (UIButton *)sender;
    buttonTag = localButton.tag;
    [self didTakePhoto];
}

#pragma mark - Button Action Methodes takeGallaryPhoto -

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
        controller.showsCameraControls = NO;
        squareImageStartY = 400 - 320;
        // Top View In Camera
        UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, squareImageStartY)];
        UIImageView  *logoImage = [[UIImageView alloc] initWithFrame:CGRectMake(20, 10, 280, 60)];
        logoImage.image = [UIImage imageNamed:@"logoo.png"];
        logoImage.contentMode = UIViewContentModeScaleToFill;
        [topView addSubview:logoImage];
        [controller.cameraOverlayView addSubview:topView];
        topView.backgroundColor = [UIColor blackColor];
        int y = topView.frame.origin.y +topView.frame.size.height + 320;
        // Bottom View In Camera
        UIView *bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, y, 320, [UIScreen mainScreen].bounds.size.height - y)];
        bottomView.backgroundColor = [UIColor blackColor];
        [controller.cameraOverlayView addSubview:bottomView];
        CGRect rect = CGRectMake(0.0f,80.0f,320,320);
        UIImageView  *overlayView = [[UIImageView alloc] initWithFrame:rect];
        UIImage *image = [UIImage imageNamed:@"overlaygraphic.png"];
        overlayView.image = image;
        overlayView.contentMode = UIViewContentModeScaleToFill;
        overlayView.autoresizingMask =
        UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        overlayView.alpha = 0.5;
        [controller.cameraOverlayView addSubview:overlayView];
        // cancelCameraButton
        UIButton *cancelCameraBut = [[UIButton alloc] initWithFrame:CGRectMake(160-120,bottomView.frame.size.height/2 - 10, 30, 30)];
        [cancelCameraBut setBackgroundImage:[UIImage imageNamed:@"CameraClose.png"] forState:UIControlStateNormal];
        [cancelCameraBut setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [cancelCameraBut addTarget:controller action:@selector(dismissModalViewControllerAnimated:) forControlEvents:UIControlEventTouchUpInside];
        [bottomView addSubview:cancelCameraBut];
        // TakePhotoButton
        UIButton *takePhotoBut = [[UIButton alloc] initWithFrame:CGRectMake(160-40,bottomView.frame.size.height/2 - 25, 80, 80)];
        [takePhotoBut setBackgroundImage:[UIImage imageNamed:@"CameraShot.png"] forState:UIControlStateNormal];
        [takePhotoBut setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [takePhotoBut addTarget:controller action:@selector(takePicture) forControlEvents:UIControlEventTouchUpInside];
        [bottomView addSubview:takePhotoBut];
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

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    imageInfo= info;
    
    // originalImage's ratio is 3:4, size is 2448 * 3264
    UIImage *originalImage = [info objectForKey:UIImagePickerControllerOriginalImage];
    if (buttonTag == 100) {
        theImageTake = originalImage;
        [picker dismissViewControllerAnimated:YES completion:^{
            [self openEditor:nil];
        }];
    }
    else {
    [picker dismissViewControllerAnimated:YES completion:^{
        CGImageRef imageRef = nil;
        if([UIScreen mainScreen].bounds.size.height > 480)
        {
            UIGraphicsBeginImageContext(CGSizeMake(640, 852));
            [originalImage drawInRect: CGRectMake(0, 0, 640, 852)];
            UIImage *smallImage = UIGraphicsGetImageFromCurrentImageContext();
            UIGraphicsEndImageContext();
            int y = squareImageStartY*2;
            CGRect cropRect = CGRectMake(0, y, 640, 640);
            imageRef = CGImageCreateWithImageInRect([smallImage CGImage], cropRect);
        }
        else
        {
            UIGraphicsBeginImageContext(CGSizeMake(720, 960));
            [originalImage drawInRect: CGRectMake(0, 0, 720, 960)];
            UIImage *smallImage = UIGraphicsGetImageFromCurrentImageContext();
            UIGraphicsEndImageContext();
            int y = squareImageStartY*2;
            CGRect cropRect = CGRectMake(40, y, 640, 640);
            imageRef = CGImageCreateWithImageInRect([smallImage CGImage], cropRect);
            
        }
        theImageTake = [UIImage imageWithCGImage:imageRef];
        [self pusingFunctionToSearchView];
     }];
    }
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
