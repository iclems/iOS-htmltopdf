//
//  NDHTMLtoPDF.m
//  Nurves
//
//  Created by Clément Wehrung on 31/10/12.
//  Copyright (c) 2012 QuelleEnergie. All rights reserved.
//
//  This program is free software: you can redistribute it and/or modify
//  it under the terms of the GNU General Public License as published by
//  the Free Software Foundation, either version 3 of the License, or
//  (at your option) any later version.
//
//  This program is distributed in the hope that it will be useful,
//  but WITHOUT ANY WARRANTY; without even the implied warranty of
//  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
//  GNU General Public License for more details.
//
//  You should have received a copy of the GNU General Public License
//  along with this program.  If not, see <http://www.gnu.org/licenses/>.
//
//  Contact cwehrung@nurves.com for any question. 
//
//  Sources : http://www.labs.saachitech.com/2012/10/23/pdf-generation-using-uiprintpagerenderer/
//  Addons : http://developer.apple.com/library/ios/#samplecode/PrintWebView/Listings/MyPrintPageRenderer_m.html#//apple_ref/doc/uid/DTS40010311-MyPrintPageRenderer_m-DontLinkElementID_7

#import "NDHTMLtoPDF.h"

@interface NDHTMLtoPDF ()

@property (nonatomic, strong) NSURL *URL;
@property (nonatomic, strong) NSString *HTML;
@property (nonatomic, strong) NSString *PDFpath;
@property (nonatomic, strong) UIWebView *webview;
@property (nonatomic, assign) CGSize pageSize;
@property (nonatomic, assign) UIEdgeInsets pageMargins;

@end

@interface UIPrintPageRenderer (PDF)

- (NSData*) printToPDF;

@end

@implementation NDHTMLtoPDF

@synthesize URL=_URL,webview,delegate=_delegate,PDFpath=_PDFpath,pageSize=_pageSize,pageMargins=_pageMargins;

// Create PDF by passing in the URL to a webpage
+ (id)createPDFWithURL:(NSURL*)URL pathForPDF:(NSString*)PDFpath delegate:(id <NDHTMLtoPDFDelegate>)delegate pageSize:(CGSize)pageSize margins:(UIEdgeInsets)pageMargins
{
    NDHTMLtoPDF *creator = [[NDHTMLtoPDF alloc] initWithURL:URL delegate:delegate pathForPDF:PDFpath pageSize:pageSize margins:pageMargins];
    
    return creator;
}

// Create PDF by passing in the HTML as a String
+ (id)createPDFWithHTML:(NSString*)HTML pathForPDF:(NSString*)PDFpath delegate:(id <NDHTMLtoPDFDelegate>)delegate
               pageSize:(CGSize)pageSize margins:(UIEdgeInsets)pageMargins
{
    NDHTMLtoPDF *creator = [[NDHTMLtoPDF alloc] initWithHTML:HTML delegate:delegate pathForPDF:PDFpath pageSize:pageSize margins:pageMargins];
    
    return creator;
}

- (id)initWithURL:(NSURL*)URL delegate:(id <NDHTMLtoPDFDelegate>)delegate pathForPDF:(NSString*)PDFpath pageSize:(CGSize)pageSize margins:(UIEdgeInsets)pageMargins
{
    self = [super init];
    if (self)
    {
        self.URL = URL;
        self.delegate = delegate;
        self.PDFpath = PDFpath;
                
        self.pageMargins = pageMargins;
        self.pageSize = pageSize;

        [[UIApplication sharedApplication].delegate.window addSubview:self.view];

        self.view.frame = CGRectMake(0, 0, 1, 1);
        self.view.alpha = 0.0;
    }
    return self;
}

- (id)initWithHTML:(NSString*)HTML delegate:(id <NDHTMLtoPDFDelegate>)delegate
        pathForPDF:(NSString*)PDFpath pageSize:(CGSize)pageSize margins:(UIEdgeInsets)pageMargins
{
    self = [super init];
    if (self)
    {
        self.HTML = HTML;
        self.delegate = delegate;
        self.PDFpath = PDFpath;
        
        self.pageMargins = pageMargins;
        self.pageSize = pageSize;
        
        [[UIApplication sharedApplication].delegate.window addSubview:self.view];
        
        self.view.frame = CGRectMake(0, 0, 1, 1);
        self.view.alpha = 0.0;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.webview = [[UIWebView alloc] initWithFrame:self.view.frame];
    webview.delegate = self;
    
    [self.view addSubview:webview];
    
    if (self.URL != nil) {
        [webview loadRequest:[NSURLRequest requestWithURL:self.URL]];
    }else{
        [webview loadHTMLString:self.HTML baseURL:nil];
    }
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    if (webView.isLoading) return;
    
    UIPrintPageRenderer *render = [[UIPrintPageRenderer alloc] init];
    
    [render addPrintFormatter:webView.viewPrintFormatter startingAtPageAtIndex:0];
        
    CGRect printableRect = CGRectMake(self.pageMargins.left,
                                  self.pageMargins.top,
                                  self.pageSize.width - self.pageMargins.left - self.pageMargins.right,
                                  self.pageSize.height - self.pageMargins.top - self.pageMargins.bottom);
    
    CGRect paperRect = CGRectMake(0, 0, self.pageSize.width, self.pageSize.height);
    
    [render setValue:[NSValue valueWithCGRect:paperRect] forKey:@"paperRect"];
    [render setValue:[NSValue valueWithCGRect:printableRect] forKey:@"printableRect"];

    NSData *pdfData = [render printToPDF];
        
    [pdfData writeToFile: self.PDFpath  atomically: YES];
    
    [self terminateWebTask];

    if (self.delegate && [self.delegate respondsToSelector:@selector(HTMLtoPDFDidSucceed:)])
        [self.delegate HTMLtoPDFDidSucceed:self];
    

}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    if (webView.isLoading) return;

    [self terminateWebTask];

    if (self.delegate && [self.delegate respondsToSelector:@selector(HTMLtoPDFDidFail:)])
        [self.delegate HTMLtoPDFDidFail:self];

}

- (void)terminateWebTask
{
    [self.webview stopLoading];
    self.webview.delegate = nil;
    [self.webview removeFromSuperview];
    
    [self.view removeFromSuperview];
    
    self.webview = nil;
}

@end

@implementation UIPrintPageRenderer (PDF)

- (NSData*) printToPDF
{
    NSMutableData *pdfData = [NSMutableData data];
    
    UIGraphicsBeginPDFContextToData( pdfData, CGRectZero, nil );
        
    [self prepareForDrawingPages: NSMakeRange(0, self.numberOfPages)];
    
    CGRect bounds = UIGraphicsGetPDFContextBounds();
        
    for ( int i = 0 ; i < self.numberOfPages ; i++ )
    {
        UIGraphicsBeginPDFPage();
        
        [self drawPageAtIndex: i inRect: bounds];
    }
    
    UIGraphicsEndPDFContext();
        
    return pdfData;
}

@end
