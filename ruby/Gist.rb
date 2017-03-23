require 'rest-client'
require 'json'
require 'pry'
require 'logger'

time = Time.new 
fileName = "log/"+ $0 + "_"+time.strftime("%Y-%m-%d_%H:%M:%S")+ ".log"

$LOG = Logger.new(fileName + ".log", 'monthly')   

GIT_URL = "https://api.github.com/users/hrishikesh-kumar/gists?page="
GIT_POST_URL = "https://api.github.com/gists"
HEADER = {"content-type" => "application/json" , "Authorization" => "token "}

def get_gist page_no 
	response = RestClient.get(GIT_URL + page_no.to_s)
	json_response = JSON.parse(response.body)
	return json_response
end 

def get_file file
	response = RestClient.get(file)	
	data = response.body
end

def create_gist files 
	
	# binding.pry
	request_data = {	 
		  	"description" =>  files[:description],
		  	"public"=> true,
		  	"files"=> files[:files]    		 
	}

	# binding.pry
	begin
		response=RestClient.post GIT_POST_URL, request_data.to_json, HEADER
		data = JSON.parse(response.body)

		return data

	rescue Exception => e
		puts "Exception Found During Creation "	
		binding.pry
	end

	binding.pry

end

new_gist_data = [] 
	
for i in 1..11

	gists = get_gist i




	gists.each do | gist |

		files = {}
		gist["files"].each do | file_name, file | 	
			file_data = get_file file["raw_url"]
			files[file ["filename"]] = {"content": file_data, "filename": file ["filename"], "type": file["type"],  "language": file["language"]  }		  		
		end

		gist_data = {"id": gist["id"], "html_url": gist["html_url"],  "description": gist["description"], "files": files}
		response  = create_gist gist_data

		new_gist_data << {"old_id": gist["id"] , "new_id": response["id"]}
		
		
	end

	puts "#{i} Batch Finished."




end 

puts new_gist_data 




