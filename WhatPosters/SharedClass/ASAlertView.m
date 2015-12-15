//
//  ASAlertView.m
//  Scorefolio
//
//  Created by Atif Saeed on 04/07/2015.
//  Copyright (c) 2015 XULU Labs. All rights reserved.
//

#import "ASAlertView.h"

@implementation ASAlertView

+ (void)alertWithTitle:(NSString *)title message:(NSString *)message {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:message delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alert show];
}

@end
