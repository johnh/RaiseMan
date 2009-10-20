//
//  AppController.m
//  RaiseMan
//
//  Created by John D. Haro on 10/17/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "AppController.h"
#import "PreferenceController.h"


@implementation AppController

-(IBAction)showPreferencePanel:(id)sender {
	//Is preferenceController nil?
	if (!preferenceController) {
		preferenceController = [[PreferenceController alloc] init];
	}
	NSLog(@"showing %@", preferenceController);
	[preferenceController showWindow:self];
}

- (IBAction)showAboutPanel:(id)sender
{
	BOOL successful = [NSBundle loadNibNamed:@"About" owner:self];
	NSLog(@"was successful: %d",successful);
}

- (IBAction)closeAboutPanel:(id)sender 
{
	[aboutPanel close];
	//[sender close];
	
	NSLog(@"About panel closed");
}

//NSApplication delegate method to see if we open a blank new document on start
- (BOOL)applicationShouldOpenUntitledFile:(NSApplication *)sender
{
	NSLog(@"applicationShouldOpenUntitledFile:");
	return [[NSUserDefaults standardUserDefaults] boolForKey:BNREmptyDocKey];
}


+ (void) initialize
{
	//Create a dictionary
	NSMutableDictionary *defaultValues = [NSMutableDictionary dictionary];
	
	//Archive the color object
	NSData *colorAsData = [NSKeyedArchiver archivedDataWithRootObject:[NSColor yellowColor]];
	
	//Put defaults in the dictionary
	[defaultValues setObject:colorAsData forKey:BNRTableBgColorKey];
	[defaultValues setObject:[NSNumber numberWithBool:YES] forKey:BNREmptyDocKey];
	
	//register the dictionary of defaults
	[[NSUserDefaults standardUserDefaults] registerDefaults:defaultValues];
	
	NSLog(@"regisered defaults : %@", defaultValues);

}

@end
