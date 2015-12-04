//
//  Team.h
//  SF1
//
//  Created by Qazi on 11/09/2015.
//  Copyright (c) 2015 XULU Labs. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Team : NSObject
@property (nonatomic) NSUInteger identifier;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *address;
@property (nonatomic, strong) NSString *status;

- (instancetype)initWithAttributes:(NSDictionary *)attributes;
+ (NSArray *)setDataTeam:(NSArray *)arrayInfo;
@end
