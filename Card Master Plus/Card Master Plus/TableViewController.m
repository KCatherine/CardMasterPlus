//
//  TableViewController.m
//  Card Master Plus
//
//  Created by yj on 15/4/6.
//  Copyright (c) 2015年 Yang Jing. All rights reserved.
//

#import "TableViewController.h"
#import "CardInformationViewController.h"

@interface TableViewController ()

@end

@implementation TableViewController

@synthesize cards;

-(void)setcards:(id)cardResults
{
    if(cards != cardResults)
        cards = cardResults;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    // Return the number of rows in the section.
    return [self.cards count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"ListPrototypeCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier
                                                            forIndexPath:indexPath];
    
    if(cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle
                                      reuseIdentifier:CellIdentifier];
    }
    
    // Configure the cell...
    
    CardInformation *card = [self.cards objectAtIndex:[indexPath row]];
    cell.textLabel.text = card.cardname;
    if(![card.attack isEqual: @""])
        cell.detailTextLabel.text = [NSString stringWithFormat:@"[%@] %@属性 %@族\
                                     ★:%@ ATK:%@  DEF:%@",card.kind, card.property,
                                     card.race, card.starORrank, card.attack, card.defense];
    else
        cell.detailTextLabel.text = [NSString stringWithFormat:@"[%@]",card.kind];
    
    
    NSString *filePath = [[NSBundle mainBundle] pathForResource:card.ID
                                                         ofType:@"jpg"
                                                    inDirectory:@"pic"];
    if(filePath)
    {
        UIImage *image = [UIImage imageWithContentsOfFile:filePath];
        cell.imageView.image = image;
    }
    
    return cell;
}



// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return NO;
}


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


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([[segue identifier] isEqualToString:@"Search"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
            [[segue destinationViewController] setDetailCard:self.cards[indexPath.row]];
        }
}


@end
