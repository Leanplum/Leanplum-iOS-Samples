//
//  InboxTableViewController.m
//  basicSetup
//
//  Created by Matthew Bell on 5/24/17.
//  Copyright © 2017 Federico Casali. All rights reserved.
//

#import "InboxTableViewController.h"
#import <Leanplum/Leanplum.h>

@interface InboxTableViewController ()

@end

@implementation InboxTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    LPInbox *inbox = [Leanplum inbox];
    
    [inbox onChanged:^(){

        self.inboxMessages = [[inbox allMessages] mutableCopy];

        // Re-sort the messages to newest first.
        [self.inboxMessages sortUsingComparator:^NSComparisonResult(id  obj1, id obj2) {
            NSDate *first = [(LPInboxMessage*) obj1 deliveryTimestamp];
            NSDate *second = [(LPInboxMessage*) obj2 deliveryTimestamp];
            return [second compare:first];
        }];
        
        [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:0]
                      withRowAnimation:UITableViewRowAnimationAutomatic];
    }];
    
    // Hide unused cell lines from tableview with an overlapping view.
    self.tableView.tableFooterView = [UIView new];
    
}

- (void)viewWillAppear:(BOOL)animated{
    [self.navigationController setNavigationBarHidden:NO animated:animated];
    [super viewWillAppear:animated];
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
    return [[Leanplum inbox] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"InboxMessageCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if(cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle
                                      reuseIdentifier:cellIdentifier];
    }
    
    // Get the Inbox message for this table row.
    long row = [indexPath row];
    LPInboxMessage *message = self.inboxMessages[row];
    
    // Get and set the text in the table cell.
    NSString *messageTitle = [message title];
    NSString *messageSubtitle = [message subtitle];
    [[cell textLabel] setText:messageTitle];
    [[cell detailTextLabel] setText:messageSubtitle];
    
    // Set the cell image, if there is one.
    cell.imageView.image = [UIImage imageWithContentsOfFile:[message imageFilePath]];
    
    // Set the text style for read and unread messages.
    if([message isRead]){
        [[cell textLabel] setTextColor:[UIColor lightGrayColor]];
        [[cell detailTextLabel] setTextColor:[UIColor lightGrayColor]];
    } else {
        [[cell textLabel] setTextColor:[UIColor blackColor]];
        [[cell detailTextLabel] setTextColor:[UIColor blackColor]];
    }
    
    return cell;
}


// Override to support conditional editing of the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if(editingStyle == UITableViewCellEditingStyleDelete){
        // Delete the message.
        [self.inboxMessages[indexPath.row] remove];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Mark and track the message as read.
    [self.inboxMessages[indexPath.row] read];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
