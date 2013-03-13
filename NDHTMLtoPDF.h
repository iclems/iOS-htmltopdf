//
//  NDHTMLtoPDF.h
//  Nurves
//
//  Created by Clément Wehrung on 31/10/12.
//  Copyright (c) 2012-2013 Nurves. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kPaperSizeA4 CGSizeMake(595,842)
#define kPaperSizeLetter CGSizeMake(612,792)

@class NDHTMLtoPDF;

@protocol NDHTMLtoPDFDelegate <NSObject>

@optional
- (void)HTMLtoPDFDidSucceed:(NDHTMLtoPDF*)htmlToPDF;
- (void)HTMLtoPDFDidFail:(NDHTMLtoPDF*)htmlToPDF;

@end

@interface NDHTMLtoPDF : UIViewController <UIWebViewDelegate>

@property (nonatomic, weak) id <NDHTMLtoPDFDelegate> delegate;

@property (nonatomic, strong, readonly) NSString *PDFpath;

+ (id)createPDFWithURL:(NSURL*)URL pathForPDF:(NSString*)PDFpath delegate:(id <NDHTMLtoPDFDelegate>)delegate pageSize:(CGSize)pageSize margins:(UIEdgeInsets)pageMargins;
+ (id)createPDFWithHTML:(NSString*)HTML pathForPDF:(NSString*)PDFpath delegate:(id <NDHTMLtoPDFDelegate>)delegate pageSize:(CGSize)pageSize margins:(UIEdgeInsets)pageMargins;

@end
