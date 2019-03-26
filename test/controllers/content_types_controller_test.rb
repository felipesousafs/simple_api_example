require 'test_helper'

class ContentTypesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @content_type = content_types(:one)
  end

  test "should get index" do
    get content_types_url, as: :json
    assert_response :success
  end

  test "should create content_type" do
    assert_difference('ContentType.count') do
      post content_types_url, params: { content_type: { name: @content_type.name } }, as: :json
    end

    assert_response 201
  end

  test "should show content_type" do
    get content_type_url(@content_type), as: :json
    assert_response :success
  end

  test "should update content_type" do
    patch content_type_url(@content_type), params: { content_type: { name: @content_type.name } }, as: :json
    assert_response 200
  end

  test "should destroy content_type" do
    assert_difference('ContentType.count', -1) do
      delete content_type_url(@content_type), as: :json
    end

    assert_response 204
  end
end
