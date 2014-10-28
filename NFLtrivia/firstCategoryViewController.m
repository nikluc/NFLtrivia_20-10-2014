//
//  firstCategoryViewController.m
//  NFLtrivia
//
//  Created by administrator on 17/09/14.
//
//

#import "firstCategoryViewController.h"
#import "SBJson.h"
#import "firstQuestionFinishedViewController.h"

#define selectedTeamURL @"http://10.10.30.150/NFL/mobile/app.php?action=team_question"
#define selectedAnswersURL @"http://10.10.30.150/NFL/mobile/app.php?action=user_answer"
#define selectedForceCloseURL @"http://10.10.30.150/NFL/mobile/app.php?action=force_close"



int seconds ;
NSString * optionS = @"";

NSString *correct_ans;
NSString *option_A ;
NSString *option_B ;
NSString *option_C ;
NSString *option_D ;
NSString *question_id ;
NSString *question_name ;
NSString *time_used ;
NSString *typeOfQuestion ;

@interface firstCategoryViewController ()

@end

@implementation firstCategoryViewController
@synthesize photoId,userId;

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

}



- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    currentTime = 30000; // Since 75 hours = 270000000 milli seconds
    
    timer = [NSTimer scheduledTimerWithTimeInterval:.01 target:self selector:@selector(updateTimer:) userInfo:nil repeats:YES];
     typeOfQuestion = @"A";
   
        [self mainView];
  
    
    
    
   
    NSLog(@"firstcategory photoname :%@",self.photoName);
}




- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}





-(void)mainView
{
    
    
    NSInteger success = 0;
    
    NSInteger levelmsg = 0;
    NSString *post =[[NSString alloc] initWithFormat:@"action=%s&team_id=%@&user_id=%@","team_question",photoId,userId];
    NSLog(@"PostData: %@",post);
    
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    
    NSString *postLength = [NSString stringWithFormat:@"%lu", (unsigned long)[postData length]];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    NSURL *url = [NSURL URLWithString:[selectedTeamURL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    
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
        
        artArrayQuestionDetails = [jsonData objectForKey:@"question_details"];
       
        success = [(NSNumber *) [jsonData objectForKey:@"success"] integerValue];
        levelmsg = [(NSNumber *) [jsonData objectForKey:@"level"] integerValue];
        NSLog(@"successs value %ld",(long)success);
        if(success == 1)
        {
            NSLog(@"successssssss!");
            NSLog(@"arr%@",artArrayQuestionDetails);
            
          

            for (NSDictionary *photo in artArrayQuestionDetails)
            {
                
                
              correct_ans = [photo objectForKey:@"correct_ans"];
               option_A = [photo objectForKey:@"option_A"];
                option_B = [photo objectForKey:@"option_B"];
                option_C = [photo objectForKey:@"option_C"];
                option_D = [photo objectForKey:@"option_D"];
                 question_id = [photo objectForKey:@"question_id"];
                 question_name = [photo objectForKey:@"question_name"];
                 time_used = [photo objectForKey:@"time_used"];
                
                
                
                NSLog(@"corr ans ... : %@",correct_ans);
                  NSLog(@"op a... : %@",option_A);
                  NSLog(@"op b ... : %@",option_B);
                  NSLog(@"op c ... : %@",option_C);
                  NSLog(@"op d ... : %@",option_D);
                  NSLog(@"id ... : %@",question_id);
                  NSLog(@"quest ... : %@",question_name);
                  NSLog(@"time ... : %@",time_used);
                
                optA.text = option_A;
                optB.text = option_B;
                optC.text = option_C;
                optD.text = option_D;
                questionOne.text = question_name;
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





-(IBAction)optionA{
    
   
    optionS = @"A";
     [self answerForTheQuestions];
     [timer invalidate];
    
    firstQuestionFinishedViewController *secondViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"firstQuestionCompleted"];
    secondViewController.photoId = photoId;
    secondViewController.photoName = self.photoName;
    secondViewController.userId = self.userId;
    secondViewController.photoViewPro = self.photoViewPro;
    //secondViewController.directTeamId = self.directTeamId;
    [self.navigationController pushViewController:secondViewController animated:YES];
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(IBAction)optionB{
    
    optionS= @"B";
    [self answerForTheQuestions];
     [timer invalidate];
    firstQuestionFinishedViewController *secondViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"firstQuestionCompleted"];
    secondViewController.photoId = photoId;
    secondViewController.photoName = self.photoName;
    secondViewController.userId = self.userId;
    secondViewController.photoViewPro = self.photoViewPro;
  //  secondViewController.directTeamId = self.directTeamId;
    [self.navigationController pushViewController:secondViewController animated:YES];
    [self dismissViewControllerAnimated:YES completion:nil];
    

}

-(IBAction)optionC{
   
    optionS= @"C";
    [self answerForTheQuestions];
    
     [timer invalidate];
    firstQuestionFinishedViewController *secondViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"firstQuestionCompleted"];
    secondViewController.photoId = photoId;
    secondViewController.photoName = self.photoName;
    secondViewController.userId = self.userId;
    secondViewController.photoViewPro = self.photoViewPro;
  //  secondViewController.directTeamId = self.directTeamId;
    [self.navigationController pushViewController:secondViewController animated:YES];
    [self dismissViewControllerAnimated:YES completion:nil];

}

-(IBAction)optionD{
   
    optionS = @"D";
    [self answerForTheQuestions];
     [timer invalidate];
    
    firstQuestionFinishedViewController *secondViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"firstQuestionCompleted"];
    secondViewController.photoId = photoId;
    secondViewController.photoName = self.photoName;
    secondViewController.userId = self.userId;
    secondViewController.photoViewPro = self.photoViewPro;
  //  secondViewController.directTeamId = self.directTeamId;
    [self.navigationController pushViewController:secondViewController animated:YES];
    [self dismissViewControllerAnimated:YES completion:nil];

}

-(void)answerForTheQuestions
{
    
    
    NSInteger success = 0;
    
    NSInteger levelmsg = 0;
    NSString *post =[[NSString alloc] initWithFormat:@"action=%s&question_id=%@&answer_option=%@&team_id=%@&user_id=%@&answered_time=%@&type_of_question=%@","user_answer",question_id,optionS,photoId,userId,result.text,typeOfQuestion];
    NSLog(@"PostData: %@",post);
    
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    
    NSString *postLength = [NSString stringWithFormat:@"%lu", (unsigned long)[postData length]];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    NSURL *url = [NSURL URLWithString:[selectedAnswersURL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    
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
        
        
        success = [(NSNumber *) [jsonData objectForKey:@"success"] integerValue];
        levelmsg = [(NSNumber *) [jsonData objectForKey:@"level"] integerValue];
        NSLog(@"successs value %ld",(long)success);
        if(success == 1)
        {
            NSLog(@"success answer");
        }
        
        
        
        
        
    } else {
        
        NSLog(@"Login FAILED");
    }
    
    
}

-(void)forceClose
{
    
    
    NSInteger success = 0;
    
    NSInteger levelmsg = 0;
    NSString *post =[[NSString alloc] initWithFormat:@"action=%s&question_id=%@&answer_option=%@&team_id=%@&user_id=%@&answered_time=%@&type_of_question=%@","force_close",question_id,optionS,photoId,userId,result.text,typeOfQuestion];
    NSLog(@"PostData: %@",post);
    
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    
    NSString *postLength = [NSString stringWithFormat:@"%lu", (unsigned long)[postData length]];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    NSURL *url = [NSURL URLWithString:[selectedAnswersURL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    
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
        
        
        success = [(NSNumber *) [jsonData objectForKey:@"success"] integerValue];
        levelmsg = [(NSNumber *) [jsonData objectForKey:@"level"] integerValue];
        NSLog(@"successs value %ld",(long)success);
        if(success == 1)
        {
            NSLog(@"success force closeeeeeeee!");
        }
        
        
        
        
        
    } else {
        
        NSLog(@"Login FAILED");
    }
    
    
}







- (void)updateTimer:(NSTimer *)timer {
        currentTime -= 10 ;

    [self populateLabelwithTime:currentTime];
}



- (void)populateLabelwithTime:(int)milliseconds {
    seconds = milliseconds/1000;
    int minutes = seconds / 60;
  //  int hours = minutes / 60;
    
    seconds -= minutes * 60;
   // minutes -= hours * 60;
    
    NSString * result1 = [NSString stringWithFormat:@"%@%02d:%02d:%02d", (milliseconds<0?@"":@""),  minutes, seconds,milliseconds%1000];
    if (seconds==0  && milliseconds==0 ) {
        [timer invalidate];
        currentTime = 30000;
        
         [self forceClose];
        
        firstQuestionFinishedViewController *secondViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"firstQuestionCompleted"];
        [self.navigationController pushViewController:secondViewController animated:YES];
        secondViewController.photoId = photoId;
         secondViewController.photoName = self.photoName;
         secondViewController.userId = self.userId;
         secondViewController.photoViewPro = self.photoViewPro;
     //   secondViewController.directTeamId = self.directTeamId;
         [self dismissViewControllerAnimated:YES completion:nil];

    }
  
    

    result.text = result1;
   
    
}

@end
