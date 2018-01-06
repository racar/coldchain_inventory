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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20180105142839) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_admin_comments", force: :cascade do |t|
    t.string   "namespace"
    t.text     "body"
    t.string   "resource_type"
    t.integer  "resource_id"
    t.string   "author_type"
    t.integer  "author_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.index ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id", using: :btree
    t.index ["namespace"], name: "index_active_admin_comments_on_namespace", using: :btree
    t.index ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id", using: :btree
  end

  create_table "admin_users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.index ["email"], name: "index_admin_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true, using: :btree
  end

  create_table "categories", force: :cascade do |t|
    t.string   "nombre"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "delayed_jobs", force: :cascade do |t|
    t.integer  "priority",   default: 0, null: false
    t.integer  "attempts",   default: 0, null: false
    t.text     "handler",                null: false
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.string   "queue"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["priority", "run_at"], name: "delayed_jobs_priority", using: :btree
  end

  create_table "institucions", force: :cascade do |t|
    t.string   "name"
    t.integer  "municipio_id"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.string   "caracter"
    t.string   "direccion"
    t.string   "nit"
    t.string   "cod_habilitacion"
    t.string   "temperatura"
  end

  create_table "items", force: :cascade do |t|
    t.string   "name"
    t.string   "category"
    t.integer  "quantity"
    t.text     "description"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.integer  "remaining_quantity"
    t.string   "marca"
    t.string   "modelo"
    t.string   "serial"
    t.string   "mantenimiento"
    t.string   "num_manten_year"
    t.string   "regulador"
    t.string   "monitoreo"
    t.integer  "tipo_id"
    t.string   "volumen"
    t.string   "num_paquetes"
    t.integer  "institucion_id"
    t.string   "tipo"
    t.string   "potencia"
    t.string   "cargador_bateria"
    t.string   "transfer_automatica"
    t.string   "capacidad_refrigeracion"
    t.string   "dimensiones"
    t.string   "funciona"
    t.string   "compresor"
    t.string   "num_compresores"
  end

  create_table "mantenimientos", force: :cascade do |t|
    t.integer  "man_programados"
    t.integer  "man_realizados"
    t.string   "observaciones"
    t.date     "fecha_firma"
    t.date     "fecha_vigencia"
    t.string   "supervisor"
    t.string   "cargo_supervisor"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.integer  "item_id"
    t.date     "fecha_man1"
    t.date     "fecha_man2"
    t.date     "fecha_man3"
    t.date     "fecha_man4"
    t.date     "fecha_man5"
    t.date     "fecha_man6"
    t.date     "fecha_man7"
    t.date     "fecha_man8"
    t.date     "fecha_man9"
    t.date     "fecha_man10"
    t.date     "fecha_man11"
    t.date     "fecha_man12"
  end

  create_table "marcas", force: :cascade do |t|
    t.string   "nombre"
    t.integer  "category_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "members", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.string   "phone"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "modelos", force: :cascade do |t|
    t.string   "nombre"
    t.integer  "marca_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "category_id"
  end

  create_table "municipios", force: :cascade do |t|
    t.string   "name"
    t.string   "region"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "orders", force: :cascade do |t|
    t.string   "quantity"
    t.boolean  "status"
    t.date     "expire_at"
    t.integer  "item_id"
    t.integer  "member_id"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.integer  "institucion_id"
    t.integer  "category_id"
    t.index ["item_id"], name: "index_orders_on_item_id", using: :btree
    t.index ["member_id"], name: "index_orders_on_member_id", using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.integer  "institucion_id"
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  end

  add_foreign_key "orders", "items"
  add_foreign_key "orders", "members"
end
