require 'rest-client'
require 'json'
require 'pry'
require 'logger'

time = Time.new 
fileName = "log/"+ $0 + "_"+time.strftime("%Y-%m-%d_%H:%M:%S")+ ".log"

$LOG = Logger.new(fileName + ".log", 'monthly')   


GIT_URL_F = "https://api.github.com/users/hrishikesh-mishra/gists?page=" 

GIT_URL = "https://api.github.com/gists/"
HEADER = {"content-type" => "application/json" , "Authorization" => "token "}


def get_gist page_no 
	response = RestClient.get(GIT_URL_F + page_no.to_s)
	json_response = JSON.parse(response.body)
	return json_response
end 

 def drop_gist id 
 	request=  {} 
 	response=RestClient.delete GIT_URL + id, HEADER
 end

 

new_gist_data = []

for i in 1..11

	gists = get_gist i

	gists.each do | gist |

		drop_gist gist["id"]
		
	end

	puts "#{i} Batch Finished."




end 

puts new_gist_data 




