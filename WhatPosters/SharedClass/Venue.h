//
//  Venue.h
//  Scorefolio
//
//  Created by Atif Saeed on 14/06/2015.
//  Copyright (c) 2015 XULU Labs. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Venue : NSObject

@property (nonatomic) NSUInteger identifier;
@property (nonatomic) NSUInteger venueID;

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *address;
@property (nonatomic, strong) NSString *status;

- (instancetype)initWithAttributes:(NSDictionary *)attributes;
+ (NSArray *)setData:(NSArray *)arrayInfo;

@end

