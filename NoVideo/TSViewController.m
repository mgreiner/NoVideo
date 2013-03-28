//
//  TSViewController.m
//  NoVideo
//
//  Created by Michael Greiner on 2013-03-28.
//  Copyright (c) 2013 theScore, Inc. All rights reserved.
//

#import "TSViewController.h"
#import "MPAdView.h"

@interface TSViewController () <MPAdViewDelegate>

@property (retain, nonatomic) IBOutlet UITextField *adUnitIDTextField;
@property (retain, nonatomic) IBOutlet UITextField *keywordsTextField;

@property (retain, nonatomic) UIViewController *adViewController;

@end

@implementation TSViewController

- (void)dealloc {
    [_adUnitIDTextField release], _adUnitIDTextField = nil;
    [_keywordsTextField release], _keywordsTextField = nil;
    [_adViewController release], _adViewController = nil;
    [super dealloc];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"RequestAd"])
    {
        self.adViewController = (UIViewController *)segue.destinationViewController;
        
        MPInterstitialAdView *adView = [[MPInterstitialAdView alloc] initWithAdUnitId:self.adUnitIDTextField.text size:self.adViewController.view.frame.size];
        adView.delegate = self;
        adView.keywords = self.keywordsTextField.text;
        
        [self.adViewController.view addSubview:adView];
        [adView loadAd];
        [adView release];
    }
}

-(UIViewController *)viewControllerForPresentingModalView
{
    return self.adViewController;
}

-(void)didDismissModalViewForAd:(MPAdView *)view
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
