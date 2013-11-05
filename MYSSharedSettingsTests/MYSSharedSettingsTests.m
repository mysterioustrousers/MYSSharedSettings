//
//  MYSSharedSettingsTests.m
//  MYSSharedSettingsTests
//
//  Created by Adam Kirk on 11/4/13.
//  Copyright (c) 2013 Mysterious Trousers. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "MYSSharedSettings.h"
#import "TESTSharedSettings.h"


@interface MYSSharedSettingsTests : XCTestCase
@end


@implementation MYSSharedSettingsTests

- (void)testDefualts
{
    long long ll1 = [TESTSharedSettings sharedSettings].longLongProperty;
    long long ll2 = [[[NSUserDefaults standardUserDefaults] objectForKey:@"com.test.longLongProperty"] longLongValue];
    XCTAssertTrue(ll1 == ll2);

    BOOL b1 = [TESTSharedSettings sharedSettings].boolProperty;
    BOOL b2 = [[[NSUserDefaults standardUserDefaults] objectForKey:@"com.test.boolProperty"] boolValue];
    XCTAssertTrue(b1 == b2);

    int i1 = [TESTSharedSettings sharedSettings].integerProperty;
    int i2 = [[[NSUserDefaults standardUserDefaults] objectForKey:@"com.test.integerProperty"] intValue];
    XCTAssertTrue(i1 == i2);

    float f1 = [TESTSharedSettings sharedSettings].floatProperty;
    float f2 = [[[NSUserDefaults standardUserDefaults] objectForKey:@"com.test.floatProperty"] floatValue];
    XCTAssertTrue(f1 == f2);

    float d1 = [TESTSharedSettings sharedSettings].doubleProperty;
    float d2 = [[[NSUserDefaults standardUserDefaults] objectForKey:@"com.test.doubleProperty"] floatValue];
    XCTAssertTrue(d1 == d2);

    NSDate *date1 = [TESTSharedSettings sharedSettings].dateProperty;
    NSDate *date2 = [[NSUserDefaults standardUserDefaults] objectForKey:@"com.test.dateProperty"];
    XCTAssertEqualObjects(date1, date2);

    NSString *string1 = [TESTSharedSettings sharedSettings].stringProperty;
    NSString *string2 = [[NSUserDefaults standardUserDefaults] objectForKey:@"com.test.stringProperty"];
    XCTAssertEqualObjects(string1, string2);

    BOOL cg1 = [TESTSharedSettings sharedSettings].isCustomerGetter;
    BOOL cg2 = [[[NSUserDefaults standardUserDefaults] objectForKey:@"com.test.customGetter"] boolValue];
    XCTAssertTrue(cg1 == cg2);
}

- (void)testSettingAndReadingValues
{
    [TESTSharedSettings sharedSettings].longLongProperty = 23423423;
    long long ll1 = [TESTSharedSettings sharedSettings].longLongProperty;
    long long ll2 = [[[NSUserDefaults standardUserDefaults] objectForKey:@"com.test.longLongProperty"] longLongValue];
    XCTAssertTrue(ll1 == ll2);
    XCTAssertTrue([TESTSharedSettings sharedSettings].longLongProperty == 23423423);

    [TESTSharedSettings sharedSettings].boolProperty = NO;
    BOOL b1 = [TESTSharedSettings sharedSettings].boolProperty;
    BOOL b2 = [[[NSUserDefaults standardUserDefaults] objectForKey:@"com.test.boolProperty"] boolValue];
    XCTAssertTrue(b1 == b2);
    XCTAssertTrue([TESTSharedSettings sharedSettings].boolProperty == NO);

    [TESTSharedSettings sharedSettings].integerProperty = 2;
    int i1 = [TESTSharedSettings sharedSettings].integerProperty;
    int i2 = [[[NSUserDefaults standardUserDefaults] objectForKey:@"com.test.integerProperty"] intValue];
    XCTAssertTrue(i1 == i2);
    XCTAssertTrue([TESTSharedSettings sharedSettings].integerProperty == 2);

    [TESTSharedSettings sharedSettings].floatProperty = 2.2323;
    float f1 = [TESTSharedSettings sharedSettings].floatProperty;
    float f2 = [[[NSUserDefaults standardUserDefaults] objectForKey:@"com.test.floatProperty"] floatValue];
    XCTAssertTrue(f1 == f2);
    XCTAssertEqualWithAccuracy([TESTSharedSettings sharedSettings].floatProperty, 2.2323, 0.001);

    [TESTSharedSettings sharedSettings].doubleProperty = 2.3423423;
    float d1 = [TESTSharedSettings sharedSettings].doubleProperty;
    float d2 = [[[NSUserDefaults standardUserDefaults] objectForKey:@"com.test.doubleProperty"] floatValue];
    XCTAssertTrue(d1 == d2);
    XCTAssertTrue([TESTSharedSettings sharedSettings].doubleProperty == 2.3423423);

    [TESTSharedSettings sharedSettings].dateProperty = [NSDate dateWithTimeIntervalSince1970:30];
    NSDate *date1 = [TESTSharedSettings sharedSettings].dateProperty;
    NSDate *date2 = [[NSUserDefaults standardUserDefaults] objectForKey:@"com.test.dateProperty"];
    XCTAssertEqualObjects(date1, date2);
    XCTAssertEqualObjects([TESTSharedSettings sharedSettings].dateProperty, [NSDate dateWithTimeIntervalSince1970:30]);

    [TESTSharedSettings sharedSettings].stringProperty = @"test";
    NSString *string1 = [TESTSharedSettings sharedSettings].stringProperty;
    NSString *string2 = [[NSUserDefaults standardUserDefaults] objectForKey:@"com.test.stringProperty"];
    XCTAssertEqualObjects(string1, string2);
    XCTAssertEqualObjects([TESTSharedSettings sharedSettings].stringProperty, @"test");

    [TESTSharedSettings sharedSettings].customerGetter = NO;
    BOOL cg1 = [TESTSharedSettings sharedSettings].isCustomerGetter;
    BOOL cg2 = [[[NSUserDefaults standardUserDefaults] objectForKey:@"com.test.customGetter"] boolValue];
    XCTAssertTrue(cg1 == cg2);
    XCTAssertTrue([TESTSharedSettings sharedSettings].isCustomerGetter == NO);
}


@end
