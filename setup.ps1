
$PROJECT_PATH=$args[0]
$SETTINGS_FILE="$PROJECT_PATH/trinity_settings.yml"
#echo $null >> $SETTINGS_FILE
New-Item -Name $SETTINGS_FILE -ItemType File

Add-Content "$SETTINGS_FILE" "support_folder_path: 'trinity_fw'"
Add-Content "$SETTINGS_FILE" "implicit_wait_timeout: 10"
Add-Content "$SETTINGS_FILE" "webdrivers: { "
Add-Content "$SETTINGS_FILE" "edge: ," 
Add-Content "$SETTINGS_FILE" "chrome: ,"
Add-Content "$SETTINGS_FILE" "firefox: ,"
Add-Content "$SETTINGS_FILE" "safari: "
Add-Content "$SETTINGS_FILE" "}" 

md "$PROJECT_PATH/trinity_fw/support" -ea 0
md "$PROJECT_PATH/trinity_fw/support/api" -ea 0
md "$PROJECT_PATH/trinity_fw/support/databases" -ea 0
md "$PROJECT_PATH/trinity_fw/support/device_profiles" -ea 0
md "$PROJECT_PATH/trinity_fw/support/email" -ea 0
md "$PROJECT_PATH/trinity_fw/support/environments" -ea 0
md "$PROJECT_PATH/trinity_fw/support/page_configurations" -ea 0
md "$PROJECT_PATH/trinity_fw/support/page_configurations/demo" -ea 0
md "$PROJECT_PATH/trinity_fw/support/users" -ea 0

New-Item -Name  "$PROJECT_PATH/trinity_fw/support/api/restful_api.yml" -ItemType File
New-Item -Name  "$PROJECT_PATH/trinity_fw/support/databases/mongo_example.yml" -ItemType File
New-Item -Name  "$PROJECT_PATH/trinity_fw/support/databases/mysql_example.yml" -ItemType File
New-Item -Name  "$PROJECT_PATH/trinity_fw/support/databases/oracle_example.yml" -ItemType File
New-Item -Name  "$PROJECT_PATH/trinity_fw/support/databases/postgresql_example.yml" -ItemType File
New-Item -Name  "$PROJECT_PATH/trinity_fw/support/databases/sqlserver_example.yml" -ItemType File
New-Item -Name  "$PROJECT_PATH/trinity_fw/support/device_profiles/devices.yml" -ItemType File
New-Item -Name  "$PROJECT_PATH/trinity_fw/support/email/settings.yml" -ItemType File
New-Item -Name  "$PROJECT_PATH/trinity_fw/support/environments/demo.yml" -ItemType File
New-Item -Name  "$PROJECT_PATH/trinity_fw/support/users/demo_users.yml" -ItemType File
New-Item -Name  "$PROJECT_PATH/trinity_fw/support/page_configurations/demo/landing_page.yml" -ItemType File
New-Item -Name  "$PROJECT_PATH/trinity_fw/support/chrome_options.yml" -ItemType File
New-Item -Name  "$PROJECT_PATH/trinity_fw/support/chrome_switches.yml" -ItemType File
New-Item -Name  "$PROJECT_PATH/trinity_fw/support/jira_settings.yml" -ItemType File
New-Item -Name  "$PROJECT_PATH/trinity_fw/support/settings.yml" -ItemType File
New-Item -Name  "$PROJECT_PATH/trinity_fw/support/zephyr_settings.yml" -ItemType File

Add-Content "$PROJECT_PATH/trinity_fw/support/api/restful_api.yml" "rest_end_point: {" 
Add-Content "$PROJECT_PATH/trinity_fw/support/api/restful_api.yml" "endpoint_key: 'sample/posts/json'"
Add-Content "$PROJECT_PATH/trinity_fw/support/api/restful_api.yml" "}"

Add-Content "$PROJECT_PATH/trinity_fw/support/databases/mongo_example.yml" "db_type: " 
Add-Content "$PROJECT_PATH/trinity_fw/support/databases/mongo_example.yml" "host: "
Add-Content "$PROJECT_PATH/trinity_fw/support/databases/mongo_example.yml" "database: "
Add-Content "$PROJECT_PATH/trinity_fw/support/databases/mongo_example.yml" "user: "
Add-Content "$PROJECT_PATH/trinity_fw/support/databases/mongo_example.yml" "password: "
Add-Content "$PROJECT_PATH/trinity_fw/support/databases/mongo_example.yml" "#replica_set: 3d62adc2rd2ad4f628cf5e8db921ce445"
Add-Content "$PROJECT_PATH/trinity_fw/support/databases/mongo_example.yml" "#ssl: false"

Add-Content "$PROJECT_PATH/trinity_fw/support/databases/mysql_example.yml" "db_type: " 
Add-Content "$PROJECT_PATH/trinity_fw/support/databases/mysql_example.yml" "database: "
Add-Content "$PROJECT_PATH/trinity_fw/support/databases/mysql_example.yml" "user: "	 
Add-Content "$PROJECT_PATH/trinity_fw/support/databases/mysql_example.yml" "password: "

Add-Content "$PROJECT_PATH/trinity_fw/support/databases/oracle_example.yml" "db_type: "	
Add-Content "$PROJECT_PATH/trinity_fw/support/databases/oracle_example.yml" "host: " 	
Add-Content "$PROJECT_PATH/trinity_fw/support/databases/oracle_example.yml" "port: " 	
Add-Content "$PROJECT_PATH/trinity_fw/support/databases/oracle_example.yml" "username: "
Add-Content "$PROJECT_PATH/trinity_fw/support/databases/oracle_example.yml" "password: "
Add-Content "$PROJECT_PATH/trinity_fw/support/databases/oracle_example.yml" "service_name: "

Add-Content "$PROJECT_PATH/trinity_fw/support/databases/postgresql_example.yml" "db_type: "
Add-Content "$PROJECT_PATH/trinity_fw/support/databases/postgresql_example.yml" "database: "
Add-Content "$PROJECT_PATH/trinity_fw/support/databases/postgresql_example.yml" "user: " 	
Add-Content "$PROJECT_PATH/trinity_fw/support/databases/postgresql_example.yml" "password: "

Add-Content "$PROJECT_PATH/trinity_fw/support/databases/sqlserver_example.yml" "db_type: "
Add-Content "$PROJECT_PATH/trinity_fw/support/databases/sqlserver_example.yml" "host: " 		
Add-Content "$PROJECT_PATH/trinity_fw/support/databases/sqlserver_example.yml" "port: " 		
Add-Content "$PROJECT_PATH/trinity_fw/support/databases/sqlserver_example.yml" "username: " 	
Add-Content "$PROJECT_PATH/trinity_fw/support/databases/sqlserver_example.yml" "password: " 	
Add-Content "$PROJECT_PATH/trinity_fw/support/databases/sqlserver_example.yml" "database: " 	
Add-Content "$PROJECT_PATH/trinity_fw/support/databases/sqlserver_example.yml" "login_timeout: "
Add-Content "$PROJECT_PATH/trinity_fw/support/databases/sqlserver_example.yml" "timeout: "

Add-Content "$PROJECT_PATH/trinity_fw/support/device_profiles/devices.yml" "android: " 															
Add-Content "$PROJECT_PATH/trinity_fw/support/device_profiles/devices.yml" "  platformName: Android"												
Add-Content "$PROJECT_PATH/trinity_fw/support/device_profiles/devices.yml" "  deviceName: emulator-554"											
Add-Content "$PROJECT_PATH/trinity_fw/support/device_profiles/devices.yml" "  browserName: Chrome" 												
Add-Content "$PROJECT_PATH/trinity_fw/support/device_profiles/devices.yml" "  newCommandTimeout: 600" 												
Add-Content "$PROJECT_PATH/trinity_fw/support/device_profiles/devices.yml" "android_native_app: " 													
Add-Content "$PROJECT_PATH/trinity_fw/support/device_profiles/devices.yml" "  platformName: Android" 												
Add-Content "$PROJECT_PATH/trinity_fw/support/device_profiles/devices.yml" "  deviceName: emulator-554"										 	
Add-Content "$PROJECT_PATH/trinity_fw/support/device_profiles/devices.yml" "  appPackage: com.google.android.apps.translate"					 	
Add-Content "$PROJECT_PATH/trinity_fw/support/device_profiles/devices.yml" "  appActivity: com.google.android.apps.translate.TranslateActivity" 	
Add-Content "$PROJECT_PATH/trinity_fw/support/device_profiles/devices.yml" "ios: " 																
Add-Content "$PROJECT_PATH/trinity_fw/support/device_profiles/devices.yml" "  platformName: iOS" 													
Add-Content "$PROJECT_PATH/trinity_fw/support/device_profiles/devices.yml" "  deviceName: iPhone Simulator"										
Add-Content "$PROJECT_PATH/trinity_fw/support/device_profiles/devices.yml" "  browserName: Safari" 												
Add-Content "$PROJECT_PATH/trinity_fw/support/device_profiles/devices.yml" "  platformVersion: 13"		

Add-Content "$PROJECT_PATH/trinity_fw/support/email/settings.yml" "email_settings: " 	
Add-Content "$PROJECT_PATH/trinity_fw/support/email/settings.yml" "  address:" 			
Add-Content "$PROJECT_PATH/trinity_fw/support/email/settings.yml" "  port:" 				
Add-Content "$PROJECT_PATH/trinity_fw/support/email/settings.yml" "  user_name:"			
Add-Content "$PROJECT_PATH/trinity_fw/support/email/settings.yml" "  password:" 			
Add-Content "$PROJECT_PATH/trinity_fw/support/email/settings.yml" "  authentication:" 	
Add-Content "$PROJECT_PATH/trinity_fw/support/email/settings.yml" "  ssl:" 				
Add-Content "$PROJECT_PATH/trinity_fw/support/email/settings.yml" "  openssl_verify_mode:"


Add-Content "$PROJECT_PATH/trinity_fw/support/environments/demo.yml" "device: desktop" 					
Add-Content "$PROJECT_PATH/trinity_fw/support/environments/demo.yml" "base_url: http://google.com" 		
Add-Content "$PROJECT_PATH/trinity_fw/support/environments/demo.yml" "browser: chrome" 					
Add-Content "$PROJECT_PATH/trinity_fw/support/environments/demo.yml" "database_connections:"			
Add-Content "$PROJECT_PATH/trinity_fw/support/environments/demo.yml" "  mongo: mongo_example"			
Add-Content "$PROJECT_PATH/trinity_fw/support/environments/demo.yml" "  sql: mysql_example" 			
Add-Content "$PROJECT_PATH/trinity_fw/support/environments/demo.yml" "page_configurations: demo"		
Add-Content "$PROJECT_PATH/trinity_fw/support/environments/demo.yml" "default_page: landing_page"		
Add-Content "$PROJECT_PATH/trinity_fw/support/environments/demo.yml" "api_url: http://api.google.com"	
Add-Content "$PROJECT_PATH/trinity_fw/support/environments/demo.yml" "users: demo_users"				

Add-Content "$PROJECT_PATH/trinity_fw/support/users/demo_users.yml" "my_user:" 	
Add-Content "$PROJECT_PATH/trinity_fw/support/users/demo_users.yml" "  name:" 		
Add-Content "$PROJECT_PATH/trinity_fw/support/users/demo_users.yml" "  password:" 


Add-Content "$PROJECT_PATH/trinity_fw/support/page_configurations/demo/landing_page.yml" "controls: {" 					
Add-Content "$PROJECT_PATH/trinity_fw/support/page_configurations/demo/landing_page.yml" "  results: {" 				
Add-Content "$PROJECT_PATH/trinity_fw/support/page_configurations/demo/landing_page.yml" "    control: Links, "			
Add-Content "$PROJECT_PATH/trinity_fw/support/page_configurations/demo/landing_page.yml" "    locator_type: css," 		
Add-Content "$PROJECT_PATH/trinity_fw/support/page_configurations/demo/landing_page.yml" "    value: #search div.r a " 	
Add-Content "$PROJECT_PATH/trinity_fw/support/page_configurations/demo/landing_page.yml" "           }" 				
Add-Content "$PROJECT_PATH/trinity_fw/support/page_configurations/demo/landing_page.yml" "          }" 					

Add-Content "$PROJECT_PATH/trinity_fw/support/chrome_switches.yml" "# See all available switches in https://peter.sh/experiments/chromium-command-line-switches/" 
Add-Content "$PROJECT_PATH/trinity_fw/support/chrome_switches.yml" "switches: ['--disable-notifications'," 														
Add-Content "$PROJECT_PATH/trinity_fw/support/chrome_switches.yml" "'--ignore-certificate-errors'," 																
Add-Content "$PROJECT_PATH/trinity_fw/support/chrome_switches.yml" "'--start-maximized'" 																			
Add-Content "$PROJECT_PATH/trinity_fw/support/chrome_switches.yml" "]"																							

Add-Content "$PROJECT_PATH/trinity_fw/support/chrome_options.yml" "options: {"					
Add-Content "$PROJECT_PATH/trinity_fw/support/chrome_options.yml" "# mobileEmulation: {" 		
Add-Content "$PROJECT_PATH/trinity_fw/support/chrome_options.yml" "#   deviceName: 'iPhone X'"	
Add-Content "$PROJECT_PATH/trinity_fw/support/chrome_options.yml" "# }" 							
Add-Content "$PROJECT_PATH/trinity_fw/support/chrome_options.yml" "}" 							

Add-Content "$PROJECT_PATH/trinity_fw/support/jira_settings.yml" "jira_url: 'https://testingframework.atlassian.net'" 
Add-Content "$PROJECT_PATH/trinity_fw/support/jira_settings.yml" "jira_user: 'user@mail.com'"							
Add-Content "$PROJECT_PATH/trinity_fw/support/jira_settings.yml" "jira_token: 'FoObAarsH6bjN1Nw777F'" 					

Add-Content "$PROJECT_PATH/trinity_fw/support/zephyr_settings.yml" "account_id: 'xtcpcFtTDWB3f9w1UVACUiIu'"																					
Add-Content "$PROJECT_PATH/trinity_fw/support/zephyr_settings.yml" "secret_key: 'JoKOZ01p1dozHIOb2i6FwSR0pXa3WAg3fOhVL8d2sYh'" 																
Add-Content "$PROJECT_PATH/trinity_fw/support/zephyr_settings.yml" "access_key: 'aIhxZoicvKvbcWFAEgOTqjnjekLqtEz3mLxtnyC3Q5j1nC5QiHBLi5vT8T5m9TPgUYYzVX1MBtjSIb1qQjH5dIlPVGmI3bTqnYTaTsjrYg'"


Add-Content "$PROJECT_PATH/trinity_fw/support/settings.yml" "local_settings:" 
Add-Content "$PROJECT_PATH/trinity_fw/support/settings.yml" "  local_settings_file_path: '/features/support/local_settings.yml'" 
