# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2012_06_01_021943) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "activity_reports", force: :cascade do |t|
    t.text "reporte"
    t.integer "semana"
    t.integer "volunteer_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "addinfos", force: :cascade do |t|
    t.integer "tipo"
    t.string "info"
    t.integer "addinformation_id"
    t.string "addinformation_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "addresses", force: :cascade do |t|
    t.string "place"
    t.string "estado"
    t.string "municipio"
    t.string "colonia"
    t.string "domicilio"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "addresseable_id"
    t.string "addresseable_type"
    t.integer "country", default: 1
    t.string "codigopostal"
  end

  create_table "apoyos", force: :cascade do |t|
    t.string "tipo"
    t.integer "patient_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "attachments", force: :cascade do |t|
    t.string "name"
    t.string "fileattachment"
    t.integer "attachable_id"
    t.string "attachable_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "catalogo_countries", force: :cascade do |t|
    t.string "country"
  end

  create_table "catalogo_derechohabientes", force: :cascade do |t|
    t.string "seguro"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "catalogo_diagnosticos", force: :cascade do |t|
    t.string "diagnostico"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "catestados", force: :cascade do |t|
    t.string "estado"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "comments", force: :cascade do |t|
    t.text "comment"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "commentable_id"
    t.string "commentable_type"
  end

  create_table "contacts", force: :cascade do |t|
    t.string "name"
    t.string "company"
    t.string "position"
    t.date "birth"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "dailyschedules", force: :cascade do |t|
    t.time "begin"
    t.time "end"
    t.integer "volunteer_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "day"
  end

  create_table "derechohabientes", force: :cascade do |t|
    t.string "seguro"
    t.string "afiliacion"
    t.integer "patient_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "diagnosticos", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "diagnostico"
    t.integer "diagnosticable_id"
    t.string "diagnosticable_type"
  end

  create_table "donations", force: :cascade do |t|
    t.integer "folio"
    t.integer "donor_id"
    t.date "frecepcion"
    t.integer "tipo"
    t.string "monto"
    t.string "transaccion"
    t.string "finalidad"
    t.integer "motivo"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["donor_id"], name: "index_donations_on_donor_id"
  end

  create_table "donors", force: :cascade do |t|
    t.integer "cgdvcode"
    t.integer "persona"
    t.string "name"
    t.string "rfc"
    t.date "birth"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["cgdvcode"], name: "index_donors_on_cgdvcode", unique: true
  end

  create_table "elements", force: :cascade do |t|
    t.string "codigo"
    t.integer "cantidad"
    t.decimal "cuota", precision: 22, scale: 2
    t.string "descripcion"
    t.integer "note_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["note_id"], name: "index_elements_on_note_id"
  end

  create_table "emails", force: :cascade do |t|
    t.string "email"
    t.integer "emailable_id"
    t.string "emailable_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "datos"
  end

  create_table "events", force: :cascade do |t|
    t.string "name"
    t.datetime "start_at"
    t.datetime "end_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "extradonors", force: :cascade do |t|
    t.string "pautoriza"
    t.string "pcontacto"
    t.integer "donor_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "extravolunteers", force: :cascade do |t|
    t.string "profesion"
    t.integer "volunteer_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "family_members", force: :cascade do |t|
    t.string "parentesco"
    t.string "nombre"
    t.integer "edad"
    t.string "derechohabiente"
    t.string "comentarios"
    t.integer "patient_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "houses", force: :cascade do |t|
    t.integer "habitaciones"
    t.string "tipo"
    t.integer "habitantes"
    t.integer "familiares"
    t.integer "menores"
    t.integer "economicaactivas"
    t.integer "patient_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "notes", force: :cascade do |t|
    t.integer "folio"
    t.decimal "adeudo", precision: 22, scale: 2
    t.decimal "acuenta", precision: 22, scale: 2
    t.decimal "restan", precision: 22, scale: 2
    t.decimal "subtotal", precision: 22, scale: 2
    t.decimal "total", precision: 22, scale: 2
    t.date "fecha"
    t.integer "patient_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["folio"], name: "index_notes_on_folio", unique: true
    t.index ["patient_id"], name: "index_notes_on_patient_id"
  end

  create_table "patients", force: :cascade do |t|
    t.string "name"
    t.integer "cgdvcode"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "sex"
    t.date "birthdate"
    t.string "blod"
    t.integer "status", default: 1
    t.date "fdefuncion"
    t.date "faviso"
    t.string "montocon"
    t.index ["cgdvcode"], name: "index_patients_on_cgdvcode", unique: true
  end

  create_table "providers", force: :cascade do |t|
    t.string "proveedor"
    t.integer "cgdvcode"
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["cgdvcode"], name: "index_providers_on_cgdvcode", unique: true
  end

  create_table "refclinicas", force: :cascade do |t|
    t.string "hospital"
    t.string "medico"
    t.date "referencia"
    t.string "aceptado"
    t.string "ayudas"
    t.integer "patient_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "socialservices", force: :cascade do |t|
    t.string "escuela"
    t.string "carrera"
    t.string "matricula"
    t.string "semestre"
    t.date "inicio"
    t.date "fin"
    t.integer "volunteer_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "socioecos", force: :cascade do |t|
    t.integer "ingresos"
    t.integer "gastos"
    t.integer "televisiones"
    t.integer "vehiculos"
    t.string "nivel"
    t.string "serviciosurbanos"
    t.string "televisionpaga"
    t.string "sgmm"
    t.integer "patient_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "subprograms", force: :cascade do |t|
    t.boolean "donador"
    t.boolean "eventos"
    t.boolean "hospitales"
    t.boolean "suenosdeseos"
    t.boolean "fondos"
    t.boolean "administrativas"
    t.boolean "autoayuda"
    t.boolean "sobrevivientes"
    t.boolean "fugarte"
    t.integer "volunteer_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "sobreviviente"
    t.boolean "licencia"
    t.boolean "exposferias"
    t.boolean "disenografico"
    t.boolean "abogacia"
    t.boolean "invdocumental"
    t.boolean "invmedica"
    t.boolean "apoyofueraoficina"
    t.boolean "disenoweb"
    t.boolean "apoyocap"
  end

  create_table "telephones", force: :cascade do |t|
    t.string "place"
    t.string "number"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "telephoneable_id"
    t.string "telephoneable_type"
  end

  create_table "timereports", force: :cascade do |t|
    t.date "day"
    t.time "begin"
    t.time "end"
    t.integer "volunteer_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "evento"
    t.index ["volunteer_id"], name: "index_timereports_on_volunteer_id"
  end

  create_table "tratamientos", force: :cascade do |t|
    t.string "tipo"
    t.integer "patient_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "encrypted_password", limit: 128, default: "", null: false
    t.boolean "admin", default: false
    t.string "language"
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.string "roles", default: "--- []"
    t.integer "volunteer_id"
    t.string "avatar"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "vol_times", force: :cascade do |t|
    t.string "evento"
    t.integer "horas"
    t.integer "volunteer_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["volunteer_id"], name: "index_vol_times_on_volunteer_id"
  end

  create_table "volunteers", force: :cascade do |t|
    t.string "name"
    t.integer "cgdvcode"
    t.string "sex"
    t.string "blood"
    t.integer "status", default: 1
    t.date "birth"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "avatar"
    t.index ["cgdvcode"], name: "index_volunteers_on_cgdvcode", unique: true
  end

end
