#import "AppController.h"

/* Based off an example from http://files.semaja2.net/NSStatusItem%20-%20ObjC.html#TOC6944 */

@implementation AppController

- (void) checkFacebook:(id) timer {
	NSLog(@"Checking facebook....");
	if (![facebookConnection userLoggedIn]) {
		NSLog(@"Not logged in");
		return;
	}
	NSMutableDictionary *parameters = [[NSMutableDictionary alloc] init];
	MKFacebookRequest *request = [MKFacebookRequest requestUsingFacebookConnection:facebookConnection delegate:self];
	
	//set up parameters for request
	[parameters setValue:@"notifications.get" forKey:@"method"];
	[parameters setValue:[facebookConnection uid] forKey:@"uid"];
	
	//add parameters to request
	[request setParameters:parameters];
	
	//send the request
	[request sendRequest];
	
	[parameters release];
}

-(void)facebookResponseReceived:(NSXMLDocument *)xml
{
	NSDictionary *dict = [[xml rootElement] dictionaryFromXMLElement];
	NSArray *freqs =  [dict objectForKey:@"friend_requests"];
	NSDictionary *msgs =  [dict objectForKey:@"messages"];
	NSString *unread = [msgs objectForKey:@"unread"];
		
	int friendreq_count = [freqs count];
	int message_count = [unread	intValue];
	
	NSMutableString *message_str = @"";
	if (message_count == 1)
		message_str = [NSString stringWithFormat: @"%d Message", message_count];
	else if (message_count > 1)
		message_str = [NSString stringWithFormat: @"%d Messages", message_count];
	
	NSMutableString *friend_str = @"";
	if (friendreq_count == 1)
		friend_str = [NSString stringWithFormat: @"%d Friend Request", friendreq_count];
	else if (friendreq_count > 1)
		friend_str = [NSString stringWithFormat: @"%d Friend Requests", friendreq_count];
	
	NSMenuItem *item = [[[statusItem menu] itemArray] objectAtIndex:0];
	NSString *title_str;
	if (message_count > 0 && friendreq_count > 0)
		title_str = [message_str stringByAppendingFormat:@"- %@", friend_str];
	else if (message_count == 0)
		title_str = friend_str;
	else if (friendreq_count == 0)
		title_str = message_str;
	else if (friendreq_count == 0 && message_count == 0)
		title_str = @"No new notifications";
	
	[item setTitle:title_str];
	
	int total = [freqs count] + [unread intValue];
	if (total <= 0)
		[statusItem setTitle:@""];
	else
		[statusItem setTitle:[NSString stringWithFormat:@"%d", total]];

}

-(void)facebookErrorResponseReceived:(NSXMLDocument *)xml {
	NSLog(@"FB ERROR");
}

-(void)userLoginSuccessful {
    NSLog(@"Logged in!");
	[self saveFBData:[facebookConnection savePersistentSession]];
	/* do once */
	NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
	NSString *val = nil;
	
	if (standardUserDefaults) 
		val = [standardUserDefaults objectForKey:@"extend"];
	if (val == nil) {
		[facebookConnection grantExtendedPermission:@"offline_access"];
		[standardUserDefaults setObject:@"done" forKey:@"extend"];
		[standardUserDefaults synchronize];
	}
	// Check every minute for updates
	[self checkFacebook:nil];
	[NSTimer scheduledTimerWithTimeInterval:60.0 target:self selector:@selector(checkFacebook:) userInfo:nil repeats:YES];
}

- (void) awakeFromNib {
	facebookConnection = [[MKFacebook facebookWithAPIKey:@"YOUR_API_KEY" 
											  withSecret:@"YOUR_SECRET_KEY" 
												delegate:self] retain];
	//Create the NSStatusBar and set its length
	statusItem = [[[NSStatusBar systemStatusBar] 
	                statusItemWithLength:NSVariableStatusItemLength] retain];

	//Used to detect where our files are
	NSBundle *bundle = [NSBundle mainBundle];
	
	//Allocates and loads the images into the application which will be used for our NSStatusItem
	statusImage = [[NSImage alloc] initWithContentsOfFile:[bundle pathForResource:@"favicon" ofType:@"ico"]];
	
	//Sets the images in our NSStatusItem
	[statusItem setImage:statusImage];
	[statusItem setTitle:@""];
	
	//Tells the NSStatusItem what menu to load
	[statusItem setMenu:statusMenu];
	//Sets the tooptip for our item
	[statusItem setToolTip:@"Facebook Notifier"];
	[self login];
	
	[statusItem setHighlightMode:YES];
}

-(void) saveFBData:(NSDictionary *) dict {
	NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
	
	if (standardUserDefaults) {
		[standardUserDefaults setObject:dict forKey:@"Prefs"];
		[standardUserDefaults synchronize];
	}
}

-(NSDictionary *) getFBData {
	NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
	NSDictionary *val = nil;
	if (standardUserDefaults) 
		val = [standardUserDefaults objectForKey:@"Prefs"];
	return val;
}


- (void) dealloc {
	[statusImage release];
	[super dealloc];
}

-(IBAction) openFacebokWebpage:(id)sender {
	NSURL *someUrl = [NSURL URLWithString:@"http://facebook.com/"];
	if ([[NSWorkspace sharedWorkspace] openURL:someUrl])
		NSLog(@"Opened successfully.");
}

- (void) login {
	NSDictionary *data = [self getFBData];
	[facebookConnection restorePersistentSession:data];
	[data autorelease];
	if (![facebookConnection userLoggedIn]) {
		NSLog(@"LOGIN!");
		[NSApp activateIgnoringOtherApps:YES];
		[facebookConnection showFacebookLoginWindow];
	} else {
		NSLog(@"LOGGED IN!");
	}
}

@end
