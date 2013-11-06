//
//  MYSSharedSettings.m
//  MYSSharedSettings
//
//  Created by Adam Kirk on 11/4/13.
//  Copyright (c) 2013 Mysterious Trousers. All rights reserved.
//

#import "MYSSharedSettings.h"
#import <MYSRuntime.h>


@interface MYSSharedSettings ()
@property (nonatomic, strong) NSMutableSet *changedProperties;
@end


@implementation MYSSharedSettings

+ (instancetype)sharedSettings
{
    static id settings = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        settings = [[self class] new];
    });
    return settings;
}

- (id)init
{
    self = [super init];
    if (self) {
        [self setupMethods];
        [self setupNotifications];
        [self setupDefaults];
        self.changedProperties = [NSMutableSet new];
        [[NSUbiquitousKeyValueStore defaultStore] synchronize];
    }
    return self;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}




#pragma mark - Public

- (NSString *)keyForPropertyName:(NSString *)propertyName
{
    return [NSString stringWithFormat:@"MYSSharedSettings.%@", propertyName];
}

- (NSDictionary *)defaults
{
    return nil;
}

- (void)pushLocalToiCloud
{
    @synchronized(self) {
        NSDictionary *localDefaults = [[NSUserDefaults standardUserDefaults] dictionaryRepresentation];
        NSString *prefix = [self keyForPropertyName:@""];
        for (NSString *key in [localDefaults allKeys]) {
            if ([key hasPrefix:prefix]) {
                id object = [[NSUserDefaults standardUserDefaults] objectForKey:key];
                [[NSUbiquitousKeyValueStore defaultStore] setObject:object forKey:key];
            }
        }
        [[NSUbiquitousKeyValueStore defaultStore] synchronize];
    }
}

- (NSArray *)changedPropertyNames
{
    NSArray *array = [self.changedProperties copy];
    [self.changedProperties removeAllObjects];
    return array;
}




#pragma mark (properties)

- (void)setSyncSettingsWithiCloud:(BOOL)syncSettingsWithiCloud
{
    @synchronized(self) {
        NSString *key = [self keyForPropertyName:@"syncSettingsWithiCloud"];
        [[NSUserDefaults standardUserDefaults] setBool:syncSettingsWithiCloud forKey:key];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}

- (BOOL)syncSettingsWithiCloud
{
    @synchronized(self) {
        NSString *key = [self keyForPropertyName:@"syncSettingsWithiCloud"];
        return [[NSUserDefaults standardUserDefaults] boolForKey:key];
    }
}




#pragma mark - Notification

- (void)ubiquitousStoreDidChange:(NSNotification *)n
{
    if (self.syncSettingsWithiCloud) {
        dispatch_async(dispatch_get_main_queue(), ^{
            BOOL containedPropertyChanges = NO;
            @synchronized(self) {
                NSString *prefix = [self keyForPropertyName:@""];
                NSUbiquitousKeyValueStore *store = [NSUbiquitousKeyValueStore defaultStore];
                NSArray *keys = [n userInfo][NSUbiquitousKeyValueStoreChangedKeysKey];
                for (NSString *changedKey in keys) {
                    if ([changedKey hasPrefix:prefix]) {
                        containedPropertyChanges = YES;
                        id obj = [store objectForKey:changedKey];
                        [[NSUserDefaults standardUserDefaults] setObject:obj forKey:changedKey];
                        [[NSUserDefaults standardUserDefaults] synchronize];
                        NSString *propertyName = [changedKey stringByReplacingOccurrencesOfString:prefix
                                                                                       withString:@""
                                                                                          options:0
                                                                                            range:NSMakeRange(0, [prefix length])];
                        [self.changedProperties addObject:propertyName];

                    }
                }
            }
            if (containedPropertyChanges) {
                [[NSNotificationCenter defaultCenter] postNotificationName:MYSSharedSettingsChangedNotification
                                                                    object:self];
            }
        });
    }
}




#pragma mark - Private

#pragma mark (setup)

- (void)setupMethods
{
    MYSClass *mysClass = [[MYSClass alloc] initWithClass:[self class]];

    for (MYSProperty *property in mysClass.properties) {

        if (!property.isDynamic) continue;

        id getterBlock = nil;
        id setterBlock = nil;

        switch (property.type) {
            case MYSTypeShort:
            case MYSTypeLong:
            case MYSTypeLongLong:
            case MYSTypeUnsignedChar:
            case MYSTypeUnsignedShort:
            case MYSTypeUnsignedInt:
            case MYSTypeUnsignedLong:
            case MYSTypeUnsignedLongLong:
            {
                NSString *propertyName = [property.name copy];

                getterBlock = ^long long(id self) {
                    @synchronized(self) {
                        return [[self settingsObjectForPropertyName:propertyName] longLongValue];
                    }
                };

                setterBlock = ^(id self, long long value) {
                    @synchronized(self) {
                        [self setSettingsObject:@(value) forPropertyName:propertyName];
                    }
                };
            }
                break;

            case MYSTypeBool:
            {
                NSString *propertyName = [property.name copy];

                getterBlock = ^BOOL(id self) {
                    @synchronized(self) {
                        return [[self settingsObjectForPropertyName:propertyName] boolValue];
                    }
                };

                setterBlock = ^(id self, BOOL value) {
                    @synchronized(self) {
                        [self setSettingsObject:@(value) forPropertyName:propertyName];
                    }
                };
            }

            case MYSTypeChar:
            {
                NSString *propertyName = [property.name copy];

                getterBlock = ^char(id self) {
                    @synchronized(self) {
                        return [[self settingsObjectForPropertyName:propertyName] charValue];
                    }
                };

                setterBlock = ^(id self, char value) {
                    @synchronized(self) {
                        [self setSettingsObject:@(value) forPropertyName:propertyName];
                    }
                };
            }
                break;

            case MYSTypeInt:
            {
                NSString *propertyName = [property.name copy];

                getterBlock = ^int(id self) {
                    @synchronized(self) {
                        return [[self settingsObjectForPropertyName:propertyName] intValue];
                    }
                };

                setterBlock = ^(id self, int value) {
                    @synchronized(self) {
                        [self setSettingsObject:@(value) forPropertyName:propertyName];
                    }
                };
            }
                break;

            case MYSTypeFloat:
            {
                NSString *propertyName = [property.name copy];

                getterBlock = ^float(id self) {
                    @synchronized(self) {
                        return [[self settingsObjectForPropertyName:propertyName] floatValue];
                    }
                };

                setterBlock = ^(id self, float value) {
                    @synchronized(self) {
                        [self setSettingsObject:@(value) forPropertyName:propertyName];
                    }
                };
            }
                break;

            case MYSTypeDouble:
            {
                NSString *propertyName = [property.name copy];

                getterBlock = ^double(id self) {
                    @synchronized(self) {
                        return [[self settingsObjectForPropertyName:propertyName] doubleValue];
                    }
                };

                setterBlock = ^(id self, double value) {
                    @synchronized(self) {
                        [self setSettingsObject:@(value) forPropertyName:propertyName];
                    }
                };
            }
                break;

            case MYSTypeObject:
            {
                NSString *propertyName = [property.name copy];

                getterBlock = ^id(id self) {
                    @synchronized(self) {
                        return [self settingsObjectForPropertyName:propertyName];
                    }
                };

                setterBlock = ^(id self, id value) {
                    @synchronized(self) {
                        [self setSettingsObject:value forPropertyName:propertyName];
                    }
                };
            }
                break;

            default:
                [NSException raise:NSInternalInconsistencyException
                            format:@"Unsupported type of property \"%@\" in class %@", property.name, self];
                break;
        }
        
        MYSMethod *getter = [[MYSMethod alloc] initWithName:property.getter implementationBlock:getterBlock];
        [mysClass addMethod:getter];
        
        MYSMethod *setter = [[MYSMethod alloc] initWithName:property.setter implementationBlock:setterBlock];
        [mysClass addMethod:setter];
    }
}

- (void)setupNotifications
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(ubiquitousStoreDidChange:)
                                                 name:NSUbiquitousKeyValueStoreDidChangeExternallyNotification
                                               object:[NSUbiquitousKeyValueStore defaultStore]];
}

- (void)setupDefaults
{
    @synchronized(self) {
        NSDictionary *defaultsDict = [self defaults];
        NSMutableDictionary *defaults = [NSMutableDictionary new];
        for (NSString *propertyName in [defaultsDict allKeys]) {
            id object = defaultsDict[propertyName];
            if (object) {
                NSString *key   = [self keyForPropertyName:propertyName];
                defaults[key]   = object;
            }
        }
        NSString *iCloudSyncKey = [self keyForPropertyName:@"syncSettingsWithiCloud"];
        defaults[iCloudSyncKey] = @YES;
        [[NSUserDefaults standardUserDefaults] registerDefaults:defaults];
    }
}


#pragma mark (setting values)

- (id)settingsObjectForPropertyName:(NSString *)propertyName
{
    @synchronized(self) {
        NSString *key = [self keyForPropertyName:propertyName];

        id object = nil;

        if (self.syncSettingsWithiCloud) {
            [[NSUbiquitousKeyValueStore defaultStore] objectForKey:key];
        }

        if (!object) {
            object = [[NSUserDefaults standardUserDefaults] objectForKey:key];
        }
        return object;
    }
}

- (void)setSettingsObject:(id)object forPropertyName:(NSString *)propertyName
{
    @synchronized(self) {
        [self.changedProperties addObject:propertyName];
        NSString *key = [self keyForPropertyName:propertyName];
        if (self.syncSettingsWithiCloud && ![propertyName hasPrefix:@"local"]) {
            [[NSUbiquitousKeyValueStore defaultStore] setObject:object forKey:key];
            [[NSUbiquitousKeyValueStore defaultStore] synchronize];
        }
        [[NSUserDefaults standardUserDefaults] setObject:object forKey:key];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}


@end




NSString *const MYSSharedSettingsChangedNotification = @"MYSSharedSettingsChangedNotification";
