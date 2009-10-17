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
	[sender close];
}


@end
