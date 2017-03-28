//
//  DynamicCollectionViewController.m
//  NSUrlSession
//
//  Created by Vikas Mishra on 12/6/16.
//  Copyright © 2016 dev. All rights reserved.
//

#import "DynamicCollectionViewController.h"
#import "dynamicCollectionViewCell.h"
@interface DynamicCollectionViewController ()

@end

@implementation DynamicCollectionViewController
@synthesize dynamicCollectionView,dictData,mStrXMLString,mDictXMLPart,mArrXMLData;

static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Register cell classes
//    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    
    data=[[NSMutableArray alloc]initWithObjects:@"Do any additional setup after loading the view, typically from a nib.",@"Dispose of any resources that can be recreated.Do any additional setup after loading the view, typically from a nib.",@"Do any additional setup after loading the view, typically from a nib.Do any additional setup after loading the view, typically from a nib.Do any additional setup after loading the view, typically from a nib.",@"Dispose of any resources that can be recreated.",@"Dispose of any resources that can be recreated.Dispose of any resources that can be recreated.",@"Dispose of any resources that can be recreated.",@"Dispose of any resources that can be recreated.",@"Do any additional setup after loading the view, typically from a nib.Do any additional setup after loading the view, typically from a nib.",@"Do any additional setup after loading the view, typically from a nib.Do any additional setup after loading the view, typically from a nib.",@"Dispose of any resources that can be recreated.",@"Do any additional setup after loading the view, typically from a nib.",@"Dispose of any resources that can be recreated.",@"Dispose of any resources that can be recreated.Dispose of any resources that can be recreated.",@"Dispose of any resources that can be recreated.",@"Dispose of any resources that can be recreated.",@"Do any additional setup after loading the view, typically from a nib.Do any additional setup after loading the view, typically from a nib.", @"Dispose of any resources that can be recreated.",@"Dispose of any resources that can be recreated.",@"Dispose of any resources that can be recreated.",@"Dispose of any resources that can be recreated.",nil];
    
    
    
    [self parseXmlData];
    
    
    columncount = 2;
    miniInteriorSpacing = 10;
    if(![dynamicCollectionView.collectionViewLayout isKindOfClass:[customLayout class]]){
        customLayout *layout = [customLayout new];
        layout.delegate = self;
        layout.columnCount = columncount;
        dynamicCollectionView.collectionViewLayout = layout;
        //[dynamicCollectionView reloadData];
    }
    
    // Do any additional setup after loading the view.
}


-(void)parseXmlData{
    NSXMLParser *xmlParser = [[NSXMLParser alloc]initWithContentsOfURL:[NSURL URLWithString:@"http://images.apple.com/main/rss/hotnews/hotnews.rss#sthash.QjeLubRg.dpuf"]];
    [xmlParser setDelegate:self];
    [xmlParser parse];
    NSLog(@"Array Length : %lu",(unsigned long)[mArrXMLData count]);
    if (mArrXMLData.count != 0) {
        [dynamicCollectionView reloadData];
    }
}

-(void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary<NSString *,NSString *> *)attributeDict{
    if ([elementName isEqualToString:@"rss"]) {
        mArrXMLData = [[NSMutableArray alloc]init];
    }
    if ([elementName isEqualToString:@"item"]) {
        mDictXMLPart = [[NSMutableDictionary alloc]init];
    }
}

-(void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string{
    
    if(!mStrXMLString){
        mStrXMLString = [[NSMutableString alloc]initWithString:string];
    }else{
        [mStrXMLString appendString:string];
    }
}
-(void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName{
    
    if([elementName isEqualToString:@"description"] ||[elementName isEqualToString:@"title"]){
        [mDictXMLPart setObject:mStrXMLString forKey:elementName];
    }
    else if ([elementName isEqualToString:@"item"]){
        [mArrXMLData addObject:mDictXMLPart];
    }
    mStrXMLString = nil;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {

    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {

    return [data count];
}

-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return  10.0f;
}
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 10.0f;
}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    CGFloat sizee = [self calculateHeightForLabel:[data objectAtIndex:indexPath.row] Width:self.view.frame.size.width/2-15];
    return  CGSizeMake(self.view.frame.size.width/2-15, sizee+30);
}


-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(0, 10, 0, 10);
}

-(float)calculateHeightForLabel:(NSString*)text Width:(float)width{
    CGSize constraint = CGSizeMake(width, 20000.0f);
    CGSize size;
    NSStringDrawingContext *context = [[NSStringDrawingContext alloc]init];
    CGSize boundingBox = [text boundingRectWithSize:constraint options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} context:context].size;
    size = CGSizeMake(ceil(boundingBox.width), ceil(boundingBox.height));
    return size.height+10;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    dynamicCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"dynamicCell" forIndexPath:indexPath];
    
    cell.label.text = [data objectAtIndex:indexPath.row];

    
    // Configure the cell
    
    return cell;
}

#pragma mark <UICollectionViewDelegate>

/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/

/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/

@end
