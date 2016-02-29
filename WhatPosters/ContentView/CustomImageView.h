//
//  CustomImageView.h
//  FlickWiz
//
//  Created by Qazi on 20/02/2016.
//  Copyright © 2016 Qazi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomImageView : UIImageView{
    
    NSMutableData *_receivedData;
    UIActivityIndicatorView *_loadingIndicatorView;
    void (^_completionBlock)(BOOL finished);
}
@property BOOL suppressLoadingIndicator;

- (void)startLoading:(NSString*)url completion:(void (^)(BOOL finished))completion;
- (void)startLoading:(NSString*)url;

@end
