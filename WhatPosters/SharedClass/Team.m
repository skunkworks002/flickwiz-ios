//
//  Team.m
//  SF1
//
//  Created by Qazi on 11/09/2015.
//  Copyright (c) 2015 XULU Labs. All rights reserved.
//

#import "Team.h"

@implementation Team
- (instancetype)initWithAttributes:(NSDictionary *)attributes {
    
    self = [super init];
    if (!self) {
        return nil;
    }
    
    self.identifier = [attributes[@"nid"] intValue];
    
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

+ (NSArray *)setDataTeam:(NSArray *)arrayInfo{
    
    NSMutableArray *teamData = [NSMutableArray array];
    for (NSDictionary *attributes in arrayInfo) {
        
        //Venue *venue = [[Venue alloc] initWithAttributes:attributes];
        [teamData addObject:attributes];
        //[venueData addObject:venue];
    }
    return teamData;
}

@end
