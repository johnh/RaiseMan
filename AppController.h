//
//  AppController.h
//  RaiseMan
//
//  Created by John D. Haro on 10/17/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>
@class PreferenceController;

@interface AppController : NSObject {
	PreferenceController *preferenceController;
	
}
-(IBAction)showPreferencePanel:(id)sender;
-(IBAction)showAboutPanel:(id)sender;
-(IBAction)closeAboutPanel:(id)sender;

@end
