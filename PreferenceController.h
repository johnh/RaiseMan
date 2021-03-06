//
//  PreferenceController.h
//  RaiseMan
//
//  Created by John D. Haro on 10/17/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>
extern NSString * const BNRTableBgColorKey;
extern NSString * const BNREmptyDocKey;
extern NSString * const BNRColorChangedNotification;


@interface PreferenceController : NSWindowController {
	IBOutlet NSColorWell *colorWell;
	IBOutlet NSButton *checkbox;
}
-(IBAction)changeBackgroundColor:(id)sender;
-(IBAction)changeNewEmptyDoc:(id)sender;

-(NSColor *) tableBgColor;
-(BOOL) emptyDoc;


@end
