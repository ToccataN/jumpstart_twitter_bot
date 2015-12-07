require 'net/http'

url= 'http://www.acme.com/products/3322'
resp= Net::HTTP.get_response(URI.parse(url))

resp_text= resp.body
puts resp_text