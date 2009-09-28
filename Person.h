//
//  Person.h
//  RaiseMan
//
//  Created by John Haro on 8/10/08.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Person : NSObject <NSCoding> {
	NSString *personName;
	float expectedRaise;
}

@property (readwrite, copy) NSString *personName;
@property (readwrite) float expectedRaise;

@end
