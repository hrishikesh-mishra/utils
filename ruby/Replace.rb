require 'rest-client'
require 'json'
require 'pry'
require 'logger'

 

filedata = File.read("/Users/hrishikesh.mishra/Desktop/gist-diff.json") 
ids = JSON.parse(filedata)

oldFile = File.read("/Users/hrishikesh.mishra/Downloads/hrishikesh_wp-2.sql") 


ids.each do |id |
	oldFile = oldFile.gsub(id["old_id"], id["new_id"] )  
end


File.open("/Users/hrishikesh.mishra/Downloads/hrishikesh_wp-replaced.sql", 'w') {|f| f.write(oldFile) }


