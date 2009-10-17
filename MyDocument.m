//
//  MyDocument.m
//  RaiseMan
//
//  Created by John Haro on 8/10/08.
//  Copyright __MyCompanyName__ 2008 . All rights reserved.
//

#import "MyDocument.h"
#import "Person.h"

@implementation MyDocument

- (id)init
{
    self = [super init];
    if (self) {
		employees = [[NSMutableArray alloc] init];
    }
    return self;
}

- (NSString *)windowNibName
{
    // Override returning the nib file name of the document
    // If you need to use a subclass of NSWindowController or if your document supports multiple NSWindowControllers, you should remove this method and override -makeWindowControllers instead.
    return @"MyDocument";
}

- (void)windowControllerDidLoadNib:(NSWindowController *) aController
{
    [super windowControllerDidLoadNib:aController];
    // Add any code here that needs to be executed once the windowController has loaded the document's window.
}

//************************
- (NSData *)dataOfType:(NSString *)typeName error:(NSError **)outError
{    	
	//END EDITING
	[[tableView window] endEditingFor:nil];
	
	//Create an NSData object from the employees array
	return [NSKeyedArchiver archivedDataWithRootObject:employees];
}


- (BOOL)readFromData:(NSData *)data ofType:(NSString *)typeName error:(NSError **)outError
{
	NSLog(@"About to read data of type %@", typeName);
	NSMutableArray *newArray = nil;
	@try {
		newArray = [NSKeyedUnarchiver unarchiveObjectWithData:data];
	}
	@catch (NSException * e) {
		if (outError) {
			NSDictionary *d = [NSDictionary dictionaryWithObject:@"The data is corrupted." forKey:NSLocalizedFailureReasonErrorKey];
			*outError = [NSError errorWithDomain:NSOSStatusErrorDomain code:unimpErr userInfo:d];
		}
		return NO;
	}
	[self setEmployees:newArray];
	return YES;

}

///*******mine*****
- (void)setEmployees:(NSMutableArray *)a 
{
	// this is an unusual setter method.  We are going to add a lot of smarts to it in the next chapter :)
	if (a == employees)
		return;
	
	for (Person *person in employees) {
		[self stopObservingPerson:person];
	}
	
	[a retain];
	[employees release];
	employees = a;
	
	for (Person *person in employees) {
		[self startObservingPerson:person];
	}
	
}

- (void)dealloc {
	[self setEmployees:nil];
	[super dealloc];
}

//******** insert and remove methods with undo support
- (void)removeObjectFromEmployeesAtIndex:(int)index{

	Person *p = [employees objectAtIndex:index];
	NSLog(@"removing %@ from %@", p, employees);
	NSUndoManager *undo = [self undoManager];
	[[undo prepareWithInvocationTarget:self] insertObject:p inEmployeesAtIndex:index];
	if (![undo isUndoing]) {
		[undo setActionName:@"Remove Person"];
	}
	[self stopObservingPerson:p]; // remove observer (for text undo)
	[employees removeObjectAtIndex:index];
	
}
- (void)insertObject:(Person *)p inEmployeesAtIndex:(int)index {
	NSLog(@"adding %@ to %@", p, employees);
	//add the inverse of this operation to undo stack
	NSUndoManager *undo = [self undoManager];
	[[undo prepareWithInvocationTarget:self] removeObjectFromEmployeesAtIndex:index];
	if (![undo isUndoing]) {
		[undo setActionName:@"Insert Person"];
	}
	// Add the person to the array
	[self startObservingPerson:p]; //add observer (for text undo)
	[employees insertObject:p atIndex:index];
}

//******* text change undo support - observers

- (void)startObservingPerson:(Person *)person
{
	[person addObserver:self forKeyPath:@"personName" options:NSKeyValueObservingOptionOld context:NULL];
	[person addObserver:self forKeyPath:@"expectedRaise" options:NSKeyValueObservingOptionOld context:NULL];

}

- (void)stopObservingPerson:(Person *)person 
{
	[person removeObserver:self forKeyPath:@"personName"];
	[person removeObserver:self forKeyPath:@"expectedRaise"];
	
}

//***** text change undo support

- (void)changeKeyPath:(NSString *)keyPath ofObject:(id)obj toValue:(id)newValue
{
	//setValue:forKeyPath: will cause the key-value observing method to be called
	// which takes care of the undo stuff
	[obj setValue:newValue forKeyPath:keyPath];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change
					   context:(void *)context 
{
	NSUndoManager *undo = [self undoManager];
	id oldValue = [change objectForKey:NSKeyValueChangeOldKey];
	//NSNull objects are used to represent nil in a dictionary
	if (oldValue == [NSNull null]) {
		oldValue = nil;
	}
	NSLog(@"oldValue = %@", oldValue);
	[[undo prepareWithInvocationTarget:self] changeKeyPath:keyPath ofObject:object toValue:oldValue];
	[undo setActionName:@"Edit"];
	
}

/************************
 * IBAction - create a new employee record
 *
 ************************/
- (IBAction)createEmployee:(id)sender {
	
	NSWindow *w = [tableView window];
	
	//try to end any editing that is taking place already
	BOOL editingEnded = [w makeFirstResponder:w];
	if (!editingEnded) {
		NSLog(@"Unable to end editing");
	}
	NSUndoManager *undo = [self undoManager];
	
	// has an edit occurred already in this event?
	if ([undo groupingLevel]) {
			//Close the last group
		[undo endUndoGrouping];
		// open new group
		[undo beginUndoGrouping];
	}
	//crejohate the object
	Person *p = [employeeController newObject];
	
	//add it to the content array of 'employeeController'
	[employeeController addObject:p];
	[p release];
	
	//RE-sort (in case user has sorted a column
	[employeeController rearrangeObjects];
	
	// Get the sorted array
	NSArray *a = [employeeController arrangedObjects];
	
	// Find the object just added
	int row = [a indexOfObjectIdenticalTo:p];
	
	// Begin the edit in the first column
	[tableView editColumn:0 row:row withEvent:nil select:YES];
	
}

@end
