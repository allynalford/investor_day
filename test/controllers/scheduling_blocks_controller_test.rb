require 'test_helper'

class SchedulingBlocksControllerTest < ActionController::TestCase
  setup do
    @scheduling_block = scheduling_blocks(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:scheduling_blocks)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create scheduling_block" do
    assert_difference('SchedulingBlock.count') do
      post :create, scheduling_block: { bookable: @scheduling_block.bookable, start_time: @scheduling_block.start_time }
    end

    assert_redirected_to scheduling_block_path(assigns(:scheduling_block))
  end

  test "should show scheduling_block" do
    get :show, id: @scheduling_block
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @scheduling_block
    assert_response :success
  end

  test "should update scheduling_block" do
    patch :update, id: @scheduling_block, scheduling_block: { bookable: @scheduling_block.bookable, start_time: @scheduling_block.start_time }
    assert_redirected_to scheduling_block_path(assigns(:scheduling_block))
  end

  test "should destroy scheduling_block" do
    assert_difference('SchedulingBlock.count', -1) do
      delete :destroy, id: @scheduling_block
    end

    assert_redirected_to scheduling_blocks_path
  end
end
