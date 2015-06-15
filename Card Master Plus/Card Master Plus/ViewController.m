//
//  ViewController.m
//  Card Master Plus
//
//  Created by yj on 15/6/15.
//  Copyright (c) 2015年 Yang Jing. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)buttonTapped:(id)sender {
    NSLog(@"buttonTapped");
    
    //Create the request
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://rss.cnn.com/rss/cnn_topstories.rss"]
                                             cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:30.0];
    
    //Create connection and send the request
    NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    
    //Make sure that connection is good
    if (connection) {
        //Instantiate the responseData data structure to store the response.
        self.responseData = [NSMutableData data];
    }
    else {
        NSLog(@"The Connection Failed");
    }
}

#pragma mark - Connection Routines

//Called when a redirect will cause the URL of the request to change.
- (NSURLRequest *)connection:(NSURLConnection *)connection
             willSendRequest:(NSURLRequest *)request
            redirectResponse:(NSURLResponse *)response
{
    NSLog(@"Connection:willSendRequest:redirectResponse:");
    return request;
}

//Called when the server requires authentication.
- (void)connection:(NSURLConnection *)connection
didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge
{
    NSLog(@"connection:didReciveAuthenticationChallenge");
}

//Called when the authentication challenge is cancelled on the connection.
- (void)connection:(NSURLConnection *)connection
didCancelAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge
{
    NSLog(@"connection:didCancelAuthenticationChallenge");
}

//Called when the connection has enough data to create an NSURLResponse.
- (void)connection:(NSURLConnection *)connection
didReceiveResponse:(NSURLResponse *)response {
    NSLog(@"connection:didReceiveResponse:");
    NSLog(@"expectedContentLength: %qi", [response expectedContentLength]);
    NSLog(@"textEncodingName: %@", [response textEncodingName]);
    
    [self.responseData setLength:0];
}

//Called each time the connection receives a chunk of data.
- (void)connection:(NSURLConnection *)connection
    didReceiveData:(NSData *)data
{
    NSLog(@"connection:didReceiveData:");
    
    //Apend the received data to the responseData property.
    [self.responseData appendData:data];
}

//Called before the response is cached.
- (NSCachedURLResponse *)connection:(NSURLConnection *)connection
                  willCacheResponse:(NSCachedURLResponse *)cachedResponse
{
    NSLog(@"connection:willCacheResponse:");
    //simply return the response to cache.
    return cachedResponse;
}

//Called when the connection has successfully received the complete response.
- (void) connectionDidFinishLoading:(NSURLConnection *)connection
{
    NSLog(@"connectionDidFinishLoading");
    
    //Convert the data to a string and log the response string.
    NSString *responseString = [[NSString alloc] initWithData:self.responseData
                                                     encoding:NSUTF8StringEncoding];
    NSLog(@"Response String: \n%@", responseString);
    
    [self parseXML];
}

//Called when an error occurs in loading the response.
- (void)connection:(NSURLConnection *)connection
  didFailWithError:(NSError *)error
{
    NSLog(@"connection:didFailWithError");
    
    NSLog(@"%@", [error localizedDescription]);
}

#pragma mark - Parser Routines
- (void) parseXML {
    NSLog(@"parseXML");
    
    //Initialize the parser with the NSData from the RSS feed.
    NSXMLParser *xmlParser = [[NSXMLParser alloc] initWithData:self.responseData];
    
    //Set the delegate to self.
    [xmlParser setDelegate:self];
    
    //Start the parser.
    if(![xmlParser parse])
    {
        NSLog(@"An error occurred in the parsing");
    }
}

//Called when the parser begins parsing the document.
- (void)parserDidStartDocument:(NSXMLParser *)parser {
    NSLog(@"parserDidStartDocument");
    self.inItemElement = NO;
    self.textView.text = nil;
}

//Called when the parser finishes parsing the document.
- (void)parserDidEndDocument:(NSXMLParser *)parser {
    NSLog(@"parserDidEndDocument");
}

//Called when the parser encounters a start element.
- (void)parser:(NSXMLParser *)parser
didStartElement:(NSString *)elementName
  namespaceURI:(NSString *)namespaceURI
 qualifiedName:(NSString *)qName
    attributes:(NSDictionary *)attributeDict
{
    NSLog(@"didStartElement");
    
    //Check to see which element you have found.
    if([elementName isEqualToString:@"item"])
    {
        //you are in an item element.
        self.inItemElement = YES;
    }
    
    //if you are inside an item element and found a title.
    if (self.inItemElement && [elementName isEqualToString:@"title"]) {
        //Initialize the capturedCharacters instance cariable.
        self.capturedCharacters = [[NSMutableString alloc] initWithCapacity:100];
    }
}

//Called when the parser encounters an end element.
- (void)parser:(NSXMLParser *)parser
 didEndElement:(NSString *)elementName
  namespaceURI:(NSString *)namespaceURI
 qualifiedName:(NSString *)qName
{
    NSLog(@"didEndElement");
    
    //Check to see which element you have been ended.
    
    //if you are inside an item element and ended title.
    if (self.inItemElement && [elementName isEqualToString:@"title"]) {
        NSLog(@"capturedCharacters:%@", self.capturedCharacters);
        
        self.textView.text = [self.textView.text stringByAppendingFormat:@"%@\n\n", self.capturedCharacters];
        
        //Clean up the capturedCharacters instance variable.
        self.capturedCharacters = nil;
    }
    
    if ([elementName isEqualToString:@"item"]) {
        //you are no longer inside an item element.
        self.inItemElement = NO;
    }
}

//Called when the parser finds characters contained within an element.
- (void)parser:(NSXMLParser *)parser
foundCharacters:(NSString *)string
{
    if (self.capturedCharacters != nil) {
        [self.capturedCharacters appendString:string];
    }
}

@end