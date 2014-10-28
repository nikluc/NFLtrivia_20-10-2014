//
//  firstCategoryDuplicateViewController.m
//  NFLtrivia
//
//  Created by administrator on 10/10/14.
//
//

#import "firstCategoryDuplicateViewController.h"
#import "SBJson.h"
#import "logosCollectionViewController.h"
#import "secondCategoryViewController.h"
#import "secondQuestionFinishedViewController.h"
#import "resultViewController.h"

#define selectPlayerLevelURL @"http://10.10.30.150/NFL/mobile/app.php?action=signup"


NSInteger intTeamId;
@interface firstCategoryDuplicateViewController ()

@end

@implementation firstCategoryDuplicateViewController

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
    
    [self.navigationController setNavigationBarHidden:YES];
    [self mainView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)mainView
{
    
    
    NSInteger success = 0;
    
    NSInteger levelmsg1 = 0;
    NSInteger levelmsg2 = 0;
    NSInteger levelmsg3 = 0;
    NSInteger levelmsg4 = 0;
   
    
    NSString *post =[[NSString alloc] initWithFormat:@"action=%s&unique_id=%@&profile_pic_url=%@&first_name=%@&last_name=%@","signup",self.userId,self.profileUrl,self.firstName,self.lastName];
     NSLog(@"PostData: %@",post);
    
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    
    NSString *postLength = [NSString stringWithFormat:@"%lu", (unsigned long)[postData length]];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    NSURL *url = [NSURL URLWithString:[selectPlayerLevelURL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    
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
        
        //  artArrayDoctorList = [jsonData objectForKey:@"doctors"];
        success = [(NSNumber *) [jsonData objectForKey:@"success"] integerValue];
        levelmsg1 = [(NSNumber *) [jsonData objectForKey:@"level"] integerValue];
        levelmsg2 = [(NSNumber *) [jsonData objectForKey:@"level"] integerValue];
        levelmsg3 = [(NSNumber *) [jsonData objectForKey:@"level"] integerValue];
        levelmsg4 = [(NSNumber *) [jsonData objectForKey:@"level"] integerValue];
        
        intTeamId = [(NSNumber *) [jsonData objectForKey:@"team_id"] integerValue];
        
        
       
        self.photoId = [NSString stringWithFormat:@"%ld", (long)intTeamId];
        self.photoName =[jsonData objectForKey:@"team_name"];
        self.photoViewPro =[jsonData objectForKey:@"team_logo"];
        
        NSLog(@"successs value %ld",(long)success);
        if(success == 1)
        {
            NSLog(@"successssssss!");
            
            //  [self performSegueWithIdentifier:@"firstCategory" sender:self];
        }
        
        if (levelmsg1 == 1) {
            [self.chooseFavourites setHidden:NO];
            [self.favouriteTeam setHidden:NO];
            
          
         
            [self.secondQuestion setHidden:YES];
            [self.secondQuestions setHidden:YES];
         
            [self.thirdQuestion setHidden:YES];
            [self.thirdQuestions setHidden:YES];
         
            [self.resultPage setHidden:YES];
           
            
            
         
            //[self performSegueWithIdentifier:@"firstCategory" sender:self];
            
        }
        if (levelmsg2 == 2) {
            
            
            [self.chooseFavourites setHidden:YES];
            [self.favouriteTeam setHidden:YES];
            
            
            
            [self.secondQuestion setHidden:NO];
            [self.secondQuestions setHidden:NO];
            
            [self.thirdQuestion setHidden:YES];
            [self.thirdQuestions setHidden:YES];
            
            [self.resultPage setHidden:YES];
            
         
            
        }
        if (levelmsg3 == 3) {
            
            
            
            [self.chooseFavourites setHidden:YES];
            [self.favouriteTeam setHidden:YES];
            
           
            
            [self.secondQuestion setHidden:YES];
            [self.secondQuestions setHidden:YES];
            
            [self.thirdQuestion setHidden:NO];
            [self.thirdQuestions setHidden:NO];
            
            [self.resultPage setHidden:YES];
            
        
            
        }
        if (levelmsg4 == 4) {
       
            
            [self.chooseFavourites setHidden:YES];
            [self.favouriteTeam setHidden:YES];
            
          
            
            [self.secondQuestion setHidden:YES];
            [self.secondQuestions setHidden:YES];
            
            [self.thirdQuestion setHidden:YES];
            [self.thirdQuestions setHidden:YES];
            
            [self.resultPage setHidden:NO];
            
            
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





- (IBAction)favouriteTeam:(id)sender {
    
    
    [self performSegueWithIdentifier:@"logosCollection" sender:self];
    

    
}


- (IBAction)secondQuestion:(id)sender {
     [self performSegueWithIdentifier:@"directSecondQuestion" sender:self];
}

- (IBAction)thirdQuestion:(id)sender {
     [self performSegueWithIdentifier:@"directThirdQuestion" sender:self];
}

- (IBAction)resultPage:(id)sender {
    [self performSegueWithIdentifier:@"directResultPage" sender:self];
}



- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    
    if ([segue.identifier isEqualToString:@"logosCollection"]) {
        
        logosCollectionViewController *secondViewController = segue.destinationViewController;
        
        
       
        secondViewController.userId = self.userId;
        
        
    [self dismissViewControllerAnimated:YES completion:nil];}
    
    
    else if ([segue.identifier isEqualToString:@"directSecondQuestion"]) {
        
        
        secondCategoryViewController *secondViewController = segue.destinationViewController;
        
       secondViewController.photoId = self.photoId;
        secondViewController.photoName = self.photoName;
        secondViewController.userId = self.userId;
        secondViewController.photoViewPro = self.photoViewPro;
      //  secondViewController.directTeamId = directTeamId;
        [self dismissViewControllerAnimated:YES completion:nil];
        
    }

    else if ([segue.identifier isEqualToString:@"directThirdQuestion"]) {
        
        
        secondQuestionFinishedViewController *secondViewController = segue.destinationViewController;
        
       secondViewController.photoId = self.photoId;
        secondViewController.photoName = self.photoName;
        secondViewController.userId = self.userId;
        secondViewController.photoViewPro = self.photoViewPro;
    //  secondViewController.directTeamId = directTeamId;
        [self dismissViewControllerAnimated:YES completion:nil];
        
    }

  
    
    else if ([segue.identifier isEqualToString:@"directResultPage"]) {
        
        
        resultViewController *secondViewController = segue.destinationViewController;
        
      secondViewController.photoId = self.photoId;
        secondViewController.photoName = self.photoName;
        secondViewController.userId = self.userId;
        secondViewController.photoViewPro = self.photoViewPro;
      //   secondViewController.directTeamId = directTeamId;
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    
    
    
}



@end
