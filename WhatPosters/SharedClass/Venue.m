//
//  Location.m.m
//  Scorefolio
//
//  Created by Atif Saeed on 14/06/2015.
//  Copyright (c) 2015 XULU Labs. All rights reserved.
//

#import "Venue.h"

@implementation Venue

- (instancetype)initWithAttributes:(NSDictionary *)attributes {
    
    self = [super init];
    if (!self) {
        return nil;
    }
    
    self.identifier = [attributes[@"nid"] intValue];
    self.venueID = [attributes[@"venue id"] intValue];
    

    if (attributes[@"node_title"] == [NSNull null]) {
        //self.name = @"Empty";
    } else {
        self.name = attributes[@"node_title"];
    }
    
    if (attributes[@"address"] == [NSNull null]) {
        //self.address = @"Empty";
    } else {
        self.address = attributes[@"address"];
    }
    
    if (attributes[@"status"] == [NSNull null]) {
        //self.status = @"Empty";
    } else {
        self.status = attributes[@"status"];
    }

    return self;
}

+ (NSArray *)setData:(NSArray *)arrayInfo {
    
    NSMutableArray *venueData = [NSMutableArray array];
    for (NSDictionary *attributes in arrayInfo) {
        Venue *venue = [[Venue alloc] initWithAttributes:attributes];
        [venueData addObject:venue];
    }
    return venueData;
}

/*
{
 "node_title": "DEERLICK PARK",
 "address ": "6821 Braddock Rd., Springfield, VA 22151",
 "nid": "343",
 "status": "Partially Opened"
} */

@end
