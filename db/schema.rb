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

ActiveRecord::Schema.define(:version => 20110806015033) do

  create_table "addresses", :force => true do |t|
    t.string   "place"
    t.integer  "codigopostal"
    t.string   "estado"
    t.string   "municipio"
    t.string   "colonia"
    t.string   "domicilio"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "addresseable_id"
    t.string   "addresseable_type"
  end

  create_table "apoyos", :force => true do |t|
    t.string   "tipo"
    t.integer  "patient_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "catalogo_derechohabientes", :force => true do |t|
    t.string   "seguro"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "catalogo_diagnosticos", :force => true do |t|
    t.string   "diagnostico"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "comments", :force => true do |t|
    t.text     "comment"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "commentable_id"
    t.string   "commentable_type"
  end

  create_table "derechohabientes", :force => true do |t|
    t.string   "seguro"
    t.string   "afiliacion"
    t.integer  "patient_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "diagnosticos", :force => true do |t|
    t.integer  "patient_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "diagnostico"
  end

  create_table "elements", :force => true do |t|
    t.string   "codigo"
    t.integer  "cantidad"
    t.decimal  "cuota",       :precision => 22, :scale => 2
    t.string   "descripcion"
    t.integer  "note_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "family_members", :force => true do |t|
    t.string   "parentesco"
    t.string   "nombre"
    t.integer  "edad"
    t.string   "derechohabiente"
    t.string   "comentarios"
    t.integer  "patient_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "houses", :force => true do |t|
    t.integer  "habitaciones"
    t.string   "tipo"
    t.integer  "habitantes"
    t.integer  "familiares"
    t.integer  "menores"
    t.integer  "economicaactivas"
    t.integer  "patient_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "notes", :force => true do |t|
    t.integer  "folio"
    t.decimal  "adeudo",     :precision => 22, :scale => 2
    t.decimal  "acuenta",    :precision => 22, :scale => 2
    t.decimal  "restan",     :precision => 22, :scale => 2
    t.decimal  "subtotal",   :precision => 22, :scale => 2
    t.decimal  "total",      :precision => 22, :scale => 2
    t.date     "fecha"
    t.integer  "patient_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "notes", ["folio"], :name => "index_notes_on_folio", :unique => true
  add_index "notes", ["patient_id"], :name => "index_notes_on_patient_id"

  create_table "patients", :force => true do |t|
    t.string   "name"
    t.integer  "cgdvcode"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "sex"
    t.date     "birthdate"
    t.string   "blod"
    t.integer  "status",     :default => 1
  end

  add_index "patients", ["cgdvcode"], :name => "index_patients_on_cgdvcode", :unique => true

  create_table "refclinicas", :force => true do |t|
    t.string   "hospital"
    t.string   "medico"
    t.date     "referencia"
    t.string   "aceptado"
    t.string   "ayudas"
    t.integer  "patient_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "socioecos", :force => true do |t|
    t.integer  "ingresos"
    t.integer  "gastos"
    t.integer  "televisiones"
    t.integer  "vehiculos"
    t.string   "nivel"
    t.string   "serviciosurbanos"
    t.string   "televisionpaga"
    t.string   "sgmm"
    t.integer  "patient_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "telephones", :force => true do |t|
    t.string   "place"
    t.string   "number"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "telephoneable_id"
    t.string   "telephoneable_type"
  end

  create_table "tratamientos", :force => true do |t|
    t.string   "tipo"
    t.integer  "patient_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "encrypted_password"
    t.string   "salt"
    t.boolean  "admin",              :default => false
    t.string   "language"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true

end
