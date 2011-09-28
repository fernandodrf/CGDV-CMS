require 'test_helper'

class ActivityReportsControllerTest < ActionController::TestCase
  def test_index
    get :index
    assert_template 'index'
  end

  def test_show
    get :show, :id => ActivityReport.first
    assert_template 'show'
  end

  def test_new
    get :new
    assert_template 'new'
  end

  def test_create_invalid
    ActivityReport.any_instance.stubs(:valid?).returns(false)
    post :create
    assert_template 'new'
  end

  def test_create_valid
    ActivityReport.any_instance.stubs(:valid?).returns(true)
    post :create
    assert_redirected_to activity_report_url(assigns(:activity_report))
  end

  def test_edit
    get :edit, :id => ActivityReport.first
    assert_template 'edit'
  end

  def test_update_invalid
    ActivityReport.any_instance.stubs(:valid?).returns(false)
    put :update, :id => ActivityReport.first
    assert_template 'edit'
  end

  def test_update_valid
    ActivityReport.any_instance.stubs(:valid?).returns(true)
    put :update, :id => ActivityReport.first
    assert_redirected_to activity_report_url(assigns(:activity_report))
  end

  def test_destroy
    activity_report = ActivityReport.first
    delete :destroy, :id => activity_report
    assert_redirected_to activity_reports_url
    assert !ActivityReport.exists?(activity_report.id)
  end
end
