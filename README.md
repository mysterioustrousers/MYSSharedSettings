MYSSharedSettings
=================

Access local settings and settings shared via iCloud with properties.


### Installation

Add this to your Podfile:

    pod 'MYSSharedSettings'


### Usage

1. Subclass `MYSSharedSettings`
2. Define properties.














#### Excluding Properties From Sync

If you have iCloud syncing enabled but don't want a certain property to be synced, prefix it with `local` and MYSSharedSettings will only
store it in NSUSerDefaults. (e.g. `localViewMode`)





