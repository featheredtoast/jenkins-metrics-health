require "json"
require "httpclient"
require "thor"

class JenkinsHealth < Thor
  option :url, :aliases => "-u", :required => true, :desc => "Jenkins URL"
  option :key, :aliases => "-k", :required => true, :desc => "Stats api key"
  desc "Jenkins Health Checking", "Automatic health checking for Jenkins. Requires the Jenkins metrics plugin"
  def jenkins
    baseUrl = "#{options[:url]}"
    key = "#{options[:key]}"
    url = baseUrl.chomp("/") + "/metrics/" + key + "/healthcheck"
    http = HTTPClient.new
    json = JSON http.get_content(url)
    checks = ["disk-space", "plugins", "temporary-space", "thread-deadlock"]
    checks.each do |check|
      puts json[check]["message"] if !json[check]["message"].to_s.empty?
      exit(1) if !json[check]["healthy"]
    end
    exit(0)
  end
  default_task :jenkins
end
JenkinsHealth.start
