//
//  Utility.m
//  SF1
//
//  Created by Qazi on 09/09/2015.
//  Copyright (c) 2015 XULU Labs. All rights reserved.
//
// abc

#import "Utility.h"
#import "Venue.h"
NSString *venueName;
NSString *venueid;
NSString *venuenameID;

@implementation Utility

#pragma mark - Validate Methods

#pragma marks - Utiltiy

+ (Utility *) sharedManager {
    
    static Utility *shareManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^ {
        shareManager = [[Utility alloc] init];
    });
    return shareManager;
}

- (id) init {
    self = [super init];
    if(self) {
        self.venueData = [[NSArray alloc] init];
        self.facilityData = [[NSArray alloc] init];
    }
    return self;
}

- (void)setVenueArray:(NSArray *)array {
    _venueData = array;
}

- (NSArray *)getVenueArray {
    NSMutableArray *temArray = [NSMutableArray new];
    //    for (Venue *venue in _venueData) {
    //       venueName = [NSString stringWithFormat:@"%@",venue.name];
    //       venueid = [NSString stringWithFormat:@"%lu",(unsigned long)venue.identifier];
    //       venuenameID = [NSString stringWithFormat:@"%@(%@)",venueName,venueid];
    //[temArray addObject:venuenameID];
    //  }
    return temArray;
}

- (void)setFacilityArray:(NSArray *)array {
    _facilityData = array;
}

- (NSArray *)getFacilityArray {
    NSMutableArray *temArray = [NSMutableArray new];
    for (Venue *venue in _facilityData) {
        venueName =[NSString stringWithFormat:@"%@",venue.name];
        venueid = [NSString stringWithFormat:@"%lu",(unsigned long)venue.identifier];
        venuenameID =[NSString stringWithFormat:@"%@(%@)",venueName,venueid];
        [temArray addObject:venuenameID];
    }
    return temArray;
}

- (void)setOpenentArray:(NSArray *)array {
    _openentData = array;
}

- (NSArray *)getOpenentArray {
    NSMutableArray *temArray = [NSMutableArray new];
    for (Venue *venue in _openentData) {
        venueName =[NSString stringWithFormat:@"%@",venue.name];
        venueid = [NSString stringWithFormat:@"%lu",(unsigned long)venue.identifier];
        venuenameID =[NSString stringWithFormat:@"%@(%@)",venueName,venueid];
        [temArray addObject:venuenameID];
    }
    return temArray;
}

- (void)setTeamArray:(NSArray *)array {
    _teamData = array;
}

- (NSArray *)getTeamArray {
    NSMutableArray *temArray = [NSMutableArray new];
    for (Venue *venue in _teamData) {
        venueName =[NSString stringWithFormat:@"%@",venue.name];
        venueid = [NSString stringWithFormat:@"%lu",(unsigned long)venue.identifier];
        venuenameID =[NSString stringWithFormat:@"%@(%@)",venueName,venueid];
        [temArray addObject:venuenameID];
    }
    return temArray;
}

+ (BOOL)validateString:(NSString *)string withLenth:(NSInteger)isLength {
    NSString *nameRegex;
    
    switch (isLength) {
        case 1:
            
            nameRegex = @"[A-Za-z ]{3,30}";
            break;
            
        case 2:
            nameRegex = @"[A-Za-z ]{3,100}";
            break;
            
        case 3:
            nameRegex = @"[A-Za_z]{2,2}";
            break;
            
        default:
            break;
    }
    
    NSPredicate *nameTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", nameRegex];
    return [nameTest evaluateWithObject:string];
}

+ (BOOL)validateUsername:(NSString *)string withLength:(NSInteger)isLength {
    NSString *nameRegex;
    
    switch (isLength) {
        case 1:
            nameRegex = @"[A-Za-z ]{3,30}";
            break;
            
        case 2:
            nameRegex = @"[A-Za-z ]{3,100}";
            break;
            
        default:
            break;
    }
    
    NSPredicate *nameTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", nameRegex];
    return [nameTest evaluateWithObject:string];
}

+ (BOOL)validateAddress:(NSString *)string withLength:(NSInteger)isLength {
    NSString *nameRegex;
    
    switch (isLength) {
        case 1:
            nameRegex = @"[A-Za-z0-9 ]{3,30}";
            break;
            
        case 2:
            nameRegex = @"[A-Za-z0-9 ]{3,100}";
            break;
            
        default:
            break;
    }
    
    NSPredicate *nameTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", nameRegex];
    return [nameTest evaluateWithObject:string];
}

+ (BOOL)validateEmail:(NSString *)string {
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:string];
}

+ (BOOL)validatePhone:(NSString *)string {
    NSString *phoneRegex = @"[0-9]{0,25}";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", phoneRegex];
    return [phoneTest evaluateWithObject:string];
}

@end
