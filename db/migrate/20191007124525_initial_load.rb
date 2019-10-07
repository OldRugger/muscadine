class InitialLoad < ActiveRecord::Migration[6.0]
  def change
    create_table "day1_awts", force: true do |t|
      t.string   "entryclass"
      t.float    "runner1_float_time"
      t.time     "runner1_time"
      t.integer  "runner1_id"
      t.float    "runner2_float_time"
      t.time     "runner2_time"
      t.integer  "runner2_id"
      t.float    "runner3_float_time"
      t.time     "runner3_time"
      t.integer  "runner3_id"
      t.float    "awt_float_time"
      t.time     "awt_time"
      t.float    "cat_float_time"
      t.time     "cat_time"
      t.datetime "created_at"
      t.datetime "updated_at"
    end

    create_table "day2_awts", force: true do |t|
      t.string   "entryclass"
      t.float    "runner1_float_time"
      t.time     "runner1_time"
      t.integer  "runner1_id"
      t.float    "runner2_float_time"
      t.time     "runner2_time"
      t.integer  "runner2_id"
      t.float    "runner3_float_time"
      t.time     "runner3_time"
      t.integer  "runner3_id"
      t.float    "awt_float_time"
      t.time     "awt_time"
      t.float    "cat_float_time"
      t.time     "cat_time"
      t.datetime "created_at"
      t.datetime "updated_at"
    end

    create_table "runners", force: true do |t|
      t.integer  "database_id"
      t.string   "surname"
      t.string   "firstname"
      t.string   "gender"
      t.string   "school"
      t.string   "entryclass"
      t.time     "time1"
      t.float    "float_time1"
      t.string   "classifier1"
      t.time     "time2"
      t.float    "float_time2"
      t.string   "classifier2"
      t.time     "total_time"
      t.float    "float_total_time"
      t.float    "day1_score"
      t.float    "day2_score"
      t.datetime "created_at"
      t.datetime "updated_at"
    end

    create_table "team_members", force: true do |t|
      t.integer  "team_id"
      t.integer  "runner_id"
      t.datetime "created_at"
      t.datetime "updated_at"
    end

    add_index "team_members", ["runner_id"], name: "index_team_members_on_runner_id"
    add_index "team_members", ["team_id"], name: "index_team_members_on_team_id"

    create_table "teams", force: true do |t|
      t.string   "name"
      t.string   "entryclass"
      t.string   "JROTC_branch"
      t.float    "day1_score"
      t.float    "day2_score"
      t.float    "total_score"
      t.float    "sort_score"
      t.string   "school"
      t.datetime "created_at"
      t.datetime "updated_at"
    end
  end
end
