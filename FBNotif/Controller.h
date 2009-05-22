//
//  Controller.h
//  FBNotif
//
//  Created by Jonathan Speiser on 5/18/09.
//  Copyright 2009 University of Maryland. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface Controller : NSObject {

    /* Our outlets which allow us to access the interface */
    IBOutlet NSMenu *statusMenu;
    
    /* The other stuff :P */
    NSStatusItem        *statusItem;
    NSImage             *statusImage;
    NSImage             *statusHighlightImage;
}

/* Our IBAction which will call the helloWorld method when our connected Menu Item is pressed */
-(IBAction)helloWorld:(id)sender;

@end

@end
