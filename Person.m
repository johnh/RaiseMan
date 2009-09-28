//
//  Person.m
//  RaiseMan
//
//  Created by John Haro on 8/10/08.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import "Person.h"


@implementation Person

- (id)init {
	[super init];
	expectedRaise = 5.0;
	personName = @"New Person";
	return self;
	
}

- (void)dealloc {
	[personName release];
	[super dealloc];
	
}

- (void)setNilValueForKey:(NSString *)key
{
	if ([key isEqual:@"expectedRaise"]) {
		[self setExpectedRaise:0.0]; //cant handle NIL numbers automagically, though a formatter MAy be able to
	} else {
		[super setNilValueForKey:key]; //can handle everything else automagically
	} 

}

- (void)encodeWithCoder:(NSCoder *)coder
{
	[coder encodeObject:personName forKey:@"personName"];
	[coder encodeFloat:expectedRaise forKey:@"expectedRaise"];
}

- (id)initWithCoder:(NSCoder *)coder
{
	[super init];
	personName = [[coder decodeObjectForKey:@"personName"] retain];
	expectedRaise = [coder decodeFloatForKey:@"expectedRaise"];
	return self;
}

@synthesize personName;
@synthesize expectedRaise;

@end
