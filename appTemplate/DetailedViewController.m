//
//  DetailedViewController.m
//  appTemplate
//
//  Created by Mac on 14/2/18.
//  Copyright (c) 2014年 Gocharm. All rights reserved.
//

#import "DetailedViewController.h"

@interface DetailedViewController ()

@end

@implementation DetailedViewController

@synthesize summaryText = _summaryText;
@synthesize addrText = _addrText;
@synthesize bodyText = _bodyText;
@synthesize data = _data;
@synthesize detailURL = _detailURL;
@synthesize docURL = _docURL;
@synthesize connection = _connection;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    //  init addrText component
    _addrText.layer.borderColor = [UIColor grayColor].CGColor;
    _addrText.layer.borderWidth = 1.0f;
    _addrText.layer.cornerRadius = 5.0f;
    //  init summaryText component
    _summaryText.layer.borderColor = [UIColor grayColor].CGColor;
    _summaryText.layer.borderWidth = 1.0f;
    _summaryText.layer.cornerRadius = 5.0f;
    //  init bodyText component
    _bodyText.layer.borderColor = [UIColor grayColor].CGColor;
    _bodyText.layer.borderWidth = 1.0f;
    _bodyText.layer.cornerRadius = 5.0f;
    //  set title of the view
    self.title = [_data valueForKey:coiResParams.title];
    //  prepare URL for detail info API
    _detailURL = [[NSString alloc] initWithFormat:@"%@/%@/%@", coiBaseURL, coiDetailURI, [_data objectForKey:coiResParams.geID]];
    //  prepare parameter of detail info API
    NSString *param = [[NSString alloc] initWithFormat:@"%@=%@&%@=1", coiReqParams.token, [[appUtil sharedUtil] token], coiReqParams.detail];
    //  get request of the API
    NSURLRequest *detailReq = [[appUtil sharedUtil] getHttpRequestByMethod:coiMethodGet toURL:_detailURL useData:param];
    //  create connection of the API
    _connection = [[NSURLConnection alloc] initWithRequest:detailReq delegate:self];
    [_connection setAccessibilityLabel:DETAIL_CONNECTION_LABEL];
}
/*
    receive data from connection
 */
- (void)connection:(NSURLConnection *)conn didReceiveData: (NSData *) incomingData
{
    //  parse JSON string to a dictionary

    NSDictionary *detailInfoDic = [NSJSONSerialization JSONObjectWithData:incomingData options:0 error:nil];
    //  process data received from detail info connection
    if ([[_connection accessibilityLabel] isEqualToString:DETAIL_CONNECTION_LABEL]) {
        //  process data from detail info connection
        if ([[detailInfoDic objectForKey:coiResParams.errCode] integerValue] == 0) {
            //  get data successed, check if detail info exists
            //  filled in addr
            _addrText.text = [[detailInfoDic objectForKey:coiResParams.value] objectForKey:coiResParams.addr];
            //  get ngID for retrieving associated document
            NSString *ngID =[[detailInfoDic objectForKey:coiResParams.value] objectForKey:coiResParams.ngID];
            if (ngID != nil) {
                //  this location has a document, create URL to get document with ngID
                _docURL = [[NSString alloc] initWithFormat:@"%@/%@/%@", coiBaseURL, coiDocURI,ngID];
                //  set param
                NSString *param = [[NSString alloc] initWithFormat:@"%@=%@&%@=%@", coiReqParams.token, [[appUtil sharedUtil] token], coiReqParams.appKey, coiAppKey];
                //  get request for retrieving document
                NSURLRequest *docRequest = [[appUtil sharedUtil] getHttpRequestByMethod:coiMethodGet toURL:_docURL useData:param];
                //  create connection
                _connection = [[NSURLConnection alloc] initWithRequest:docRequest delegate:self];
                [_connection setAccessibilityLabel:DOC_CONNECTION_LABEL];
            }
            else {
                //  no document, alert a message
                [[[UIAlertView alloc] initWithTitle:DETAIL_ERROR
                                            message:@"No accociated document!"
                                           delegate:nil
                                  cancelButtonTitle:@"Ok"
                                  otherButtonTitles:nil] show];
            }
        }
        else {
            //  failed to get data, alert a message
            [[[UIAlertView alloc] initWithTitle:DETAIL_ERROR
                                        message:[detailInfoDic objectForKey:coiResParams.message]
                                       delegate:nil
                              cancelButtonTitle:@"Ok"
                              otherButtonTitles:nil] show];
        }
    }
    //  process data received from doc connection
    if([[_connection accessibilityLabel] isEqualToString:DOC_CONNECTION_LABEL]) {
        if([[detailInfoDic objectForKey:coiResParams.errCode] integerValue] == 0){
            NSDictionary *doc = [detailInfoDic objectForKey:coiResParams.value];
            _summaryText.text = ([doc objectForKey:coiResParams.summary] != nil)? [doc objectForKey:coiResParams.summary]:@"N/A";
            _bodyText.text = ([doc objectForKey:coiResParams.body] != nil)?[doc objectForKey:coiResParams.body]:@"N/A";
        }
        else {
            //  failed to get data, alert a message
            [[[UIAlertView alloc] initWithTitle:DETAIL_ERROR
                                        message:[detailInfoDic objectForKey:coiResParams.message]
                                       delegate:nil
                              cancelButtonTitle:@"Ok"
                              otherButtonTitles:nil] show];
        }
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
