//
//  ViewController.m
//  ShoppingList
//
//  Created by Admin on 19/7/15.
//  Copyright (c) 2015 Clarence. All rights reserved.
//

#import "ViewController.h"
#import "List.h"


@interface ViewController () <UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UITextField *shopList;
@property NSMutableArray *shopListArray;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"List" inManagedObjectContext:self.managedObjectContext];
    
    [fetchRequest setEntity:entity];
    
    self.shopListArray = [NSMutableArray arrayWithArray:[self.managedObjectContext executeFetchRequest:fetchRequest error:nil]];
//    self.shopListArray = [self.managedObjectContext executeFetchRequest:fetchRequest error:nil];


}


- (IBAction)onSaveButtonPressed:(UIButton *)sender {
    
//    self.shopListArray = [NSMutableArray arrayWithObject:[self.shopList text]];
    
//    for (NSMutableArray *eachArray in self.shopListArray){
    
        NSManagedObject *list = [NSEntityDescription insertNewObjectForEntityForName:@"List" inManagedObjectContext:self.managedObjectContext];
        //This is how you get a reference to the entity so that you can fill details to the entity and add to the managedObjectContext
        
        //        NSString *name = [eachDictionary objectForKey:@"name"];
        //        [movie setValue:name forKey:@"name"];
        

        
        [list setValue:self.shopList.text forKey:@"name"];

        [self.managedObjectContext save:nil];
    [self.shopListArray addObject:list];
    [self.tableView reloadData];
    
    }
    

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.shopListArray.count;

//    return self.movieArray.count;

}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MyCell" forIndexPath:indexPath];
    
    NSManagedObject *fetchObject = [self.shopListArray objectAtIndex:indexPath.row];
    
    cell.textLabel.text = [fetchObject valueForKey:@"name"];
    
    return cell;
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
