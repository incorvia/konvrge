# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20120203192335) do

  create_table "answers", :force => true do |t|
    t.text     "content"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.integer  "question_id"
    t.string   "user_name"
    t.string   "user_id"
    t.integer  "vote_count"
    t.integer  "score"
  end

  add_index "answers", ["question_id"], :name => "index_answers_on_question_id"
  add_index "answers", ["user_id"], :name => "index_answers_on_user_id"

  create_table "events", :force => true do |t|
    t.string   "title"
    t.string   "location"
    t.string   "category"
    t.integer  "user_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "score"
    t.string   "user_name"
    t.integer  "vote_count"
  end

  add_index "events", ["category"], :name => "index_events_on_category"
  add_index "events", ["score"], :name => "index_events_on_score"
  add_index "events", ["title"], :name => "index_events_on_title"
  add_index "events", ["user_id"], :name => "index_events_on_user_id"

  create_table "friends", :force => true do |t|
    t.string   "name"
    t.integer  "fb_id"
    t.integer  "user_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "friends", ["fb_id"], :name => "index_friends_on_fb_id"
  add_index "friends", ["name"], :name => "index_friends_on_name"
  add_index "friends", ["user_id"], :name => "index_friends_on_user_id"

  create_table "questions", :force => true do |t|
    t.string   "title"
    t.integer  "user_id"
    t.string   "user_name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "event_id"
    t.integer  "score"
    t.integer  "vote_count"
  end

  add_index "questions", ["event_id"], :name => "index_questions_on_event_id"
  add_index "questions", ["user_id"], :name => "index_questions_on_user_id"

  create_table "rake_logs", :force => true do |t|
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
    t.string   "token"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "name"
    t.string   "fb_id"
    t.string   "username"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["fb_id"], :name => "index_users_on_fb_id"
  add_index "users", ["first_name"], :name => "index_users_on_first_name"
  add_index "users", ["last_name"], :name => "index_users_on_last_name"
  add_index "users", ["name"], :name => "index_users_on_name"
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

  create_table "votes", :force => true do |t|
    t.integer  "user_id"
    t.integer  "event_id"
    t.string   "fb_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.integer  "question_id"
    t.integer  "answer_id"
  end

  add_index "votes", ["answer_id"], :name => "index_votes_on_answer_id"
  add_index "votes", ["event_id"], :name => "index_votes_on_event_id"
  add_index "votes", ["fb_id"], :name => "index_votes_on_fb_id"
  add_index "votes", ["question_id"], :name => "index_votes_on_question_id"
  add_index "votes", ["user_id"], :name => "index_votes_on_user_id"

end
