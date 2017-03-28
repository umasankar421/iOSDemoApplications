//
//  XmlParserTableViewController.m
//  NSUrlSession
//
//  Created by Vikas Mishra on 12/6/16.
//  Copyright © 2016 dev. All rights reserved.
//

#import "XmlParserTableViewController.h"
#import "AboutNSURLSessionViewController.h"
@interface XmlParserTableViewController ()

@end

@implementation XmlParserTableViewController
@synthesize mArrXMLData,mDictXMLPart,dictData,mStrXMLString;
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self parseXMLData];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

-(void)parseXMLData{
    
    NSXMLParser *parser = [[NSXMLParser alloc]initWithContentsOfURL:[NSURL URLWithString:@"http://images.apple.com/main/rss/hotnews/hotnews.rss#sthash.QjeLubRg.dpuf"]];
    [parser setDelegate:self];
    [parser parse];
    NSLog(@"XML Parser");
    if(mArrXMLData.count != 0 ){
        [self.tableView reloadData];
    }
    
}
// XML Parser Delegate Methods
-(void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary<NSString *,NSString *> *)attributeDict{
    
    if([elementName isEqualToString:@"rss"]){
        mArrXMLData = [[NSMutableArray alloc]init];
    }
    if([elementName isEqualToString:@"item"]){
        mDictXMLPart = [[NSMutableDictionary alloc]init];
    }
    NSLog(@"didStartElement : %@",elementName);
}
-(void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string{
    NSLog(@"foundCharacters : %@",string);
    if(!mStrXMLString){
        mStrXMLString = [[NSMutableString alloc]initWithString:string];
    }else{
        [mStrXMLString appendString:string];
    }
    NSLog(@"strXMLString : %@",mStrXMLString);
}
-(void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName{
    
    if ([elementName isEqualToString:@"title"] || [elementName isEqualToString:@"pubDate"] || [elementName isEqualToString:@"link"]) {
        [mDictXMLPart setObject:mStrXMLString forKey:elementName];
    }
    if([elementName isEqualToString:@"item"]){
        [mArrXMLData addObject:mDictXMLPart];
        NSLog(@"Array Element is : %@",mArrXMLData);
    }
    mStrXMLString = nil;
    NSLog(@"didEndElement : %@",elementName);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return [mArrXMLData count];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    AboutNSURLSessionViewController *webView = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"AboutNSURLSessionViewController"];
    NSLog(@"Selected Link is : %@",[[mArrXMLData objectAtIndex:indexPath.row]valueForKey:@"link"]);
    webView.loadURL = [[mArrXMLData objectAtIndex:indexPath.row]valueForKey:@"link"];
    [self.navigationController pushViewController:webView animated:YES];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
    
//    if(cell == nil){
//        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
//    }
    
    cell.textLabel.text = [[[mArrXMLData objectAtIndex:indexPath.row] valueForKey:@"title"]stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    cell.detailTextLabel.text = [[[mArrXMLData objectAtIndex:indexPath.row]valueForKey:@"pubDate"]stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    // Configure the cell...
    
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
