#$/bin/sh
PROJECT_PATH=$1
SETTINGS_FILE=$PROJECT_PATH"/trinity_settings.yml"

touch "$SETTINGS_FILE"
echo "support_folder_path: 'trinity_fw'" >> $SETTINGS_FILE
echo "implicit_wait_timeout: 10" >> $SETTINGS_FILE
echo "webdrivers: { " >> $SETTINGS_FILE
echo "edge: ," >> $SETTINGS_FILE
echo "chrome: ," >> $SETTINGS_FILE
echo "firefox: ," >> $SETTINGS_FILE
echo "safari: ," >> $SETTINGS_FILE
echo "}" >> $SETTINGS_FILE


mkdir -p "$PROJECT_PATH/trinity_fw/support"
mkdir -p "$PROJECT_PATH/trinity_fw/support/api"
mkdir -p "$PROJECT_PATH/trinity_fw/support/databases"
mkdir -p "$PROJECT_PATH/trinity_fw/support/device_profiles"
mkdir -p "$PROJECT_PATH/trinity_fw/support/email"
mkdir -p "$PROJECT_PATH/trinity_fw/support/environments"
mkdir -p "$PROJECT_PATH/trinity_fw/support/page_configurations"
mkdir -p "$PROJECT_PATH/trinity_fw/support/page_configurations/demo"
mkdir -p "$PROJECT_PATH/trinity_fw/support/users"

touch "$PROJECT_PATH/trinity_fw/support/api/restful_api.yml"
touch "$PROJECT_PATH/trinity_fw/support/databases/mongo_example.yml"
touch "$PROJECT_PATH/trinity_fw/support/databases/mysql_example.yml"
touch "$PROJECT_PATH/trinity_fw/support/databases/oracle_example.yml"
touch "$PROJECT_PATH/trinity_fw/support/databases/postgresql_example.yml"
touch "$PROJECT_PATH/trinity_fw/support/databases/sqlserver_example.yml"
touch "$PROJECT_PATH/trinity_fw/support/device_profiles/devices.yml"
touch "$PROJECT_PATH/trinity_fw/support/email/settings.yml"
touch "$PROJECT_PATH/trinity_fw/support/environments/demo.yml"
touch "$PROJECT_PATH/trinity_fw/support/page_configurations/demo/landing_page.yml"
touch "$PROJECT_PATH/trinity_fw/support/users/demo_users.yml"
touch "$PROJECT_PATH/trinity_fw/support/zephyr_settings.yml"
touch "$PROJECT_PATH/trinity_fw/support/chrome_options.yml"
touch "$PROJECT_PATH/trinity_fw/support/chrome_switches.yml"
touch "$PROJECT_PATH/trinity_fw/support/jira_settings.yml"

echo "rest_end_point: {" >> "$PROJECT_PATH/trinity_fw/support/api/restful_api.yml"
echo "endpoint_key: 'sample/posts/json'" >> "$PROJECT_PATH/trinity_fw/support/api/restful_api.yml"
echo "}" >> "$PROJECT_PATH/trinity_fw/support/api/restful_api.yml"

echo "db_type: " >> "$PROJECT_PATH/trinity_fw/support/databases/mongo_example.yml"
echo "host: " >> "$PROJECT_PATH/trinity_fw/support/databases/mongo_example.yml"
echo "database: " >> "$PROJECT_PATH/trinity_fw/support/databases/mongo_example.yml"
echo "user: " >> "$PROJECT_PATH/trinity_fw/support/databases/mongo_example.yml"
echo "password: " >> "$PROJECT_PATH/trinity_fw/support/databases/mongo_example.yml"
echo "#replica_set: 3d62adc2rd2ad4f628cf5e8db921ce445" >> "$PROJECT_PATH/trinity_fw/support/databases/mongo_example.yml"
echo "#ssl: false" >> "$PROJECT_PATH/trinity_fw/support/databases/mongo_example.yml"

echo "db_type: " >> "$PROJECT_PATH/trinity_fw/support/databases/mysql_example.yml"
echo "database: " >> "$PROJECT_PATH/trinity_fw/support/databases/mysql_example.yml"
echo "user: " >> "$PROJECT_PATH/trinity_fw/support/databases/mysql_example.yml"
echo "password: " >> "$PROJECT_PATH/trinity_fw/support/databases/mysql_example.yml"

echo "db_type: " >> "$PROJECT_PATH/trinity_fw/support/databases/oracle_example.yml"
echo "host: " >> "$PROJECT_PATH/trinity_fw/support/databases/oracle_example.yml"
echo "port: " >> "$PROJECT_PATH/trinity_fw/support/databases/oracle_example.yml"
echo "username: " >> "$PROJECT_PATH/trinity_fw/support/databases/oracle_example.yml"
echo "password: " >> "$PROJECT_PATH/trinity_fw/support/databases/oracle_example.yml"
echo "service_name: " >> "$PROJECT_PATH/trinity_fw/support/databases/oracle_example.yml"

echo "db_type: " >> "$PROJECT_PATH/trinity_fw/support/databases/postgresql_example.yml"
echo "database: " >> "$PROJECT_PATH/trinity_fw/support/databases/postgresql_example.yml"
echo "user: " >> "$PROJECT_PATH/trinity_fw/support/databases/postgresql_example.yml"
echo "password: " >> "$PROJECT_PATH/trinity_fw/support/databases/postgresql_example.yml"

echo "db_type: " >> "$PROJECT_PATH/trinity_fw/support/databases/sqlserver_example.yml"
echo "host: " >> "$PROJECT_PATH/trinity_fw/support/databases/sqlserver_example.yml"
echo "port: " >> "$PROJECT_PATH/trinity_fw/support/databases/sqlserver_example.yml"
echo "username: " >> "$PROJECT_PATH/trinity_fw/support/databases/sqlserver_example.yml"
echo "password: " >> "$PROJECT_PATH/trinity_fw/support/databases/sqlserver_example.yml"
echo "database: " >> "$PROJECT_PATH/trinity_fw/support/databases/sqlserver_example.yml"
echo "login_timeout: " >> "$PROJECT_PATH/trinity_fw/support/databases/sqlserver_example.yml"
echo "timeout: " >> "$PROJECT_PATH/trinity_fw/support/databases/sqlserver_example.yml"

echo "android: " >> "$PROJECT_PATH/trinity_fw/support/device_profiles/devices.yml"
echo "  platformName: Android" >> "$PROJECT_PATH/trinity_fw/support/device_profiles/devices.yml"
echo "  deviceName: emulator-554" >> "$PROJECT_PATH/trinity_fw/support/device_profiles/devices.yml"
echo "  browserName: Chrome" >> "$PROJECT_PATH/trinity_fw/support/device_profiles/devices.yml"
echo "  newCommandTimeout: 600" >> "$PROJECT_PATH/trinity_fw/support/device_profiles/devices.yml"
echo "android_native_app: " >> "$PROJECT_PATH/trinity_fw/support/device_profiles/devices.yml"
echo "  platformName: Android" >> "$PROJECT_PATH/trinity_fw/support/device_profiles/devices.yml"
echo "  deviceName: emulator-554" >> "$PROJECT_PATH/trinity_fw/support/device_profiles/devices.yml"
echo "  appPackage: com.google.android.apps.translate" >> "$PROJECT_PATH/trinity_fw/support/device_profiles/devices.yml"
echo "  appActivity: com.google.android.apps.translate.TranslateActivity" >> "$PROJECT_PATH/trinity_fw/support/device_profiles/devices.yml"
echo "ios: " >> "$PROJECT_PATH/trinity_fw/support/device_profiles/devices.yml"
echo "  platformName: iOS" >> "$PROJECT_PATH/trinity_fw/support/device_profiles/devices.yml"
echo "  deviceName: iPhone Simulator" >> "$PROJECT_PATH/trinity_fw/support/device_profiles/devices.yml"
echo "  browserName: Safari" >> "$PROJECT_PATH/trinity_fw/support/device_profiles/devices.yml"
echo "  platformVersion: 13" >> "$PROJECT_PATH/trinity_fw/support/device_profiles/devices.yml"

echo "email_settings: " >> "$PROJECT_PATH/trinity_fw/support/email/settings.yml"
echo "  address:" >> "$PROJECT_PATH/trinity_fw/support/email/settings.yml"
echo "  port:" >> "$PROJECT_PATH/trinity_fw/support/email/settings.yml"
echo "  user_name:" >> "$PROJECT_PATH/trinity_fw/support/email/settings.yml"
echo "  password:" >> "$PROJECT_PATH/trinity_fw/support/email/settings.yml"
echo "  authentication:" >> "$PROJECT_PATH/trinity_fw/support/email/settings.yml"
echo "  ssl:" >> "$PROJECT_PATH/trinity_fw/support/email/settings.yml"
echo "  openssl_verify_mode:" >> "$PROJECT_PATH/trinity_fw/support/email/settings.yml"

echo "device: desktop" >> "$PROJECT_PATH/trinity_fw/support/environments/demo.yml"
echo "base_url: http://google.com" >> "$PROJECT_PATH/trinity_fw/support/environments/demo.yml"
echo "browser: chrome" >> "$PROJECT_PATH/trinity_fw/support/environments/demo.yml"
echo "database_connections:" >> "$PROJECT_PATH/trinity_fw/support/environments/demo.yml"
echo "  mongo: mongo_example" >> "$PROJECT_PATH/trinity_fw/support/environments/demo.yml"
echo "  sql: mysql_example" >> "$PROJECT_PATH/trinity_fw/support/environments/demo.yml"
echo "page_configurations: demo" >> "$PROJECT_PATH/trinity_fw/support/environments/demo.yml"
echo "default_page: landing_page" >> "$PROJECT_PATH/trinity_fw/support/environments/demo.yml"
echo "api_url: http://api.google.com" >> "$PROJECT_PATH/trinity_fw/support/environments/demo.yml"
echo "users: demo_users" >> "$PROJECT_PATH/trinity_fw/support/environments/demo.yml"

echo "my_user:" >> "$PROJECT_PATH/trinity_fw/support/users/demo_users.yml"
echo "  name:" >> "$PROJECT_PATH/trinity_fw/support/users/demo_users.yml"
echo "  password:" >> "$PROJECT_PATH/trinity_fw/support/users/demo_users.yml"

echo "controls: {" >> "$PROJECT_PATH/trinity_fw/support/page_configurations/demo/landing_page.yml"
echo "  results: {" >> "$PROJECT_PATH/trinity_fw/support/page_configurations/demo/landing_page.yml"
echo "    control: Links, " >> "$PROJECT_PATH/trinity_fw/support/page_configurations/demo/landing_page.yml"
echo "    locator_type: css," >> "$PROJECT_PATH/trinity_fw/support/page_configurations/demo/landing_page.yml"
echo "    value: #search div.r a " >> "$PROJECT_PATH/trinity_fw/support/page_configurations/demo/landing_page.yml"
echo "           }" >> "$PROJECT_PATH/trinity_fw/support/page_configurations/demo/landing_page.yml"
echo "          }" >> "$PROJECT_PATH/trinity_fw/support/page_configurations/demo/landing_page.yml"

echo "options: {" >> "$PROJECT_PATH/trinity_fw/support/chrome_options.yml"
echo "# mobileEmulation: {" >> "$PROJECT_PATH/trinity_fw/support/chrome_options.yml"
echo "#   deviceName: 'iPhone X'" >> "$PROJECT_PATH/trinity_fw/support/chrome_options.yml"
echo "# }" >> "$PROJECT_PATH/trinity_fw/support/chrome_options.yml"
echo "}" >> "$PROJECT_PATH/trinity_fw/support/chrome_options.yml"

echo "# See all available switches in https://peter.sh/experiments/chromium-command-line-switches/" >> "$PROJECT_PATH/trinity_fw/support/chrome_switches.yml"
echo "switches: ['--disable-notifications'," >> "$PROJECT_PATH/trinity_fw/support/chrome_switches.yml"
echo "'--ignore-certificate-errors'," >> "$PROJECT_PATH/trinity_fw/support/chrome_switches.yml"
echo "'--start-maximized'" >> "$PROJECT_PATH/trinity_fw/support/chrome_switches.yml"
echo "]" >> "$PROJECT_PATH/trinity_fw/support/chrome_switches.yml"

echo "jira_url: 'https://testingframework.atlassian.net'" >> "$PROJECT_PATH/trinity_fw/support/jira_settings.yml"
echo "jira_user: 'user@mail.com'" >> "$PROJECT_PATH/trinity_fw/support/jira_settings.yml"
echo "jira_token: 'FoObAarsH6bjN1Nw777F'" >> "$PROJECT_PATH/trinity_fw/support/jira_settings.yml"

echo "account_id: 'xtcpcFtTDWB3f9w1UVACUiIu'" >> "$PROJECT_PATH/trinity_fw/support/zephyr_settings.yml"
echo "secret_key: 'JoKOZ01p1dozHIOb2i6FwSR0pXa3WAg3fOhVL8d2sYh'" >> "$PROJECT_PATH/trinity_fw/support/zephyr_settings.yml"
echo "access_key: 'aIhxZoicvKvbcWFAEgOTqjnjekLqtEz3mLxtnyC3Q5j1nC5QiHBLi5vT8T5m9TPgUYYzVX1MBtjSIb1qQjH5dIlPVGmI3bTqnYTaTsjrYg'" >> "$PROJECT_PATH/trinity_fw/support/zephyr_settings.yml"
