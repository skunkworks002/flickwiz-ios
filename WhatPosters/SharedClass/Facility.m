//
//  Facility.m
//  SF1
//
//  Created by Qazi on 11/09/2015.
//  Copyright (c) 2015 XULU Labs. All rights reserved.
//

#import "Facility.h"

@implementation Facility
- (instancetype)initWithAttributes:(NSDictionary *)attributes {
    
    self = [super init];
    if (!self) {
        return nil;
    }
    
    self.identifier = [attributes[@"nid"] intValue];
    self.venueID = [attributes[@"venue id"] intValue];

    if (attributes[@"node_title"] == [NSNull null]) {
        self.title = @"";
    } else {
        self.title = attributes[@"node_title"];
    }
    
    return self;
}

+ (NSArray *)setDataFacility:(NSArray *)arrayInfo{
    
    NSMutableArray *facilityData = [NSMutableArray array];
    for (NSDictionary *attributes in arrayInfo) {
        //Facility *facility = [[Facility alloc] initWithAttributes:attributes];
        [facilityData addObject:attributes];
    }
    return facilityData;
}

@end
