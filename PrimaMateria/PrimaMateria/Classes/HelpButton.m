//
//  HelpButton.m
//  PrimaMateria
//
//  Created by Jerry Porter on 1/5/2011.
//  Copyright 2016 xTrensa. All rights reserved.
//

@interface HelpButton()
@property (NS_NONATOMIC_IOSONLY, readonly, strong) UIViewController *viewController;
@end

@implementation HelpButton

#pragma mark Private Methods

- (UIViewController *)viewController {
    UIResponder *responder = self;
    while (![responder isKindOfClass:[UIViewController class]]) {
        responder = [responder nextResponder];
        if (nil == responder) {
            break;
        }
    }
    return (UIViewController *)responder;
}

#pragma mark - Initialization Methods

#pragma mark - Misc Methods


- (void)setupColors {
    self.backgroundColor = UIColor.yellowColor;
    [self setTitleColor: UIColor.blackColor forState: UIControlStateNormal];
    self.titleEdgeInsets = UIEdgeInsetsMake(0, -5, 0, 0);
}

- (void)touchesBegan: (NSSet *)touches withEvent: (UIEvent *)event {
    NSString *label  = [self titleForState: UIControlStateDisabled];

    if(label != nil) {
        UIViewController *controller = self.viewController;
        XTRHelpBalloonViewController *content = [[XTRAppDelegate storyboard] instantiateViewControllerWithIdentifier: NSStringFromClass([XTRHelpBalloonViewController class])];
        CGRect aFrame = self.bounds;
        CGRect aRect;
        
        if([label isEqualToString: @"periodicTable"]) {
            aRect = CGRectMake(5, 5, aFrame.size.width - 15, aFrame.size.height);
        } else {
            aRect = CGRectMake(0, 0, aFrame.size.width - 5, aFrame.size.height - 5);
        }

        content.preferredContentSize = CGSizeMake(410, 338);
        content.modalPresentationStyle = UIModalPresentationPopover;
        content.popoverPresentationController.sourceRect = aRect;
        content.popoverPresentationController.sourceView = self;
        [controller presentViewController:content animated:YES completion:nil];

        [[NSNotificationCenter defaultCenter] postNotificationName: NOTIFICATION_ELEMENT_HELP_SELECTED object: label];
    }
}

#pragma mark - Memory Management Methods

@end
