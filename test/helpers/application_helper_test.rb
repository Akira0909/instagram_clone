class ApplicationHelperTest < ActionView::TestCase
  test "full title helper" do
    assert_equal full_title, "Instagram Clone"
    assert_equal full_title("ログイン"), "ログイン | Instagram Clone"
  end
end