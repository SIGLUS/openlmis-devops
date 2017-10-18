files_to_replace = ['/app/tomcat/openlmis/properties/app.properties',
                    '/app/tomcat/openlmis/properties/atomfeed.properties',
                    '/app/tomcat/openlmis/properties/default.properties',
                    '/app/tomcat/openlmis/properties/mailing.properties']

variables = {
              DBUSER: ENV['DBUSER'],
              DBPASSWORD: ENV['DBPASSWORD'],
              MAILPASSWORD: ENV['MAILPASSWORD'],
              OPENLMIS_VERSION: ENV['OPENLMIS_VERSION']
            }

files_to_replace.each do |file|
  content_to_replace_with = File.read(file)
  File.write(file, content_to_replace_with % variables)
end
