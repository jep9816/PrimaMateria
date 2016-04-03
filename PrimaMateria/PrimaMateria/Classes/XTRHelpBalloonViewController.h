//
//  XTRHelpBalloonViewController.h
//  PrimaMateria
//
//  Created by Jerry Porter on 11/21/11.
//  Copyright 2016 xTrensa. All rights reserved.
//

@interface XTRHelpBalloonViewController : UIViewController <UIWebViewDelegate>


@property (nonatomic, strong) IBOutlet UIWebView *webView;
@property (nonatomic, strong) IBOutlet UIButton *backButton;
@property (nonatomic, strong) IBOutlet UIButton *forwardButton;
@property (nonatomic, strong) IBOutlet UILabel *titleLabel;

-(IBAction)dismiss: (id) sender;
-(IBAction)backButtonPressed:(id)sender;
-(IBAction)forwardButtonPressed:(id)sender;

@end
