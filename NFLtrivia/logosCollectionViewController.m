//
//  logosCollectionViewController.m
//  NFLtrivia
//
//  Created by administrator on 11/09/14.
//
//

#import "logosCollectionViewController.h"
#import "myCell.h"
#import "individualLogoViewController.h"


#import "SBJson.h"
NSDictionary *airportAtIndex;

NSString *teamLogo;
NSString *teamId;
NSString *teamName;



#define selectTeamLogosURL @"http://10.10.30.150/NFL/mobile/app.php?action=team_list"


@interface logosCollectionViewController ()

@end

@implementation logosCollectionViewController


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
  

        [self logosFromApi];
    
    

[self.navigationController setNavigationBarHidden:YES];
  
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
  
}


-(void)logosFromApi
{
    
    NSInteger success = 0;
    NSInteger errormsg = 0;
    NSString *post =[[NSString alloc] initWithFormat:@"action=%s","team_list"];
  //  NSLog(@"PostData: %@",post);
    
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    
    NSString *postLength = [NSString stringWithFormat:@"%lu", (unsigned long)[postData length]];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    NSURL *url = [NSURL URLWithString:[selectTeamLogosURL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    
    
    
    
    
    
    [request setURL:url];
    [request setHTTPMethod:@"POST"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:postData];
    
    
 
    
    
   // [NSURLRequest setAllowsAnyHTTPSCertificate:YES forHost:[url host]];
    
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
        NSLog(@"%@",jsonData);
        
        //  artArrayDoctorList = [jsonData objectForKey:@"doctors"];
        success = [(NSNumber *) [jsonData objectForKey:@"success"] integerValue];
        errormsg = [(NSNumber *) [jsonData objectForKey:@"error"] integerValue];
        NSLog(@"%ld",(long)success);
        if(success == 1)
        {
            
            NSLog(@"sfsdfsdfsdfsdfsd");
            
          artArrayTeamList = [jsonData objectForKey:@"team_details"];
     
      //      NSLog(@"arrayyyyy list :%@",artArrayTeamList);
            
             for (NSDictionary *photo in artArrayTeamList)
             {
             
             
             NSString *title = [photo objectForKey:@"team_logo"];
             NSLog(@"email ... : %@",title);
             }
             
            
        }
        else{
            NSLog(@"faileeeeddd");
        }
        
        if (errormsg == 1) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Doctors not available in this locality!"
                                                            message:@""
                                                           delegate:nil
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil];
            [alert show];
            
        }
        
        
        
        
    } else {
        
        NSLog(@"Login FAILED");
    }
    


}
                     

                     
                     

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL) prefersStatusBarHidden {
    return YES;
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return artArrayTeamList.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    myCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"logoCell" forIndexPath:indexPath];
    airportAtIndex = [artArrayTeamList objectAtIndex:indexPath.row];
 
    
    
  //  UIImageView *background = [[UIImageView alloc] initWithFrame:CGRectMake(500, 50, 20, 20)];
    imageView=(UIImageView *)[cell viewWithTag:1];
    
     imageView.image = [UIImage imageWithData: [NSData dataWithContentsOfURL:[NSURL URLWithString: [airportAtIndex objectForKey:@"team_logo"]]]];
  
    //imageView.layer.cornerRadius = 15;
   imageView.layer.borderWidth = 2.0f;
    imageView.layer.borderColor = [UIColor cyanColor].CGColor;
   // imageView.clipsToBounds = YES;
    //[cell.contentView addSubview:background];
    return cell;
}


-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath  {

    NSDictionary*test = [artArrayTeamList objectAtIndex:indexPath.row];;
    
    teamLogo =[test objectForKey:@"team_logo"];
    teamId =[test objectForKey:@"team_id"];
    teamName =[test objectForKey:@"team_name"];
    NSLog(@"nameS: %@ ...", teamLogo);

    [self performSegueWithIdentifier:@"individualLogo" sender:self];
    

   
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    
   if ([segue.identifier isEqualToString:@"individualLogo"]) {
        
        
        individualLogoViewController *verifyViewController = segue.destinationViewController;
        
        

        verifyViewController.photoViewPro = teamLogo;
        verifyViewController.photoId = teamId;
        verifyViewController.userId = self.userId;
       verifyViewController.photoName = teamName;
           }

}


@end
