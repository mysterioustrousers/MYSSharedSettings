//
//  MYSSharedSettings.h
//  MYSSharedSettings
//
//  Created by Adam Kirk on 11/4/13.
//  Copyright (c) 2013 Mysterious Trousers. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  This class allows you to dynamically add properties that are synced over iCloud using `NSUbiquitousKeyValueStore` if
 *  enabled. It is thread-safe. Define properties on this class and then declare them as `@dynamic` in the implementation
 *  file and `MYSSharedSettings` will do the rest. If `syncSettingsWithiCloud` is YES, all values set on the properties
 *  will be saved to `NSUserDefaults` and `NSUbiquitousKeyValueStore`. Otherwise, values will just be saved to
 *  `NSUserDefaults`. If you would like to exclude a property from being synced automatically, prefix it with `local`.
 */
@interface MYSSharedSettings : NSObject

/**
 *  If YES, this will attempt to save and read all property values to NSUbiquitousKeyValueStore in addition to
 *  NSUserDefaults. If a value for the same key exists in both NSUbiquitousKeyValueStore and NSUserDefaults, the value
 *  in NSUserDefaults is over-written. If a value for a key exists in NSUserDefaults but not in NSUbiquitousKeyValueStore
 *  then the value is added for that key in NSUbiquitousKeyValueStore.
 */
@property (nonatomic, assign) BOOL syncSettingsWithiCloud;

/**
 *  The shared instance that you should use with your subclass.
 */
+ (instancetype)sharedSettings;

/**
 *  Override to customize how a property name is transformed into a key for storing the property's value. If you are
 *  using NSUbiquitousKeyValueStore for other things, appending a prefix is *highly* recommended. When the 
 *  NSUbiquitousKeyValueStore changed notifications come in, it uses this prefix to avoid adding non-settings key-value
 *  pairs to NSUserDefaults.
 *
 *  @param propertyName The string of the dynamic property you've added.
 *
 *  @return Returns `propertyName` prefixed with `MYSSharedSettings.propertyName` unless
 *          overriden by your subclass.
 */
- (NSString *)keyForPropertyName:(NSString *)propertyName;

/**
 *  Override and return a dictionary of defaults. The keys should be the string of the property name you want to
 *  provide a default value for. The key should match the property name exactly.
 *
 *  @return A dictionary that contains the default values for the properties of your subclass. Returns `nil` by default.
 */
- (NSDictionary *)defaults;

/**
 *  This over-writes any values with the same (prefixed) keys in NSUbiquitousKeyValueStore with the values 
 *  in NSUserDefaults. You might call this after enabling `syncSettingsWithiCloud`.
 */
- (void)pushLocalToiCloud;

/**
 *  An array of property names that have changed since you last called this method (or first used the shared settings
 *  instance.
 */
- (NSArray *)changedPropertyNames;


@end



/**
 *  This notification is posted when shared settings changes come in from iCloud.
 */
extern NSString *const MYSSharedSettingsChangedNotification;

