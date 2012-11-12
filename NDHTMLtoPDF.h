//
//  NDHTMLtoPDF.h
//  Nurves
//
//  Created by Clément Wehrung on 31/10/12.
//  Copyright (c) 2012 QuelleEnergie. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kPaperSizeA4 CGSizeMake(595,842)

@protocol NDHTMLtoPDFDelegate <NSObject>

- (void)HTMLToPDFDidSucceed;
- (void)HTMLToPDFDidFail;

@end

@interface NDHTMLtoPDF : UIViewController <UIWebViewDelegate>

@property (nonatomic, weak) id <NDHTMLtoPDFDelegate> delegate;

+ (id)createPDFWithURL:(NSURL*)URL pathForPDF:(NSString*)PDFpath delegate:(id <NDHTMLtoPDFDelegate>)delegate pageSize:(CGSize)pageSize margins:(UIEdgeInsets)pageMargins;

@end