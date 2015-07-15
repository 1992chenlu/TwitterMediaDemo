//
//  FirstViewController.m
//  TwitterDemo
//
//  Created by 鲁辰 on 7/13/15.
//  Copyright (c) 2015 ChenLu. All rights reserved.
//

#import "FirstViewController.h"
#import "SocialVideoHelper.h"


@interface FirstViewController ()

@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)tweetImage:(id)sender {
    if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter])
    {
        
        SLComposeViewController *tweet = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter];
        [tweet setInitialText:@"#とある科学の超電磁砲# Twitter Demo Testing! Hahaha! "];
        [tweet addImage:[UIImage imageNamed:@"mikoto.jpg"]];
        [self presentViewController:tweet animated:YES completion:nil];
    }
    else
    {
        NSLog(@"Failed");
    }
}

- (IBAction)tweetVideo:(id)sender {
    if (_video == nil) {
        NSLog(@"No Video to upload!");
        return;
    }
    
    NSData *data = [NSData  dataWithContentsOfURL:_video];
    
    ACAccountStore *accountStore = [[ACAccountStore alloc] init];
    ACAccountType *accountType = [accountStore accountTypeWithAccountTypeIdentifier:ACAccountTypeIdentifierTwitter];
    [accountStore requestAccessToAccountsWithType:accountType options:NULL completion:^(BOOL granted, NSError *error) {
        if(granted) {
            NSArray *accountsArray = [accountStore accountsWithAccountType:accountType];
            if ([accountsArray count] > 0) {
                ACAccount *account = accountsArray[0];
                
                [SocialVideoHelper uploadTwitterVideo:data account:account withCompletion:^{
                    NSLog(@"%@", @"Video Uploaded! Hahaha!");
                }];
            }
        }
    }];
}

- (IBAction)captureVideo:(id)sender {
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        
        UIImagePickerController *picker = [[UIImagePickerController alloc]init];
        picker.delegate = self;
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        picker.allowsEditing = NO;
        
        //special for taking videos
        NSArray *mediaTypes = [[NSArray alloc]initWithObjects:(NSString *)kUTTypeMovie, nil];
        picker.mediaTypes = mediaTypes;
        
        [self presentViewController:picker animated:YES completion:nil];
    }
}

#pragma mark - Image Picker Controller delegate methods

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    _video = [info objectForKey:UIImagePickerControllerMediaURL];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:NULL];
}

@end
