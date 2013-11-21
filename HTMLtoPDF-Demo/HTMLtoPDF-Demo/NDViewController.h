//
//  NDViewController.h
//  HTMLtoPDF-Demo
//
//  Created by Clément Wehrung on 12/11/12.
//  Copyright (c) 2012 Nurves. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "NDHTMLtoPDF.h"

@interface NDViewController : UIViewController <NDHTMLtoPDFDelegate>

@property (nonatomic, strong) NDHTMLtoPDF *PDFCreator;
@property (nonatomic, weak) IBOutlet UILabel *resultLabel;

@end
