require 'test_helper'

class PatientsControllerTest < ActionController::TestCase
  test "should get new" do
    get :new
    assert_response :success
  end

end
