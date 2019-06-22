# typed: false
require 'test_helper'

class EventsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @event = create(:event)
    @user = create(:user)
    @admin = create(:admin)
    @editor = create(:editor)
  end

  test 'should get index when not logged in' do
    get events_url
    assert_response :success
    get events_url(collection: 'upcoming')
    assert_response :success
    get events_url(collection: 'past')
    assert_response :success
  end

  test "shouldn't get new when not logged in" do
    get new_event_url
    assert_redirected_to root_path
  end

  test "shouldn't get new when logged in as user" do
    log_in @user
    get new_event_url
    assert_redirected_to root_path
  end

  test 'should get new when logged in as editor' do
    log_in @editor
    get new_event_url
    assert_response :success
  end

  test 'should get new when logged in as admin' do
    log_in @admin
    get new_event_url
    assert_response :success
  end

  test "shouldn't create event when not logged in" do
    assert_no_difference('Event.count') do
      post events_url, params: { event: {
        content: @event.content,
        location: @event.location,
        url: @event.url,
        time: @event.time,
        title: @event.title
      } }
    end

    # assert_redirected_to event_url(Event.last)
    assert_redirected_to root_path
  end

  test "shouldn't create event when logged in as user" do
    log_in @user
    assert_no_difference('Event.count') do
      post events_url, params: { event: {
        content: @event.content,
        location: @event.location,
        url: @event.url,
        time: @event.time,
        title: @event.title
      } }
    end

    # assert_redirected_to event_url(Event.last)
    assert_redirected_to root_path
  end

  test "shouldn't create event when logged in as editor and missing link + location" do
    log_in @editor
    assert_no_difference('Event.count') do
      post events_url, params: { event: {
        content: @event.content,
        time: @event.time,
        title: @event.title
      } }
    end
  end

  test "shouldn't create event when logged in as editor and entered a non-meetup link and no location" do
    log_in @editor
    assert_no_difference('Event.count') do
      post events_url, params: { event: {
        content: @event.content,
        url: Faker::Internet.url,
        time: @event.time,
        title: @event.title
      } }
    end
  end

  test 'should create event when logged in as editor and entered a meetup link and no location' do
    log_in @editor
    assert_difference('Event.count') do
      post events_url, params: { event: {
        content: @event.content,
        url: 'https://www.meetup.com/startupedmonton/events/dgjjmqyzfbdb/',
        time: @event.time,
        title: @event.title
      } }
    end
  end

  test 'should set meetup_id when url is entered' do
    log_in @editor
    post events_url, params: { event: {
      content: @event.content,
      url: 'https://www.meetup.com/startupedmonton/events/dgjjmqyzfbdb/',
      time: @event.time,
      title: @event.title
    } }
    assert_equal 'dgjjmqyzfbdb', Event.last.meetup_id
  end

  test 'should create event when logged in as editor' do
    log_in @editor
    assert_difference('Event.count') do
      post events_url, params: { event: {
        content: @event.content,
        location: @event.location,
        url: @event.url,
        time: @event.time,
        title: @event.title
      } }
    end

    assert_redirected_to event_url(Event.last)
  end

  test 'should create event when logged in as admin' do
    log_in @admin
    assert_difference('Event.count') do
      post events_url, params: { event: {
        content: @event.content,
        location: @event.location,
        url: @event.url,
        time: @event.time,
        title: @event.title
      } }
    end

    assert_redirected_to event_url(Event.last)
  end

  test 'should show event when not logged in' do
    get event_url(@event)
    assert_response :success
  end

  test "shouldn't get edit when not logged in" do
    get edit_event_url(@event)
    assert_redirected_to root_path
  end

  test "shouldn't get edit when logged in as user" do
    log_in @user
    get edit_event_url(@event)
    assert_redirected_to root_path
  end

  test 'should get edit when logged in as editor' do
    log_in @editor
    get edit_event_url(@event)
    assert_response :success
  end

  test 'should get edit when logged in as admin' do
    log_in @admin
    get edit_event_url(@event)
    assert_response :success
  end

  test "shouldn't update event when not logged in" do
    patch event_url(@event), params: { event: {
      content: @event.content,
      location: @event.location,
      url: @event.url,
      time: @event.time,
      title: @event.title
    } }
    # assert_redirected_to event_url(@event)
    assert_redirected_to root_path
  end

  test "shouldn't update event when logged in as user" do
    log_in @user
    patch event_url(@event), params: { event: {
      content: @event.content,
      location: @event.location,
      url: @event.url,
      time: @event.time,
      title: @event.title
    } }
    # assert_redirected_to event_url(@event)
    assert_redirected_to root_path
  end

  test 'should update event when logged in as editor' do
    log_in @editor
    patch event_url(@event), params: { event: {
      content: @event.content,
      location: @event.location,
      url: @event.url,
      time: @event.time,
      title: @event.title
    } }
    assert_redirected_to event_url(@event)
  end

  test 'shouldn\'t update event when logged in as editor and no content' do
    log_in @editor
    patch event_url(@event), params: { event: {
      content: 'bleh',
      location: @event.location,
      url: @event.url,
      time: @event.time,
      title: @event.title
    } }
    @event.reload
    assert_not_equal @event.content, 'bleh'
  end

  test 'should update event when logged in as admin' do
    log_in @admin
    patch event_url(@event), params: { event: {
      content: @event.content,
      location: @event.location,
      url: @event.url,
      time: @event.time,
      title: @event.title
    } }
    assert_redirected_to event_url(@event)
  end

  test "shouldn't destroy event when not logged in" do
    assert_no_difference('Event.count') do
      delete event_url(@event)
    end

    assert_redirected_to root_path
    # assert_redirected_to events_url
  end

  test "shouldn't destroy event when logged in as user" do
    log_in @user
    assert_no_difference('Event.count') do
      delete event_url(@event)
    end

    assert_redirected_to root_path
    # assert_redirected_to events_url
  end

  test 'should destroy event when logged in as editor' do
    log_in @editor
    assert_difference('Event.count', -1) do
      delete event_url(@event)
    end

    assert_redirected_to events_url
  end

  test 'should destroy event when logged in as admin' do
    log_in @admin
    assert_difference('Event.count', -1) do
      delete event_url(@event)
    end

    assert_redirected_to events_url
  end
end
