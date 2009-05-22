//
//  MyApp.m
//  FBNotif
//
//  Created by Jonathan Speiser on 5/18/09.
//  Copyright 2009 University of Maryland. All rights reserved.
//

#import "MyApp.h"


@implementation MyApp
- (IBAction)sayHello:(id)sender
{
	NSString *message;
	message = @"hello world!";
	
	[textField setStringValue:message];
}
@end
