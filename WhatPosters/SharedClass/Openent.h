//
//  Openent.h
//  SF1
//
//  Created by Qazi on 11/09/2015.
//  Copyright (c) 2015 XULU Labs. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Openent : NSObject
@property (nonatomic) NSUInteger identifier;
@property (nonatomic, strong) NSString *title;

- (instancetype)initWithAttributes:(NSDictionary *)attributes;
+ (NSArray *)setDataOpenent:(NSArray *)arrayInfo;

@end
