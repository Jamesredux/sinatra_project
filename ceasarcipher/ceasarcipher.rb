require 'sinatra'
require "sinatra/reloader"



get '/' do 
	erb :index
end	

post '/result' do 
	@string = params['string']
	@key = params['shift']
	validator = InputValidator.new(@string, @key)
	if validator.valid?
		@shift = @key.to_i
			@result = encrypt(@string, @shift)
			erb :result
	else
			@message = validator.message
			erb :index
	end				
end	






 def encrypt(string, shift)
 	 code = []  #create the array that  the code will be put in
   text = string.split('')  #turn string into array of characters

    #iterate through the characters "x" one character at a time
    text.each do |x|  
     x = x.ord #convert to ascii

     	if (95..122).include?(x) #lower case letters
     		x += shift
     			if x>122  #wraparound!
     				x -= 26
     			end
     		x = x.chr
     		code<<x
   		elsif (65..90).include?(x) #upper case letters
   		 	x += shift
   		 		if x > 90
   		 			x -= 26
   		 		end
   	 		x = x.chr
   	 		code <<x
   		else    #leave all other characters eg space/!!? as they are
   	 		x = x.chr
   	 		code<<x
     	end 
    end  
      code = code.join 
      return code	
 end  


class InputValidator

	def initialize(string, key)
		@string = string
		@key = key	
	end

	def valid?
		validate
		@message.nil?
	end
	
	def message
		@message
	end	

	def validate
		if @string.empty? || @key.empty?
			@message = "You need to complete both fields"
		elsif is_int?(@key) == false
			@message = "Please input a number in the key field."
		end		
	end	


	def is_int?(key)
		key.to_s == key.to_i.to_s
	end	
end 