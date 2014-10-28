//
//  secondCategoryViewController.m
//  NFLtrivia
//
//  Created by administrator on 08/10/14.
//
//

#import "secondCategoryViewController.h"
#import "SBJson.h"
#import "secondQuestionFinishedViewController.h"

#define selectedTeamSecondQuestionURL @"http://10.10.30.150/NFL/mobile/app.php?action=current_week_question"
#define selectedAnswersURL @"http://10.10.30.150/NFL/mobile/app.php?action=user_answer"
#define selectedForceCloseURL @"http://10.10.30.150/NFL/mobile/app.php?action=force_close"


NSString*typeOfQuestion;

int seconds ;
NSString * optionSecond = @"";

NSString *correct_ans;
NSString *option_A ;
NSString *option_B ;
NSString *option_C ;
NSString *option_D ;
NSString *question_id ;
NSString *question_name ;
NSString *time_used ;



@interface secondCategoryViewController ()

@end

@implementation secondCategoryViewController

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
    currentTime = 30000; // Since 75 hours = 270000000 milli seconds
    
    timer = [NSTimer scheduledTimerWithTimeInterval:.01 target:self selector:@selector(updateTimer:) userInfo:nil repeats:YES];
    
    typeOfQuestion = @"B";
    
  
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
    
    NSInteger levelmsg = 0;
    NSString *post =[[NSString alloc] initWithFormat:@"action=%s&team_id=%@&user_id=%@","current_week_question",self.photoId,self.userId];
    NSLog(@"PostData: %@",post);
    
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    
    NSString *postLength = [NSString stringWithFormat:@"%lu", (unsigned long)[postData length]];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    NSURL *url = [NSURL URLWithString:[selectedTeamSecondQuestionURL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    
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
                
                self.secondLabelA.text = option_A;
                self.secondLabelB.text = option_B;
                self.secondLabelC.text = option_C;
                self.secondLabelD.text = option_D;
                self.secondCategoryQuestion.text = question_name;
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
        
        [self performSegueWithIdentifier:@"secondQuestionFinished" sender:self];

        
        
    }
    
    
    
    result.text = result1;
    
    
}




-(void)forceClose
{
    
    
    NSInteger success = 0;
    
    NSInteger levelmsg = 0;
    NSString *post =[[NSString alloc] initWithFormat:@"action=%s&question_id=%@&answer_option=%@&team_id=%@&user_id=%@&answered_time=%@&type_of_question=%@","force_close",question_id,optionSecond,self.photoId,self.userId,result.text,typeOfQuestion];
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






- (IBAction)secondOptA:(id)sender {
    optionSecond = @"A";
    [self answerForTheQuestions];
    [timer invalidate];
    
    [self performSegueWithIdentifier:@"secondQuestionFinished" sender:self];

    
}

- (IBAction)secondOptB:(id)sender {
    
    optionSecond = @"B";
    [self answerForTheQuestions];
    [timer invalidate];
    
     [self performSegueWithIdentifier:@"secondQuestionFinished" sender:self];

}

- (IBAction)secondOptC:(id)sender {
    
    optionSecond = @"C";
    [self answerForTheQuestions];
    [timer invalidate];
    
     [self performSegueWithIdentifier:@"secondQuestionFinished" sender:self];
    

}

- (IBAction)secondOptD:(id)sender {
    
    optionSecond = @"D";
    [self answerForTheQuestions];
    [timer invalidate];
    
  [self performSegueWithIdentifier:@"secondQuestionFinished" sender:self];
    

}




-(void)answerForTheQuestions
{
    
    
    NSInteger success = 0;
    
    NSInteger levelmsg = 0;
    NSString *post =[[NSString alloc] initWithFormat:@"action=%s&question_id=%@&answer_option=%@&team_id=%@&user_id=%@&answered_time=%@&type_of_question=%@","user_answer",question_id,optionSecond,self.photoId,self.userId,result.text,typeOfQuestion];
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

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    
    if ([segue.identifier isEqualToString:@"secondQuestionFinished"]) {
        
      
    
    secondQuestionFinishedViewController *secondViewController = segue.destinationViewController;
    
    secondViewController.photoId = self.photoId;
    secondViewController.photoName = self.photoName;
    secondViewController.userId = self.userId;
    secondViewController.photoViewPro = self.photoViewPro;
   // secondViewController.directTeamId = self.directTeamId;
    
    [self dismissViewControllerAnimated:YES completion:nil];

    }
    
    
}










@end
