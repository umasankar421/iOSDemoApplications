//
//  ViewController.m
//  SearchFeatureDemo
//
//  Created by Vikas Mishra on 12/14/16.
//  Copyright © 2016 dev. All rights reserved.
//

#import "ViewController.h"

@interface ViewController (){
    NSArray *contacts, *searchResults;
    NSMutableArray *contactsArray;
}

@end

@implementation ViewController
@synthesize searchTableView = _searchTableView;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self.navigationItem setTitle:@"Search Demo"];
    [self.navigationController.navigationBar setBackgroundColor:[UIColor grayColor]];
    [self initializeSearchControllerWithData];
}

-(void)initializeSearchControllerWithData{
//    userMutableArray = [[NSMutableArray alloc] initWithObjects:@"Jack",@"Julie", nil];
    
    contacts = @[@"Aakriti",@"Aamukta",@"Aanandita",@"Aarti",@"Abhaya",@"Bhaageerathi",@"Bhaargavi",@"Bhanu",@"Chandini",@"Chaaya",@"Damayanti",@"Deepika",@"Deepti",@"Divya",@"Ektaa",@"Esha",@"Fulki",@"Ganga",@"Gauri",@"Gautami",@"Geeta ",@"Hrishita",@"Indira",@"Indraja",@"Janaki",@"Jyotsana",@"Kalpana",@"Kamala",@"Kanchan Verma",@"Lakshmi",@"Lalitha",@"Madhavi",@"Madhu",@"Madhuri",@"Manju",@"Nandini",@"Nilima",@"Nirmala",@"Oormila",@"Padma",@"Parvati",@"Pooja",@"Priya",@"Radha",@"Raksha",@"Rishita",@"Sandhya",@"Saraswati",@"Savitri",@"Sharmila",@"Shobhana",@"Uma Shankar",@"Upasana",@"Vaishali",@"Yamuna",@"Women",@"Xanshai",@"Zampa",@"Zameera",@"Zain",@"Trisha",@"Queen",@"Vani",@"Vanaja"];
    contactsArray = [contacts mutableCopy];
    //NSLog(@"contactsArray : %@",contactsArray);
    self.searchController = [[UISearchController alloc]initWithSearchResultsController:nil];
    //self.searchController.searchBar.scopeButtonTitles = [[NSArray alloc]initWithObjects:@"UserId",@"JobTitle", nil];
    self.searchController.searchBar.delegate = self;
    self.searchController.searchResultsUpdater = self;
    [self.searchController.searchBar sizeToFit];
    self.searchController.dimsBackgroundDuringPresentation = NO;
    self.definesPresentationContext = YES;
    self.searchTableView.tableHeaderView = self.searchController.searchBar;
    
}


#pragma SearchController Delegate methods...

-(void)updateSearchResultsForSearchController:(UISearchController *)searchController{
 
    NSString *searchString = self.searchController.searchBar.text;
    if(searchString.length > 0){
        NSPredicate *resultPredicate;
        resultPredicate = [NSPredicate predicateWithFormat:@"SELF CONTAINS[c] %@",searchString];
        searchResults = [contacts filteredArrayUsingPredicate:resultPredicate];
        NSLog(@"After Search : %@",searchResults);
        [self.searchTableView reloadData];
    }
}
-(void)searchBar:(UISearchBar *)searchBar selectedScopeButtonIndexDidChange:(NSInteger)selectedScope{
    [self updateSearchResultsForSearchController:self.searchController];
}
-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar{
    
    NSLog(@"SearchController State : %d", self.searchController.active);
    searchResults = contacts;
    [self.searchTableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma TableView Delegate And DataSource Methods..
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSLog(@"Search Controller State : %d", self.searchController.active);
    if(self.searchController.active == 1){
        return  [searchResults count];
    }else{
        return [contactsArray count];
    }
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellID = @"ContactCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if(cell == nil){
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ContactCell"];
    }
    if(self.searchController.active ==1 ){
        cell.textLabel.text = [searchResults objectAtIndex:indexPath.row];
    }else{
        cell.textLabel.text = [contactsArray objectAtIndex:indexPath.row];
    }
    return cell;
}



@end
