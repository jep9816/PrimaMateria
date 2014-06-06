//
//  XTRSwapableViewController.h
//  PrimaMateria
//
//  Created by Jerry Porter on 11/30/11.
//  Copyright (c) 2011 xTrensa. All rights reserved.
//

@class XTRElement;

@interface XTRSwapableViewController : UIViewController

@property (nonatomic, strong) XTRElement *element;

- (void)setupUI;

@end
