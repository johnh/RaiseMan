//
//  PreferenceController.m
//  RaiseMan
//
//  Created by John D. Haro on 10/17/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "PreferenceController.h"


@implementation PreferenceController

- (id) init
{
	if (![super initWithWindowNibName:@"Preferences"])
		return nil;
	
	return self;
}

- (void)windowDidLoad
{
	NSLog(@"Nib file is loaded");
	
}

-(IBAction)changeBackgroundColor:(id)sender
{
	NSColor *color = [colorWell color];
	NSLog(@"changed color to %@", color);

}

-(IBAction)changeNewEmptyDoc:(id)sender
{
	int state = [checkbox state];
	NSLog(@"checkbox state changed to %d", state);
}

		
		

@end
