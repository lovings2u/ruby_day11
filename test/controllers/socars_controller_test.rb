require 'test_helper'

class SocarsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get socars_index_url
    assert_response :success
  end

  test "should get show" do
    get socars_show_url
    assert_response :success
  end

  test "should get new" do
    get socars_new_url
    assert_response :success
  end

  test "should get edit" do
    get socars_edit_url
    assert_response :success
  end

end
