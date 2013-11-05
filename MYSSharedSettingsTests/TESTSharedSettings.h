//
//  TESTSharedSettings.h
//  MYSSharedSettings
//
//  Created by Adam Kirk on 11/4/13.
//  Copyright (c) 2013 Mysterious Trousers. All rights reserved.
//

#import "MYSSharedSettings.h"

@interface TESTSharedSettings : MYSSharedSettings

@property (nonatomic, assign                         ) long long longLongProperty;
@property (nonatomic, assign                         ) BOOL      boolProperty;
@property (nonatomic, assign                         ) NSInteger integerProperty;
@property (nonatomic, assign                         ) float     floatProperty;
@property (nonatomic, assign                         ) double    doubleProperty;
@property (nonatomic, retain                         ) NSDate    *dateProperty;
@property (nonatomic, copy                           ) NSString  *stringProperty;
@property (nonatomic, assign, getter=isCustomerGetter) BOOL      customerGetter;

@end
