//
//  HelpButton.m
//  PrimaMateria
//
//  Created by Jerry Porter on 1/5/2011.
//  Copyright 2014 xTrensa. All rights reserved.
//

#import "PrimaMateria.h"

@interface HelpButton()
- (void) createPopupController;
@end

@implementation HelpButton
@synthesize popoverController;

#pragma mark Private Methods

- (void) createPopupController {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName: MAIN_STORY_BOARD bundle:nil];
	XTRHelpBalloonViewController *content = [storyboard instantiateViewControllerWithIdentifier: NSStringFromClass([XTRHelpBalloonViewController class])];
	CGSize contentSize = CGSizeMake(480.0f, 240.0f);
	content.preferredContentSize = contentSize;
	UIPopoverController *aPopover = [[UIPopoverController alloc] initWithContentViewController:content];
	aPopover.popoverContentSize = contentSize;
	aPopover.delegate = self;
	self.popoverController = aPopover;
}

#pragma mark - Initialization Methods

- (void)awakeFromNib {
	[super awakeFromNib];
	[self createPopupController];
}

#pragma mark - UIPopoverControllerDelegate Methods

- (BOOL)popoverControllerShouldDismissPopover:(UIPopoverController *)popoverController {
	return YES;
}

- (void)popoverControllerDidDismissPopover:(UIPopoverController *)popoverController {
}

#pragma mark - Misc Methods

- (void)setupColors {
	[self setHigh_Color: [UIColor clearColor]];
	[self setLow_Color: [UIColor yellowColor]];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
	NSString *label  = [self titleForState: UIControlStateDisabled];
	if(label != nil) {
		[self.popoverController presentPopoverFromRect: self.frame inView: self permittedArrowDirections:UIPopoverArrowDirectionAny animated: YES];
		[[NSNotificationCenter defaultCenter] postNotificationName: NOTIFICATION_ELEMENT_HELP_SELECTED object: label];
	}
}

#pragma mark - Memory Management Methods

@end
