require 'rest-client'
require 'json'
require 'pry'
require 'logger'

time = Time.new 
fileName = "log/"+ $0 + "_"+time.strftime("%Y-%m-%d_%H:%M:%S")+ ".log"

$LOG = Logger.new(fileName + ".log", 'monthly')   

HK_GIT_URL = "https://gist.githubusercontent.com/hrishikesh-kumar/"
HM_GIT_URL = "https://gist.githubusercontent.com/hrishikesh-mishra/"



def get_file file
	response = RestClient.get(file)	
	data = response.body
end


 

filedata = File.read("/Users/hrishikesh.mishra/Desktop/hrishikesh_wp-2.sql") 
ids = JSON.parse(filedata)

i = 0 
ids.each do |id |
	file1 = get_file HK_GIT_URL + id["old_id"] +  "/raw" 
	file2 = get_file HM_GIT_URL + id["new_id"] + "/raw" 	
	 if file1.eql? file2
	 	
	puts i 
	i = i+ 1
end



