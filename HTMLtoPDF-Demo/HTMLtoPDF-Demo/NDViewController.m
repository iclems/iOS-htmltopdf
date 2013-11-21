//
//  NDViewController.m
//  HTMLtoPDF-Demo
//
//  Created by Clément Wehrung on 12/11/12.
//  Copyright (c) 2012 Nurves. All rights reserved.
//

#import "NDViewController.h"

@interface NDViewController ()

@end

@implementation NDViewController

@synthesize PDFCreator;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

#pragma mark Button Actions

- (IBAction)generatePDFUsingDelegate:(id)sender
{
    self.resultLabel.text = @"loading...";
    
    self.PDFCreator = [NDHTMLtoPDF createPDFWithURL:[NSURL URLWithString:@"http://edition.cnn.com/2012/11/12/business/china-consumer-economy/index.html?hpt=hp_c1"]
                                         pathForPDF:[@"~/Documents/delegateDemo.pdf" stringByExpandingTildeInPath]
                                           delegate:self
                                           pageSize:kPaperSizeA4
                                            margins:UIEdgeInsetsMake(10, 5, 10, 5)];
}

- (IBAction)generatePDFUsingBlocks:(id)sender
{
    self.resultLabel.text = @"loading...";
    
    self.PDFCreator = [NDHTMLtoPDF createPDFWithURL:[NSURL URLWithString:@"http://edition.cnn.com/2013/09/19/opinion/rushkoff-apple-ios-baby-steps/index.html"] pathForPDF:[@"~/Documents/blocksDemo.pdf" stringByExpandingTildeInPath] pageSize:kPaperSizeA4 margins:UIEdgeInsetsMake(10, 5, 10, 5) successBlock:^(NDHTMLtoPDF *htmlToPDF) {
        NSString *result = [NSString stringWithFormat:@"HTMLtoPDF did succeed (%@ / %@)", htmlToPDF, htmlToPDF.PDFpath];
        NSLog(@"%@",result);
        self.resultLabel.text = result;
    } errorBlock:^(NDHTMLtoPDF *htmlToPDF) {
        NSString *result = [NSString stringWithFormat:@"HTMLtoPDF did fail (%@)", htmlToPDF];
        NSLog(@"%@",result);
        self.resultLabel.text = result;
    }];
}

#pragma mark NDHTMLtoPDFDelegate

- (void)HTMLtoPDFDidSucceed:(NDHTMLtoPDF*)htmlToPDF
{
    NSString *result = [NSString stringWithFormat:@"HTMLtoPDF did succeed (%@ / %@)", htmlToPDF, htmlToPDF.PDFpath];
    NSLog(@"%@",result);
    self.resultLabel.text = result;
}

- (void)HTMLtoPDFDidFail:(NDHTMLtoPDF*)htmlToPDF
{
    NSString *result = [NSString stringWithFormat:@"HTMLtoPDF did fail (%@)", htmlToPDF];
    NSLog(@"%@",result);
    self.resultLabel.text = result;
}

@end
