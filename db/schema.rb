# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20100814190402) do

  create_table "boards", :force => true do |t|
    t.integer  "id_user"
    t.text     "comment"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "nresults", :force => true do |t|
    t.integer  "id_track"
    t.integer  "id_pilot"
    t.float    "pp_score"
    t.float    "df_score"
    t.float    "gp_score"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "pilots", :force => true do |t|
    t.string   "fname"
    t.string   "lname"
    t.string   "img_url"
    t.integer  "id_team"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "results", :force => true do |t|
    t.integer  "id_track"
    t.boolean  "is_pp"
    t.integer  "id_pilot"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "selectings", :force => true do |t|
    t.integer  "id_user"
    t.integer  "id_track"
    t.integer  "id_ppilot1"
    t.integer  "id_ppilot2"
    t.integer  "id_ppilot3"
    t.integer  "id_ppilot4"
    t.integer  "id_ppilot5"
    t.integer  "id_gpilot1"
    t.integer  "id_gpilot2"
    t.integer  "id_gpilot3"
    t.integer  "id_gpilot4"
    t.integer  "id_gpilot5"
    t.float    "pp_point"
    t.float    "gp_point"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "selections", :force => true do |t|
    t.integer  "id_user"
    t.integer  "id_track"
    t.integer  "id_pilot1"
    t.integer  "id_pilot2"
    t.integer  "id_pilot3"
    t.integer  "id_userteam"
    t.boolean  "is_bonus"
    t.float    "pp_point"
    t.float    "df_point"
    t.float    "gp_point"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "teams", :force => true do |t|
    t.string   "team_name"
    t.string   "team_img"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tracks", :force => true do |t|
    t.string   "name"
    t.datetime "qualify_time"
    t.string   "track_img_url"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "login"
    t.string   "email"
    t.string   "remember_token"
    t.string   "crypted_password",          :limit => 40
    t.string   "password_reset_code",       :limit => 40
    t.string   "salt",                      :limit => 40
    t.string   "activation_code",           :limit => 40
    t.datetime "remember_token_expires_at"
    t.datetime "activated_at"
    t.datetime "deleted_at"
    t.string   "state",                                   :default => "passive"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
