require 'rails_helper'

RSpec.describe User, type: :model do
  subject{ User.new(email: "sdfs" password:"123456")}
  it "is not vaild with valid attributes" do 
    
  end
end
