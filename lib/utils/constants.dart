

///  This is API Hard coded strings. 
const String grantTypePassword = "password";
const String grantTypeRefreshToken = "refresh_token";

// Staging credentials
 const String stagingClientId = "2ENPfeT9ws2FjG3ABMw-hqCuWXpHDPh--nVlawszSyI";
 const String stagingClientSecret = "hbCFJNQ6-lXU47NM1yf-KGMeC4tTZVaOscVMf9S40M8";
 const String stagingBaseUrl = "http://feedback-staging-alb-818086335.us-east-2.elb.amazonaws.com/";

// Production credentials
const String productionClientId = "RkJ0cVJ6NRXd3PyxmQ3no32n3cBv2ChRfVhgMNi0dgo";
const String productionClientSecret = "g4oSCXAGbpJiJ9i-fCg2EuCpMNCbtYl1NIp1g7CtwJs";
const String productionBaseUrl = "http://feedback-production-alb-314267296.us-east-2.elb.amazonaws.com/";


const int resendTime = 30;
const int nameInitLength = 2;


// this is for shared preference's key's
const String loginTokenResponse = "login_token_response";
const String prepareCallResponse = "prepare_call_responce";

const String barearToken = "barear_token";
const String noDataFound = "No data found!";
const String historyOneOnOnes = "history";
const String upcomingOneOnOnes = "upcoming";

///  This is for Screen level Hard coded strings. 

// This is OTP SCREEN Strings
const String txtLogin = "Login";
const String verifyYourEmail = "Verify Your Email";
const String enterCodeSentTo = "Enter the code we sent to";
const String errorEnterValidOTP= "Please enter a valid OTP";
const String confirm = "Confirm";
const String haveNotReceivedCodeYet = "Haven't received the code yet? ";
const String resend = "Resend";
// End of OTP Screen


// Login SCREEN Strings
const String enterYourEmailText = "Enter Your Work Email";  
const String sendConfirmationCodeText = "We'll send you a confirmation code.";
const String enterValidEmailText = "Please enter valid email";
const String inValidUserText =  "Invalid user credentials";
const String uberMoveFont = "UberMove";
const String environmentId = "environmentsData";
const String enterEmailHintText = "Enter email";
// End of Login Screen

// 1-on-1 Screen Strings
const String selectEmployeeText = "Select Employee";
const String searchEmployeeText = "Search Employee";
const String dateText = "Date";
const String startTimeText = "Start Time";
const String endTimeText = "End Time";
const String notesText = "Notes";
const String notesHintText = "Start typing here...";
const String repeatText = "Repeat?";
const String doesNotRepeatText = "Does not repeat";
const String createText = "Create";
const String selectEmployeeValidationText = "Select the employee to create";
const String meetingSuccessDescriptionText = "We have sent an email to your employee regarding the 1-on-1 meeting. Wishing you a productive meeting!";

// End of 1-on-1 Screen

// Create Employee Screen Strings
const String name = "Name";
const String dummyName = "Charles Leclerc";
const String role = "Role";
const String dummyRole = "Software Engineer..";
const String empId = "Emp ID";
const String dummyEmpId = "EMP0001";
const String emailId = "Email ID";
const String dummyEmailId = "xyz@prasthana.com";
const String mobileNumber = "Mobile Number";
const String dummyMobileNumber = "9876543210";
const String selectReportingManager = "Select Reporting Manager";
const String serachManager = "Search Manager";
const String screenDiscription = "We will send an invite link to the member’s mail to login.";
const String add = "Add";
const String nameValidMsg = "Enter valid Name";
const String roleValidMsg ="Enter valid Role";
const String empIdValidMsg = "Enter valid Emp ID";
const String mobileValidMsg = "Enter valid Mobile number";

// End of Create Employee Screen

// 1-1 List SCREEN Strings
const String oneOneOnScreenTitle = "Schedule";
const String upcoming = "Upcoming";
const String history = "History";

// Reprorting Team SCREEN Strings
const String reportingTeamTitle = "Reporting Team";
const String addEmployee = "Add Employee";
const String noDataAvailable= "No data available";
const String noEmployeeAdded= "No Employees Added";
const String addEmployeeMsg= "You can add employees by clicking on the plus icon below.";
const String addMobileNumber= "Add Mobile Number";
const String settings = "Settings";
const String sendEmail = "Send email";
const String create1On1 = "    Create 1 on 1";
const String camera = "Camera";
const String gallery = "Gallery";
const String delete = "Delete";
const String profilePicture= "  Profile Picture";
const String openYetToImprove = "open Yet to Improve";
const String oneOnOneHistory = "1-on-1 History";
const String appLock = "App Lock";
const String logOut = "Log Out";
// End of Reporting Team

// Logout AlertDialog Strings
const String logoutDialogText = "Are you sure you want to logout from this device?";
const String yes = "Yes";
const String cancel = "Cancel";
// End of Logout AlertDialog Strings


// Biometric View Strings
const String faceIDUnlock = 'Use faceID to unlock';
const String biometricUnlock = 'Use biometric to unlock';
const String biometricHintText = 'to continue the App';
const String biometricNotEnable = "Security credentials not available.";
const String biometricNotEnableAlertText = "Biometric authentication is not set up on your device. Please set up the biometric authentication to continue the App";
const String environmentUpdatedHindText = "Please restrat the App, To get the updated environment changes";
const String environmentSetup = "Environment setup";
const String stagingText = "Staging";
const String productionText = "Production";
// Biometric View Strings


// update oneOneOne screen strings
const String okButton = "Ok";
const String save = "Save";
const String goodAtTitleText = "Good At";
const String yetToImproveTitleText = "Yet to Improve";
const String validationAlertText = "Good at/Yet to Improve points will not be saved";
const String yourRatingText = "Your Rating : ";
const String ratingCount = "5.0 ";
const String ratingText = "Rating :";
const String pointGoodAtType = "pt_good_at";
const String pointYetToImproveType = "pt_yet_to_improve";
const String addPoints = "+ Add point";
const String yetToImprovePoints = "Yet To Improve points";
const String clickToAddPoints = "Click on + to add ";
const String notAvailableText = "not available";
const String goodAtPointsText = "Good At points";
const String intialRatingCount = "0.0";
// End of update oneOneOne screen strings

// Upcoming and hisory screen strings
const String invalidEmployee = "Invalid Employee";
const String noOneOnOneScheduled = "No 1-on-1 Meetings scheduled";
const String clickOnCalendarText = "You can create a 1-on-1 meeting by clicking on the calendar icon below.";
// End Upcoming and hisory screen strings

// oneOnOne Success screen strings
const String doneButtonText = "Done";
const String oneOnOneWithText = "1-on-1 with ";
const String forText = " for ";
const String atText = " at ";
const String createdText = " created";
// End oneOnOne Success screen strings

// create oneOnOne screen strings
const String oneOnOneText = "1-on-1";
const String yourmanagerText = "Your Manager";
// End create oneOnOne screen strings

// Date and time formats strings
const String timeFormat = "hh:mm a";
const String dateFormat = "EEEE, dd MMM yyyy";
// End Date and time formats strings

// Employee details screen strings
const String selectEmail = "Select email app to open";
const String noTokenText = "No TOKEN";
const String openMail = "Open Mail App";
const String noMailAppInstalled = "No mail apps installed";
// End Employee details screen strings

// settings screen strings
const String logout = "Logout";


