//
//  Controller.m
//  FBNotif
//
//  Created by Jonathan Speiser on 5/18/09.
//  Copyright 2009 University of Maryland. All rights reserved.
//

#import "Controller.h"


@implementation Controller

- (void)awakeFromNib
{
    NSStatusBar *menuBar = [NSStatusBar systemStatusBar];
    NSStatusItem *bpaMenuStatusItem = [[menuBar statusItemWithLength:NSVariableStatusItemLength] retain];
	
    [bpaMenuStatusItem setTitle: NSLocalizedString(@"Bigpond",@"")];
    [bpaMenuStatusItem setHighlightMode:YES];
}

@end
