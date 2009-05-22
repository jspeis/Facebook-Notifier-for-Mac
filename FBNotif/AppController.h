#import <Cocoa/Cocoa.h>
#import <MKAbeFook/MKAbeFook.h>


@interface AppController : NSObject {
	/* Our outlets which allow us to access the interface */
	IBOutlet NSMenu *statusMenu;
	MKFacebook *facebookConnection;
	NSStatusItem *statusItem;
	NSImage *statusImage;
}

/* Our IBAction which will call the helloWorld method when our connected Menu Item is pressed */
- (void) login;
- (void) userLoginSuccessful;
- (void) saveFBData:(NSDictionary *)dict;
- (NSDictionary *) getFBData;
- (void) checkFacebook:(id) timer;
- (IBAction) openFacebokWebpage:(id)sender;
@end