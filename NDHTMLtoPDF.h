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

typedef void (^NDHTMLtoPDFCompletionBlock)(NDHTMLtoPDF* htmlToPDF);

@protocol NDHTMLtoPDFDelegate <NSObject>

@optional
- (void)HTMLtoPDFDidSucceed:(NDHTMLtoPDF*)htmlToPDF;
- (void)HTMLtoPDFDidFail:(NDHTMLtoPDF*)htmlToPDF;
@end

@interface NDHTMLtoPDF : UIViewController <UIWebViewDelegate>

@property (nonatomic, copy) NDHTMLtoPDFCompletionBlock successBlock;
@property (nonatomic, copy) NDHTMLtoPDFCompletionBlock errorBlock;

@property (nonatomic, weak) id <NDHTMLtoPDFDelegate> delegate;

@property (nonatomic, strong, readonly) NSString *PDFpath;

+ (id)createPDFWithURL:(NSURL*)URL pathForPDF:(NSString*)PDFpath delegate:(id <NDHTMLtoPDFDelegate>)delegate pageSize:(CGSize)pageSize margins:(UIEdgeInsets)pageMargins;
+ (id)createPDFWithHTML:(NSString*)HTML pathForPDF:(NSString*)PDFpath delegate:(id <NDHTMLtoPDFDelegate>)delegate pageSize:(CGSize)pageSize margins:(UIEdgeInsets)pageMargins;
+ (id)createPDFWithHTML:(NSString*)HTML baseURL:(NSURL*)baseURL pathForPDF:(NSString*)PDFpath delegate:(id <NDHTMLtoPDFDelegate>)delegate pageSize:(CGSize)pageSize margins:(UIEdgeInsets)pageMargins;

+ (id)createPDFWithURL:(NSURL*)URL pathForPDF:(NSString*)PDFpath pageSize:(CGSize)pageSize margins:(UIEdgeInsets)pageMargins successBlock:(NDHTMLtoPDFCompletionBlock)successBlock errorBlock:(NDHTMLtoPDFCompletionBlock)errorBlock;
+ (id)createPDFWithHTML:(NSString*)HTML pathForPDF:(NSString*)PDFpath pageSize:(CGSize)pageSize margins:(UIEdgeInsets)pageMargins successBlock:(NDHTMLtoPDFCompletionBlock)successBlock errorBlock:(NDHTMLtoPDFCompletionBlock)errorBlock;
+ (id)createPDFWithHTML:(NSString*)HTML baseURL:(NSURL*)baseURL pathForPDF:(NSString*)PDFpath pageSize:(CGSize)pageSize margins:(UIEdgeInsets)pageMargins successBlock:(NDHTMLtoPDFCompletionBlock)successBlock errorBlock:(NDHTMLtoPDFCompletionBlock)errorBlock;
@end
