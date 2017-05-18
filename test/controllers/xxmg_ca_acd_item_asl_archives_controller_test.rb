require 'test_helper'

class XxmgCaAcdItemAslArchivesControllerTest < ActionController::TestCase
  setup do
    @xxmg_ca_acd_item_asl_archive = xxmg_ca_acd_item_asl_archives(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:xxmg_ca_acd_item_asl_archives)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create xxmg_ca_acd_item_asl_archive" do
    assert_difference('XxmgCaAcdItemAslArchive.count') do
      post :create, xxmg_ca_acd_item_asl_archive: { action: @xxmg_ca_acd_item_asl_archive.action, created_by: @xxmg_ca_acd_item_asl_archive.created_by, creation_date: @xxmg_ca_acd_item_asl_archive.creation_date, error_messages: @xxmg_ca_acd_item_asl_archive.error_messages, ewie_item: @xxmg_ca_acd_item_asl_archive.ewie_item, last_update_date: @xxmg_ca_acd_item_asl_archive.last_update_date, last_update_login: @xxmg_ca_acd_item_asl_archive.last_update_login, last_updated_by: @xxmg_ca_acd_item_asl_archive.last_updated_by, plant_code: @xxmg_ca_acd_item_asl_archive.plant_code, purchase_uom: @xxmg_ca_acd_item_asl_archive.purchase_uom, record_status: @xxmg_ca_acd_item_asl_archive.record_status, request_id: @xxmg_ca_acd_item_asl_archive.request_id, supplier: @xxmg_ca_acd_item_asl_archive.supplier, supplier_item: @xxmg_ca_acd_item_asl_archive.supplier_item, supplier_site: @xxmg_ca_acd_item_asl_archive.supplier_site, updated_by: @xxmg_ca_acd_item_asl_archive.updated_by }
    end

    assert_redirected_to xxmg_ca_acd_item_asl_archive_path(assigns(:xxmg_ca_acd_item_asl_archive))
  end

  test "should show xxmg_ca_acd_item_asl_archive" do
    get :show, id: @xxmg_ca_acd_item_asl_archive
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @xxmg_ca_acd_item_asl_archive
    assert_response :success
  end

  test "should update xxmg_ca_acd_item_asl_archive" do
    patch :update, id: @xxmg_ca_acd_item_asl_archive, xxmg_ca_acd_item_asl_archive: { action: @xxmg_ca_acd_item_asl_archive.action, created_by: @xxmg_ca_acd_item_asl_archive.created_by, creation_date: @xxmg_ca_acd_item_asl_archive.creation_date, error_messages: @xxmg_ca_acd_item_asl_archive.error_messages, ewie_item: @xxmg_ca_acd_item_asl_archive.ewie_item, last_update_date: @xxmg_ca_acd_item_asl_archive.last_update_date, last_update_login: @xxmg_ca_acd_item_asl_archive.last_update_login, last_updated_by: @xxmg_ca_acd_item_asl_archive.last_updated_by, plant_code: @xxmg_ca_acd_item_asl_archive.plant_code, purchase_uom: @xxmg_ca_acd_item_asl_archive.purchase_uom, record_status: @xxmg_ca_acd_item_asl_archive.record_status, request_id: @xxmg_ca_acd_item_asl_archive.request_id, supplier: @xxmg_ca_acd_item_asl_archive.supplier, supplier_item: @xxmg_ca_acd_item_asl_archive.supplier_item, supplier_site: @xxmg_ca_acd_item_asl_archive.supplier_site, updated_by: @xxmg_ca_acd_item_asl_archive.updated_by }
    assert_redirected_to xxmg_ca_acd_item_asl_archive_path(assigns(:xxmg_ca_acd_item_asl_archive))
  end

  test "should destroy xxmg_ca_acd_item_asl_archive" do
    assert_difference('XxmgCaAcdItemAslArchive.count', -1) do
      delete :destroy, id: @xxmg_ca_acd_item_asl_archive
    end

    assert_redirected_to xxmg_ca_acd_item_asl_archives_path
  end
end
