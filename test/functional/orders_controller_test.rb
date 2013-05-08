require 'test_helper'

class OrdersControllerTest < ActionController::TestCase
  setup do
    @order = orders(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:orders)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create order" do
    assert_difference('Order.count') do
      post :create, order: { addressId: @order.addressId, arrivalDate: @order.arrivalDate, arrivalTime: @order.arrivalTime, orderDate: @order.orderDate, qty: @order.qty, rut: @order.rut, sku: @order.sku, state: @order.state, unit: @order.unit }
    end

    assert_redirected_to order_path(assigns(:order))
  end

  test "should show order" do
    get :show, id: @order
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @order
    assert_response :success
  end

  test "should update order" do
    put :update, id: @order, order: { addressId: @order.addressId, arrivalDate: @order.arrivalDate, arrivalTime: @order.arrivalTime, orderDate: @order.orderDate, qty: @order.qty, rut: @order.rut, sku: @order.sku, state: @order.state, unit: @order.unit }
    assert_redirected_to order_path(assigns(:order))
  end

  test "should destroy order" do
    assert_difference('Order.count', -1) do
      delete :destroy, id: @order
    end

    assert_redirected_to orders_path
  end
end
