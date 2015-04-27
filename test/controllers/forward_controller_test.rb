require "test_helper"

class ForwardControllerTest < ActionController::TestCase
  test "stores a cookie which will be used to redirect later" do
    post :store_redirect, redirect_url: "http://example.org"

    assert_response :success
    assert_equal "http://example.org", cookies[:will_redirect_to]
  end

  test "shows a failure message when no cookie is present" do
    get :redirect

    assert_response :bad_request, "No `will_redirect_to` cookie was supplied!"
  end

  test "redirects to the location specified in the cookie, keeping the
        original request intact" do
    cookies[:will_redirect_to] = root_url
    get :redirect, some: "useless param"

    assert_redirected_to root_url(some: "useless param")
  end
end
