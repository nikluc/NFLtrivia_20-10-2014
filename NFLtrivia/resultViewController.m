//
//  resultViewController.m
//  NFLtrivia
//
//  Created by administrator on 13/10/14.
//
//

#import "resultViewController.h"
#import "SBJson.h"

#define selectedTeamResultURL @"http://10.10.30.150/NFL/mobile/app.php?action=results"
NSDictionary * airportAtIndex;

@interface resultViewController ()

@end

@implementation resultViewController
@synthesize myTableView,imageView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    [self mainView];
[myTableView reloadData];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    // Return the number of rows in the section.
    return [artArrayResultDetails count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier = @"resultCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:
                             cellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:
                UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    
    
    airportAtIndex = [artArrayResultDetails objectAtIndex:indexPath.row];
    
    NSLog(@"airport :%@",airportAtIndex);
    
    //UIImageView *background = [[UIImageView alloc] initWithFrame:CGRectMake(500, 50, 20, 20)];
    imageView=(UIImageView *)[cell viewWithTag:100];
    
    self.imageView.image = [UIImage imageWithData: [NSData dataWithContentsOfURL: [NSURL URLWithString: [airportAtIndex objectForKey:@"profile_pic"]]]];
    
    imageView.layer.cornerRadius = 15;
    imageView.layer.borderWidth = 2.0f;
    imageView.layer.borderColor = [UIColor blackColor].CGColor;
    imageView.clipsToBounds = YES;
    
    //[cell.contentView addSubview:background];
    
    
    
   NSInteger rankId = [(NSNumber *) [airportAtIndex objectForKey:@"rank"] integerValue];
    
    
    
  NSString* rankLists = [NSString stringWithFormat:@"%ld", (long)rankId];
    
    
    UILabel *label1 = (UILabel *)[cell viewWithTag:1];
    label1.text= rankLists;
    
    
    UILabel *label2 = (UILabel *)[cell viewWithTag:2];
    NSString *firname =[airportAtIndex objectForKey:@"first_name"];
    NSString *lasname =[airportAtIndex objectForKey:@"last_name"];
    NSString *name = [NSString stringWithFormat: @"%@ %@", firname, lasname];
    label2.text= name;
 
    return cell;
}





-(void)mainView
{
    
    
    NSInteger success = 0;
    
    NSInteger levelmsg = 0;
    NSString *post =[[NSString alloc] initWithFormat:@"action=%s","results"];
    NSLog(@"PostData: %@",post);
    
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    
    NSString *postLength = [NSString stringWithFormat:@"%lu", (unsigned long)[postData length]];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    NSURL *url = [NSURL URLWithString:[selectedTeamResultURL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    
    [request setURL:url];
    [request setHTTPMethod:@"POST"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:postData];
    
    //[NSURLRequest setAllowsAnyHTTPSCertificate:YES forHost:[url host]];
    
    NSError *error = [[NSError alloc] init];
    NSHTTPURLResponse *response = nil;
    NSData *urlData=[NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    
    NSLog(@"Response code: %ld", (long)[response statusCode]);
    if ([response statusCode] >=200 && [response statusCode] <300)
    {
        NSString* resData = [[NSString alloc]initWithData:urlData encoding:NSUTF8StringEncoding];
        NSLog(@"Response ==> %@", resData);
        
        SBJsonParser *jsonParser = [SBJsonParser new];
        NSDictionary *jsonData = (NSDictionary *) [jsonParser objectWithString:resData error:nil];
        NSLog(@"json data %@",jsonData);
        
        artArrayResultDetails = [jsonData objectForKey:@"rank_list"];
        
        success = [(NSNumber *) [jsonData objectForKey:@"success"] integerValue];
        levelmsg = [(NSNumber *) [jsonData objectForKey:@"level"] integerValue];
        NSLog(@"successs value %ld",(long)success);
        if(success == 1)
        {
            NSLog(@"successssssss!");
            NSLog(@"arr%@",artArrayResultDetails);
            
            
            
            for (NSDictionary *photo in artArrayResultDetails)
            {
                
                
        //        correct_ans = [photo objectForKey:@"correct_ans"];
                
        
            }
        }
        
        
        
        
        
    } else {
        
        NSLog(@"Login FAILED");
    }
    
    
}



- (void) alertStatus:(NSString *)msg :(NSString *)title
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title
                                                        message:msg
                                                       delegate:self
                                              cancelButtonTitle:@"Ok"
                                              otherButtonTitles:nil, nil];
    
    [alertView show];
}




- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
