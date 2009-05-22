// 
//  MKPhotoUploader.h
//  MKAbeFook
//
//  Created by Mike on 3/4/07.
/*
 Copyright (c) 2008, Mike Kinney
 All rights reserved.
 
 * Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:
 * Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.
 * Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.
 
 Neither the name of MKAbeFook nor the names of its contributors may be used to endorse or promote products derived from this software without specific prior written permission.
 THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 
 */

#import <Cocoa/Cocoa.h>
#import "MKFacebook.h"

/*!
 @brief Uploads images to Facebook (Deprecated in 0.7)
 
 @class MKPhotoUploader
  This class is considered deprecated as of version 0.7.  Use MKFacebookRequest instead.
 
 Available Delegate Methods

-(void)photoDidFinishUploading:(id)facebookResponse;<br/>
&nbsp;&nbsp;  Called when single photo has uploaded.  Passes response from Facebook as NXMLDocument.
 
-(void)bunchOfPhotosDidFinishUploading;
&nbsp;&nbsp; Called when all photos have finished uploading.
 
-(void)invalidImage:(NSDictionary *)aDictionary;
 &nbsp;&nbsp;  Called if item in bunchOfPhotosArray could not create a valid NSImage.  Passes information about the failed item.
  @deprecated Deprecated as of version 0.7
 */

@interface MKPhotoUploader : NSObject {
	NSURLConnection *facebookUploadConnection;
	id _delegate;
	MKFacebook *facebookConnection;
	NSMutableData *responseData;
	NSArray *bunchOfPhotosArray;
	BOOL isUploadingABunchOfPhotos;
	int bunchOfPhotosIndex; 
}

/*!
 @param aFacebookConnection MKFacebook object a user has successfully logged into.
 @param aDelegate Object to receive delegate notifications.
  Deprecated as of 0.7.
 @result Creates newly allocated MKPhotoUploader object ready to upload photos to Facebook.com.
  @deprecated Deprecated as of version 0.7
 */
+(MKPhotoUploader *)usingFacebookConnection:(MKFacebook *)aFacebookConnection delegate:(id)aDelegate;

/*!
 @param aFacebookConnection MKFacebook object a user has successfully logged into.
 @param aDelegate Object to receive delegate notifications.
  Deprecated as of 0.7.
 @result Creates new MKPhotoUploader object ready to upload photos to Facebook.com.
  @deprecated Deprecated as of version 0.7
 */
-(MKPhotoUploader *)initUsingFacebookConnection:(MKFacebook *)aFacebookConnection delegate:(id)aDelegate;
-(id)delegate;
-(void)setDelegate:(id)aDelegate;

/*!
 @param aBunchOfPhotosArray Array of NSDictionary objects containing keys "aid", "caption", and "pathToImage".  "pathToImage" value should be a valid path to a image file that can be used to create a NSImage object.
  Deprecated as of 0.7.
  @deprecated Deprecated as of version 0.7
 */
-(void)uploadABunchOfPhotos:(NSArray *)aBunchOfPhotosArray;
//this should be private
-(void)uploadNextPhoto;

/*!
 @param anAid Album id to upload photo to.
 @param aCaption Caption for photo.
 @param anImage NSImage to upload.
  Deprecated as of 0.7.
  @deprecated Deprecated as of version 0.7
 */
-(void)facebookPhotoUpload:(NSString *)anAid caption:(NSString *)aCaption image:(NSImage *)anImage;

/*!
 @param anAid Album id to upload photo to.
 @param aCaption Caption for photo.
 @param aPathToImage Path to image file that can be used to create a NSImage object.
  Deprecated as of 0.7.
  @deprecated Deprecated as of version 0.7
 */
-(void)facebookPhotoUpload:(NSString *)anAid caption:(NSString *)aCaption pathToImage:(NSString *)aPathToImage;
-(void)cancelUpload;

@end




