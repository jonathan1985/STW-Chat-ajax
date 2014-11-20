require 'coveralls'
Coveralls.wear!
ENV['RACK_ENV'] = 'test'
require_relative '../chat.rb'
require 'rack/test'
require 'rubygems'
require 'rspec'

include Rack::Test::Methods
describe "Testing specs" do

   def app
      Sinatra::Application
   end
    
    it "Without session init" do
       get '/', {}, 'rack.session' => { :name => 'Testing' }
       expect(last_response).to be_ok
    end
    
    it "With session" do
       get '/'
       expect(last_response).to be_ok
    end
    
    it "Testing post" do
       post '/'
       expect(last_response).to be_ok
    end
    
    it "post with user" do
       post '/', :username => "Testing"
       post '/', :username => "Testing"
       expect(last_response).to be_ok
    end
    
    it "Logout" do
       get '/logout'
       expect(last_response).to be_ok
    end
    
    it "Send with session" do
       get '/send', {}, 'rack.session' => { :name => 'Testing' }
       expect(last_response.body).to eq("Not an ajax request")
    end
    
    it "Send with HTTP_X_REQUESTED_WITH session" do
       get '/send', {}, {"HTTP_X_REQUESTED_WITH" => "XMLHttpRequest" ,'rack.session' => { :name => 'Testing' }}
       expect(last_response.body).to eq("")
    end
    
    it "Send without session" do
       get '/send',env = {}
       except(last_response.body).to eq("")
    end
    
    it "Update" do
       get'/update'
       expect(last_response.body).to eq("Not an ajax request")
    end
    
    it "HTTP_X_REQUESTED_WITH Update" do
		get '/update',{}, {"HTTP_X_REQUESTED_WITH" => "XMLHttpRequest"}
		expect(last_response).to be_ok
	end
	
	it "Get user" do
	    get '/user'
	    expect(last_response.body).to eq("Not an ajax request")
	end
	
	it "User with HTTP_X_REQUESTED_WITH" do
		get '/user',{}, {"HTTP_X_REQUESTED_WITH" => "XMLHttpRequest"}
		expect(last_response).to be_ok
	end
	
	it "chat update" do
		get '/chat/update'
		expect(last_response.body).to eq("Not an ajax request")
	end

	it "chat update with HTTP_X_REQUESTED_WITH" do
		get '/chat/update',{}, {"HTTP_X_REQUESTED_WITH" => "XMLHttpRequest"}
		expect(last_response).to be_ok
	end
 end
