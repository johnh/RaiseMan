//
//  PreferenceController.m
//  RaiseMan
//
//  Created by John D. Haro on 10/17/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "PreferenceController.h"
NSString * const BNRTableBgColorKey = @"TableBackgroundColor";
NSString * const BNREmptyDocKey = @"EmptyDocumentFlag";
NSString * const BNRColorChangedNotification = @"ColorChangedNotification";

@implementation PreferenceController

- (id) init
{
	if (![super initWithWindowNibName:@"Preferences"])
		return nil;
	
	return self;
}

// 
// set table background color preference
- (NSColor *)tableBgColor 
{
	NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
	//remember color data 'archived' for plist storage
	NSData *colorAsData = [defaults objectForKey:BNRTableBgColorKey];
	return [NSKeyedUnarchiver unarchiveObjectWithData:colorAsData]; //unarchive and return
	
}

- (BOOL)emptyDoc 
{
	NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
	return [defaults boolForKey:BNREmptyDocKey];
}

- (void)windowDidLoad 
{
	//set controls with loaded preferences
	[colorWell setColor:[self tableBgColor]];
	[checkbox setState:[self emptyDoc]];	
}

-(IBAction)changeBackgroundColor:(id)sender
{
	NSColor *color = [colorWell color];
	NSData *colorAsData = [NSKeyedArchiver archivedDataWithRootObject:color];
	NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
	[defaults setObject:colorAsData forKey:BNRTableBgColorKey];
	
	NSLog(@"changed color to %@ and set preferences", color);
	
	NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
	NSLog(@"Sending notification of background color change");
	NSDictionary *d = [NSDictionary dictionaryWithObject:color forKey:@"color"];
	[nc postNotificationName:BNRColorChangedNotification object:self userInfo:d];

}

-(IBAction)changeNewEmptyDoc:(id)sender
{
	int state = [checkbox state];
	NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
	[defaults setBool:state forKey:BNREmptyDocKey];
	NSLog(@"checkbox state changed to %d", state);
}


@end
