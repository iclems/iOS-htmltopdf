iOS-htmltopdf
=============

This class enables simple URL-based PDF creation. Pages are created the exact same way they would be if the user printed the content on an iOS device (very similar as well as OS X print output).

Example code:

`    self.PDFCreator = [NDHTMLtoPDF createPDFWithURL:[NSURL URLWithString:@"http://edition.cnn.com/2012/11/12/business/china-consumer-economy/index.html?hpt=hp_c1"]

                                         pathForPDF:[@"~/Documents/demo.pdf" stringByExpandingTildeInPath]

                                           delegate:self

                                           pageSize:kPaperSizeA4

                                            margins:UIEdgeInsetsMake(10, 5, 10, 5)];
`

A paper size is only defined by a rect (e.g. kPaperSizeA4 CGSizeMake(595,842)).

Please, be sure to create a property (e.g. `PDFCreator`) as NDHTMLtoPDF works asynchronously using UIWebView.

Feel free to contact me if you have any question !

@cwehrung

cwehrung@nurves.com

Clément Wehrung