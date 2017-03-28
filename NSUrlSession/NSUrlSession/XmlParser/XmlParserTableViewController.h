//
//  XmlParserTableViewController.h
//  NSUrlSession
//
//  Created by Vikas Mishra on 12/6/16.
//  Copyright © 2016 dev. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XmlParserTableViewController : UITableViewController <NSXMLParserDelegate>

@property (nonatomic,strong) NSMutableDictionary *dictData;
@property (nonatomic,strong) NSMutableArray *mArrXMLData;
@property (nonatomic,strong) NSMutableString *mStrXMLString;
@property (nonatomic,strong) NSMutableDictionary *mDictXMLPart;

@end
