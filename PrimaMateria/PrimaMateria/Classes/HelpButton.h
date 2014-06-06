//
//  HelpButton.h
//  PrimaMateria
//
//  Created by Jerry Porter on 1/5/2011.
//  Copyright 2014 xTrensa. All rights reserved.
//

@class GeneralButton;

@interface HelpButton : GeneralButton <UIPopoverControllerDelegate>

@property (readwrite, strong, nonatomic) UIPopoverController *popoverController;

@end
