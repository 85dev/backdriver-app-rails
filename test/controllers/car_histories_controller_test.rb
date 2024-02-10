require "test_helper"

class CarHistoriesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get car_histories_index_url
    assert_response :success
  end
end
