
# Trinity Automation Framework


#### Features:

* API Rest testing
* Fancy HTML reports
* Supports Oracle, SQL Server, MySQL, Posgres and MongoDB databases connections 
* Appium support for mobile testing
* Support testing in Chrome, Edge, Firefox and Safari
* Built in email client
* Built in Zapi client 
* Support for csv, xlsx, xlsx and odt spreadsheets files
* Multi platform

#### Suported web browsers
Trinity Framework supports the most used web browsers in the market. 
* Chrome
* Firefox
* Edge (Chromium based version) 
* Safari (Experimental)

For Safari, please refer to http://watir.com/guides/safari/ for instructions.

#### Installation:
>gem install trinity
>
Note:

Some extra steps are required on windows.

> gem install eventmachine --platform ruby 
> gem uninstall eventmachine

and  select the x64-mingw32 version 

> gem install ffi

choose: eventmachine-1.2.7-x64-mingw32

#### Usage:
Trinity framework needs the file trinity_settings.yml in the root folder of your project. 


#### Parallel Testing
Additional gem required: 'parallel_tests'

Be sure you executed 'gem install parallel_tests' before running the command below.

**Trinity** allows you to run several feature files in parallel. 
Use: 
> parallel_cucumber path_to_feature_files -n number_of_processes

If the parameter -n is not specified, cucumber will create a process per feature file

Run parallel_cucumber -h for more options

**Important note**: This feature is not supported on Windows.


## Environment file structure

**device**: [desktop | android | ios]  
  
**base_url**: The base url of your application  
   
**database_connection**: *database_filename* (located in databases folder)  
  
**device_profile**: *The entry in device_profiles/devices.yml*  
  
**browser**: [chrome | firefox | edge | safari]  
  
**page_configurations**: *the folder that contains your page objects configurations*  
  
**default_page**: *The page that will be created when all scenarios start> E.g: 'google'  
  
**api_url**: *For api rest testing. The base url used to make the requests*  
  
**appium_server**: *The address of the appium server instance*