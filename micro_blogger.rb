require 'jumpstart_auth'
require 'bitly'

Bitly.use_api_version_3
class MicroBlogger
  attr_reader :client
  
  def initialize
    puts "Initializing Microblogger"
    @client= JumpstartAuth.twitter
  end
  def tweet(message)
  	if message.length <= 140
      @client.update(message)
    else
    	print "message too long! keep under 140!"
    end

  end
  def run
    puts "Welcome to the JSL Twitter Client!"
    command = ""
     while command != "q"
       printf "enter command: "
       input=gets.chomp
       parts = input.split(" ")
       command = parts[0]
        case command
            when 'q' then puts "Goodbye!"
            when 't' then tweet(parts[1..-1].join(" "))
            when 'dm' then dm(parts[1], parts[2..-1].join(" "))
            when 'spam' then spam_followers(parts[1..-1].join(" "))
           
         else
             puts "Sorry, I don't know how to #{command}"
         end
     end
  end
  def dm(target, message)
  	  screen_names = @client.followers.collect { |follower| @client.user(follower).screen_name }
      if screen_names.include? target
         puts "Trying to send #{target} this direct message:"
         puts message
         message = "d @#{target} #{message}"
         tweet(message)
     else
     	puts "cant do that"
     end

   end
   def followers_list
   	  screen_names = []
   	  @client.followers.each {|follower| screen_names << @client.user(follower).screen_name}
   	  return screen_names

   end
   def spam_followers(message)
      list = followers_list
      list.each {|follower| dm(follower,message)}
   end
   

   end
  
end

blogger = MicroBlogger.new
blogger.tweet("MicroBlogger Initialized")
blogger.run