//
//  PreferenceController.h
//  RaiseMan
//
//  Created by John D. Haro on 10/17/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface PreferenceController : NSWindowController {
	IBOutlet NSColorWell *colorWell;
	IBOutlet NSButton *checkbox;
}
-(IBAction)changeBackgroundColor:(id)sender;
-(IBAction)changeNewEmptyDoc:(id)sender;

@end
