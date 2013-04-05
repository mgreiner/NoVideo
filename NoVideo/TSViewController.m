//
//  TSViewController.m
//  NoVideo
//
//  Created by Michael Greiner on 2013-03-28.
//  Copyright (c) 2013 theScore, Inc. All rights reserved.
//

#import "TSViewController.h"
#import "MPInterstitialAdController.h"

@interface TSViewController () <MPInterstitialAdControllerDelegate>

@property (retain, nonatomic) IBOutlet UITextField *adUnitIDTextField;
@property (retain, nonatomic) IBOutlet UITextField *keywordsTextField;

- (IBAction)requestAd:(id)sender;

@end

@interface TSInterstitialSegue : UIStoryboardSegue
@end

@implementation TSViewController

- (void)dealloc {
    [_adUnitIDTextField release], _adUnitIDTextField = nil;
    [_keywordsTextField release], _keywordsTextField = nil;
    [super dealloc];
}

- (IBAction)requestAd:(id)sender
{
    MPInterstitialAdController *adViewController = [MPInterstitialAdController interstitialAdControllerForAdUnitId:self.adUnitIDTextField.text];
    adViewController.delegate = self;
    adViewController.keywords = self.keywordsTextField.text;
    [adViewController loadAd];
}

-(void)interstitialDidLoadAd:(MPInterstitialAdController *)interstitial
{
    interstitial.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [interstitial showFromViewController:self];
}

-(void)interstitialDidDisappear:(MPInterstitialAdController *)interstitial
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
