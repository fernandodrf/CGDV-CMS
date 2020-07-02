require 'rails_helper'

RSpec.describe PagesController, type: :controller do
  describe "#home" do
    before { get :home }
    
    it "responds succesfully" do
      get :home
      expect(response).to be_successful
    end 

    it { should respond_with(200) }
  end
end
