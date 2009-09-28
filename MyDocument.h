//
//  MyDocument.h
//  RaiseMan
//
//  Created by John Haro on 8/10/08.
//  Copyright __MyCompanyName__ 2008 . All rights reserved.
//


#import <Cocoa/Cocoa.h>
@class Person;

@interface MyDocument : NSDocument
{
	NSMutableArray *employees;
	IBOutlet NSTableView *tableView;
	IBOutlet NSArrayController *employeeController;
	
}

- (IBAction)createEmployee:(id)sender;
- (void)setEmployees:(NSMutableArray *)a;
- (void)removeObjectFromEmployeesAtIndex:(int)index;
- (void)insertObject:(Person *)p inEmployeesAtIndex:(int)index;
//not sure
- (void)startObservingPerson:(Person *)person;
- (void)stopObservingPerson:(Person *)person; 

@end
