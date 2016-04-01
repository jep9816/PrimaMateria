//
//  XTRHelpBalloonViewController.h
//  PrimaMateria
//
//  Created by Jerry Porter on 11/21/11.
//  Copyright 2016 xTrensa. All rights reserved.
//

@interface XTRHelpBalloonViewController : UIViewController <UIWebViewDelegate>


@property (nonatomic, strong) IBOutlet UIWebView *webView;
@property (nonatomic, strong) IBOutlet UIButton *backbutton;
@property (nonatomic, strong) IBOutlet UIButton *fwdbutton;
@property (nonatomic, strong) IBOutlet UILabel *titleLabel;

- (IBAction)close: (id) sender;

@end
