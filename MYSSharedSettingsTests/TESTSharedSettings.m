//
//  TESTSharedSettings.m
//  MYSSharedSettings
//
//  Created by Adam Kirk on 11/4/13.
//  Copyright (c) 2013 Mysterious Trousers. All rights reserved.
//

#import "TESTSharedSettings.h"

@implementation TESTSharedSettings

@dynamic longLongProperty;
@dynamic boolProperty;
@dynamic integerProperty;
@dynamic floatProperty;
@dynamic doubleProperty;
@dynamic dateProperty;
@dynamic stringProperty;
@dynamic customerGetter;

- (NSString *)keyForPropertyName:(NSString *)propertyName
{
    return [NSString stringWithFormat:@"com.test.%@", propertyName];
}

- (NSDictionary *)defaults
{
    return @{
             @"longLongProperty"    : @(323239223),
             @"boolProperty"        : @(YES),
             @"integerProperty"     : @(5),
             @"floatProperty"       : @(23.23),
             @"doubleProperty"      : @(2.2342343232),
             @"dateProperty"        : [NSDate dateWithTimeIntervalSince1970:30],
             @"stringProperty"      : @"string",
             @"customerGetter"      : @(YES)
             };
}

@end
