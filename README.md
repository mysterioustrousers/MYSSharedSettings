MYSSharedSettings
=================

Access local settings and settings shared via iCloud with properties.


### Installation

Add this to your Podfile:

    pod 'MYSSharedSettings'


### Usage

1. Subclass `MYSSharedSettings`.
2. Define properties in `.h` file.
3. Add `@dynamic` statement for each property in `.m` file.
4. Set `[YourSubclass sharedSettings].syncSettingsWithiCloud = YES; // (or NO)` somewhere in your code.


#### Example

    // CVSharedSettings.h

    @interface CVSharedSettings : MYSSharedSettings
    @property (nonatomic, assign) BOOL remindersEnabled;
    @end

    // CVSharedSettings.m
	@implementation CVSharedSettings
	@dynamic remindersEnabled;
	@end

Then you read and set the settings properties like normal:

	#import "CVSharedSettings.h"
	
	[CVSharedSettings sharedSettings].remindersEnabled = YES;
	
	if ([CVSharedSettings sharedSettings].remindersEnabled) {
		// ... whatever happens when reminders are enabled
	}


#### Providing Defaults

You can override the `defaults` method to provide defaults for `NSUserDefaults`:

	- (NSDictionary *)defaults
	{
    	return @{
             @"remindersEnabled"                    : @YES,
             @"timezoneSupportEnabled"              : @NO,
             @"showDurationOnReadOnlyEvents"        : @NO,
             @"localRootTableViewMode"              : @(CVRootTableViewModeAgenda),
             @"hiddenEventCalendarIdentifiers"      : @[],
             @"customCalendarColors"                : @{},
             @"defaultEventAlarms"                  : @[@(MTDateConstantSecondsInMinute * 15)],
             @"defaultAllDayEventAlarms"            : @[@(MTDateConstantSecondsInHour * 6)],
             @"defaultEventReminder"                : @[@(MTDateConstantSecondsInMinute * 15)],
             @"defaultAllDayReminderAlarms"         : @[@(MTDateConstantSecondsInHour * 6)]
             };
	}
	

#### Notifications

Listen for `MYSSharedSettingsChangedNotification` to be informed when remotely changed settings arrive.


#### Transforming Keys

Override `- (NSString *)keyForPropertyName:(NSString *)propertyName` to transform the property name into the string that will
be used as the key when storing the value in `NSUserDefaults` and `NSUbiquitousKeyValueStore`.


#### Excluding Properties From Sync

If you have iCloud syncing enabled but don't want a certain property to be synced, prefix it with `local` and MYSSharedSettings will only
store it in NSUSerDefaults. (e.g. `localViewMode`)


#### Pushing Local Settings to iCloud

Call `- (void)pushLocalToiCloud` to overwrite any settings currently in iCloud with the local settings in `NSUserDefaults`.
