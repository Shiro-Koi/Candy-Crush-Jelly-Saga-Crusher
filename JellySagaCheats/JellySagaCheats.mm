#import <Preferences/Preferences.h>

@interface JellySagaCheatsListController: PSListController {
}
@end

@implementation JellySagaCheatsListController
- (id)specifiers {
	if(_specifiers == nil) {
		_specifiers = [[self loadSpecifiersFromPlistName:@"JellySagaCheats" target:self] retain];
	}
	return _specifiers;
}
@end

// vim:ft=objc
