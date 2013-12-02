iOS-htmltopdf
=============

This class enables simple URL-based PDF creation. Pages are created the exact same way they would be if the user printed the content on an iOS device (very similar as well as OS X print output).

Example code:

```
    self.PDFCreator = [NDHTMLtoPDF createPDFWithURL:
        [NSURL URLWithString:@"http://url.com"]
         pathForPDF:[@"~/Documents/demo.pdf" stringByExpandingTildeInPath]
         delegate:self
         pageSize:kPaperSizeA4
         margins:UIEdgeInsetsMake(10, 5, 10, 5)];
```

or using block syntax

```
     self.PDFCreator = [NDHTMLtoPDF createPDFWithURL:[NSURL URLWithString:@"http:/url.com"]
         pathForPDF:[@"~/Documents/blocksDemo.pdf" stringByExpandingTildeInPath]
         pageSize:kPaperSizeA4 margins:UIEdgeInsetsMake(10, 5, 10, 5)
         successBlock:^(NDHTMLtoPDF *htmlToPDF) {
              NSLog(@"HTMLtoPDF did succeed (%@ / %@)", htmlToPDF, htmlToPDF.PDFpath);
         } errorBlock:^(NDHTMLtoPDF *htmlToPDF) {
               NSLog(@"HTMLtoPDF did fail (%@)", htmlToPDF);
         }];
```

You can also use the alternative following code to generate PDF directly from HTML string, without using an URL. This is useful if you want your PDF generator to work offline or if you don't want to write first your code into a local file (you can then use NSURL with a local file through fileURLWithPath:) :

```
+ (id)createPDFWithHTML:(NSString*)HTML pathForPDF:(NSString*)PDFpath delegate:(id <NDHTMLtoPDFDelegate>)delegate pageSize:(CGSize)pageSize margins:(UIEdgeInsets)pageMargins;
+ (id)createPDFWithHTML:(NSString*)HTML baseURL:(NSURL*)baseURL pathForPDF:(NSString*)PDFpath delegate:(id <NDHTMLtoPDFDelegate>)delegate pageSize:(CGSize)pageSize margins:(UIEdgeInsets)pageMargins;
+ (id)createPDFWithHTML:(NSString*)HTML pathForPDF:(NSString*)PDFpath pageSize:(CGSize)pageSize margins:(UIEdgeInsets)pageMargins successBlock:(NDHTMLtoPDFCompletionBlock)successBlock errorBlock:(NDHTMLtoPDFCompletionBlock)errorBlock;
+ (id)createPDFWithHTML:(NSString*)HTML baseURL:(NSURL*)baseURL pathForPDF:(NSString*)PDFpath pageSize:(CGSize)pageSize margins:(UIEdgeInsets)pageMargins successBlock:(NDHTMLtoPDFCompletionBlock)successBlock errorBlock:(NDHTMLtoPDFCompletionBlock)errorBlock;
```

A paper size is only defined by a rect (e.g. kPaperSizeA4 CGSizeMake(595.2,841.8)).

Please, be sure to create a property (e.g. `PDFCreator`) as NDHTMLtoPDF works asynchronously using UIWebView.

Feel free to contact me if you have any question !

@cwehrung

cwehrung@nurves.com

Clément Wehrung
