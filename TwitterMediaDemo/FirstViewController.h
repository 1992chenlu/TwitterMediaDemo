//
//  FirstViewController.h
//  TwitterDemo
//
//  Created by 鲁辰 on 7/13/15.
//  Copyright (c) 2015 ChenLu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Social/Social.h>
#import <MobileCoreServices/MobileCoreServices.h>
#import <AVFoundation/AVFoundation.h>
#import <Accounts/Accounts.h>


@interface FirstViewController : UIViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (strong, nonatomic) NSURL *video;

- (IBAction)tweetImage:(id)sender;
- (IBAction)tweetVideo:(id)sender;
- (IBAction)captureVideo:(id)sender;

@end

