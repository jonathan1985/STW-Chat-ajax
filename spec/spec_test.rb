require_relative '../chat.rb'
require 'spec_helper.rb'
require 'coveralls'

Coveralls.wear!

describe 'make API call to load path' do
   it "should load the home page" do
      visit 'http://desolate-shelf-1169.herokuapp.com/'
      expect(page).to have_content("Chat")
   end
end

describe 'login page' do
   it 'lets the user login' do
      visit 'http://desolate-shelf-1169.herokuapp.com/'
      within("#username") do
        fill_in('name', :with => 'Hikoreko')
      end
      click_on('Sing In')
      visit 'http://desolate-shelf-1169.herokuapp.com/chat'
      expect(page).to have_content("Hikoreko")
      #page.should have_content('welcome..')
   end
end

describe 'chat page' do
   it 'load chat fine' do
      visit 'http://desolate-shelf-1169.herokuapp.com/chat'
      expect(page).to have_content("welcome..")
      expect(page).to have_content("Logout")
      expect(page).to have_content("Enviar")
      expect(page).to have_content("Usuarios Conectados")
   end
end

describe 'chat page' do
   it 'have a chat with the chat' do
      visit 'http://desolate-shelf-1169.herokuapp.com/chat'
      fill_in 'text', :with => 'Hello!!'
      click_on('Enviar')
      expect(page).to have_content("Hello!!")
   end
end


