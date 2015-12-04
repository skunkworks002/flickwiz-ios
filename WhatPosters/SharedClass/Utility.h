//
//  Utility.h
//  SF1
//
//  Created by Qazi on 09/09/2015.
//  Copyright (c) 2015 XULU Labs. All rights reserved.
//

#import <Foundation/Foundation.h>
@protocol Utilitydeleget  <NSObject>
@end

@interface Utility : NSObject

+ (BOOL)validateString:(NSString *)string withLenth:(NSInteger)isLength;
+ (BOOL)validateUsername:(NSString *)string withLength:(NSInteger)isLength;
+ (BOOL)validateAddress:(NSString *)string withLength:(NSInteger)isLength;
+ (BOOL)validateEmail:(NSString *)string;
+ (BOOL)validatePhone:(NSString *)string;

+ (Utility *) sharedManager;
@property (nonatomic, strong) NSArray *venueData;
@property (nonatomic, strong) NSArray *facilityData;
@property (nonatomic, strong) NSArray *openentData;
@property (nonatomic, strong) NSArray *teamData;

- (void)setVenueArray:(NSArray *)array;
- (NSArray *)getVenueArray;
- (void)setFacilityArray:(NSArray *)array;
- (NSArray *)getFacilityArray;
- (void)setOpenentArray:(NSArray *)array;
- (NSArray *)getOpenentArray;
- (void)setTeamArray:(NSArray *)array;
- (NSArray *)getTeamArray;

@property (assign, nonatomic) id<Utilitydeleget> delegateUtlity;

@end
