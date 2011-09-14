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

ActiveRecord::Schema.define(:version => 20110914000329) do

  create_table "addinfos", :force => true do |t|
    t.integer  "tipo"
    t.string   "info"
    t.integer  "addinformation_id"
    t.string   "addinformation_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "addresses", :force => true do |t|
    t.string   "place"
    t.string   "estado"
    t.string   "municipio"
    t.string   "colonia"
    t.string   "domicilio"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "addresseable_id"
    t.string   "addresseable_type"
    t.integer  "country",           :default => 1
    t.string   "codigopostal"
  end

  create_table "apoyos", :force => true do |t|
    t.string   "tipo"
    t.integer  "patient_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "catalogo_countries", :force => true do |t|
    t.string "country"
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

  create_table "contacts", :force => true do |t|
    t.string   "name"
    t.string   "company"
    t.string   "position"
    t.date     "birth"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "dailyschedules", :force => true do |t|
    t.time     "begin"
    t.time     "end"
    t.integer  "volunteer_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "day"
  end

  create_table "derechohabientes", :force => true do |t|
    t.string   "seguro"
    t.string   "afiliacion"
    t.integer  "patient_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "diagnosticos", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "diagnostico"
    t.integer  "diagnosticable_id"
    t.string   "diagnosticable_type"
  end

  create_table "donors", :force => true do |t|
    t.integer  "cgdvcode"
    t.integer  "persona"
    t.string   "name"
    t.string   "rfc"
    t.date     "birth"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "donors", ["cgdvcode"], :name => "index_donors_on_cgdvcode", :unique => true

  create_table "elements", :force => true do |t|
    t.string   "codigo"
    t.integer  "cantidad"
    t.decimal  "cuota",       :precision => 22, :scale => 2
    t.string   "descripcion"
    t.integer  "note_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "elements", ["note_id"], :name => "index_elements_on_note_id"

  create_table "emails", :force => true do |t|
    t.string   "email"
    t.integer  "emailable_id"
    t.string   "emailable_type"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "datos"
  end

  create_table "extradonors", :force => true do |t|
    t.string   "pautoriza"
    t.string   "pcontacto"
    t.integer  "donor_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "extravolunteers", :force => true do |t|
    t.string   "profesion"
    t.boolean  "sobreviviente"
    t.boolean  "licencia"
    t.boolean  "exposferias"
    t.integer  "volunteer_id"
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
    t.date     "fdefuncion"
    t.date     "faviso"
    t.string   "montocon"
  end

  add_index "patients", ["cgdvcode"], :name => "index_patients_on_cgdvcode", :unique => true

  create_table "providers", :force => true do |t|
    t.string   "proveedor"
    t.integer  "cgdvcode"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "providers", ["cgdvcode"], :name => "index_providers_on_cgdvcode", :unique => true

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

  create_table "socialservices", :force => true do |t|
    t.string   "horas"
    t.string   "escuela"
    t.string   "carrera"
    t.string   "matricula"
    t.string   "semestre"
    t.date     "inicio"
    t.date     "fin"
    t.integer  "volunteer_id"
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

  create_table "subprograms", :force => true do |t|
    t.boolean  "donador"
    t.boolean  "eventos"
    t.boolean  "hospitales"
    t.boolean  "suenosdeseos"
    t.boolean  "fondos"
    t.boolean  "administrativas"
    t.boolean  "autoayuda"
    t.boolean  "sobrevivientes"
    t.boolean  "fugarte"
    t.integer  "volunteer_id"
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

  create_table "timereports", :force => true do |t|
    t.date     "day"
    t.time     "begin"
    t.time     "end"
    t.integer  "volunteer_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "evento"
  end

  add_index "timereports", ["volunteer_id"], :name => "index_timereports_on_volunteer_id"

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
    t.string   "encrypted_password",     :limit => 128, :default => "",       :null => false
    t.string   "salt"
    t.boolean  "admin",                                 :default => false
    t.string   "language"
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                         :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "roles",                                 :default => "--- []"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

  create_table "volunteers", :force => true do |t|
    t.string   "name"
    t.integer  "cgdvcode"
    t.string   "sex"
    t.string   "blood"
    t.integer  "status",     :default => 1
    t.date     "birth"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "volunteers", ["cgdvcode"], :name => "index_volunteers_on_cgdvcode", :unique => true

end
