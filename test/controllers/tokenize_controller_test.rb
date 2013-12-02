require 'test_helper'

class TokenizeControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

end
