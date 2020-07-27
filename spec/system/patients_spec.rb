require 'rails_helper'

RSpec.describe "Patients", :patients => true, type: :system do
  # Lazy loading of upper model
  let (:volunteer) { FactoryBot.create(:volunteer, :vol) }

  let(:user) { FactoryBot.create(:user, :normal, volunteer_id: volunteer.id) }
  let(:valid_attributes) { FactoryBot.attributes_for(:user) }
  let(:second_user) { FactoryBot.create(:user, :normal, volunteer_id: volunteer.id) }
  let(:user_admin) { FactoryBot.create(:user, :admin, volunteer_id: volunteer.id) }

  describe "users with admin or oficina role" do
    before do
      user.add_role!('oficina')
    end

    pending "test for roles"

    it "should see the link to Patients in the navbar and be able to click it" do
      # sign_in user
      # FIXME: Correct when Devise is updated to 4.1.1
      mysign_in(user.email,user.password)
      visit root_path
      expect(page).to have_content I18n.t('header.patient')
      click_link I18n.t('header.patient'), match: :first
      expect(page).to have_content I18n.t('patient.index')
    end
    it "should be able to creates new patient" do  # add => js:true for screenshot
      @cgdvcode = 1000
      @dia = rand(1...30).to_s
      @mes = ['enero', 'febrero', 'marzo','abril', 'mayo', 'junio', 'agosto', 'septiembre', 'octubre', 'noviembre', 'diciembre'].sample # rand(1...12)
      @anio = rand(1950...2019).to_s
      # user sings-in
      # sign_in user
      # FIXME: Correct when Devise is updated to 4.1.1
      mysign_in(user.email,user.password)
      # goes to patients section
      visit patients_path
      # clicks new patient link
      click_link I18n.t('helpers.submit.create', model: "Nuevo Paciente")
      # fills in patient information
      select 'Activo', from: 'patient_status'
      fill_in I18n.t('patient.cgdvcode'), with: @cgdvcode
      fill_in I18n.t('patient.name'), with: Faker::Name.name
      select @dia , from: 'patient_birthdate_3i'
      select @mes , from: 'patient_birthdate_2i'
      select @anio , from: 'patient_birthdate_1i'
      select ['F', 'M'].sample , from: 'patient_sex'
      select Patient::BLOODTYPES.sample , from: 'patient_blod'
      # submits form
      click_button I18n.t('helpers.create')
      # sees new patient
      expect(page).to have_content I18n.t('flash.success.create', :model => Patient.to_s)
      # take_screenshot 
      # screenshot_and_save_page
    end
    pending "create sub-modules"
    pending "create attachments"
  end


  describe "in the index section" do
    before do
      @p1 = FactoryBot.create(:patient, :active)
      @p2 = FactoryBot.create(:patient, :active)
      @p3 = FactoryBot.create(:patient, :active)
      @p4 = FactoryBot.create(:patient, :inactive)
      user.add_role!('oficina')
      # sign_in user
      # FIXME: Correct when Devise is updated to 4.1.1
      mysign_in(user.email,user.password)
      visit patients_path
    end
    
    it "admin user can delete records" do
      mysign_out
      mysign_in(user_admin.email,user_admin.password)
      visit patients_path
      expect(page).to have_content I18n.t('helpers.print'), count: 4
      expect(page).to have_content I18n.t('helpers.delete.msg'), count: 4
    end

    it "user sees patient records but cant delete them" do
      expect(page).to have_content I18n.t('helpers.print'), count: 4
      expect(page).to_not have_content I18n.t('helpers.delete.msg'), count: 4
    end
    it "user clicks patient expedient and sees basic information" do
      # user sings in
      # visits patients index
      # clicks on a patient expedient
      click_link "#{@p1.cgdvcode}"
      # sees information of the expedient
      expect(page).to have_content @p1.name
      expect(page).to have_content @p1.cgdvcode
    end
  end

  xdescribe "Existing patient file" do
    # user signs-in
    # visits patients section
    # clicks on a patient expedient
    # edits information
    # verifies new information
  end

  describe "additional information on an existing patient file (sub-models)", :current => true do
    before do
      @pat = FactoryBot.create(:patient, :active)
      # user signs-in
      # sign_in user
      # FIXME: Correct when Devise is updated to 4.1.1
      user.add_role!('oficina')
      mysign_in(user.email,user.password)
      # visits patients section
      visit patients_path
      # clicks on a patient expedient
      click_link "#{@pat.cgdvcode}"
    end
    #===== As of here is the sub-model information generated =====#
    it "is able to create Refclinica information" do
      @hospital = Faker::Artist.name
      @medico = Faker::Name.name_with_middle
      @aceptado = Faker::Name.name_with_middle
      @ayudas = Faker::Lorem.sentence
      @dia = rand(1...30).to_s
      @mes = ['enero', 'febrero', 'marzo','abril', 'mayo', 'junio', 'agosto', 'septiembre', 'octubre', 'noviembre', 'diciembre'].sample # rand(1...12)
      @anio = rand(2018...2022).to_s
      # creates Refclinica
      click_link I18n.t('helpers.submit.create', :model => "Referencia Clinica")
      # populate information
      fill_in I18n.t('refclinica.hospital'), with: @hospital
      fill_in I18n.t('refclinica.medico'), with: @medico
      fill_in I18n.t('refclinica.aceptado'), with: @aceptado
      select @dia , from: 'refclinica_referencia_3i'
      select @mes , from: 'refclinica_referencia_2i'
      select @anio , from: 'refclinica_referencia_1i'
      fill_in I18n.t('refclinica.ayudas'), with: @ayudas
      click_button I18n.t('helpers.create')
      # verifies information
      # TODO: mejorar verificacion de datos
      expect(page).to have_content @hospital
      expect(page).to have_content @medico
      expect(page).to have_content @aceptado
      expect(page).to have_content @ayudas
      # verificar manualmente
      # screenshot_and_save_page
    end

    it "is able to create Telephone" do
      @place = Faker::Lorem.word
      @tel = Faker::PhoneNumber.phone_number
      click_link I18n.t('helpers.submit.create', :model => "Telefono")
      fill_in I18n.t('patient.place'), with: @place
      fill_in I18n.t('patient.number'), with: @tel
      click_button I18n.t('helpers.create')
      # verifies information
      expect(page).to have_content @place
      expect(page).to have_content @tel
    end
    
    it "is able to create email" do
      @datos = Faker::Lorem.word
      @email = Faker::Internet.email
      click_link I18n.t('helpers.submit.create', :model => "Emails")
      fill_in 'email_datos', with: @datos
      fill_in 'email_email', with: @email
      click_button I18n.t('helpers.create')
      # verifies information
      expect(page).to have_content @datos
      expect(page).to have_content @email
    end

    it "is able to create Direccion" do
      @domicilio = Faker::Address.street_address
      @estado = Faker::Address.state
      @cp = Faker::Address.zip_code
      @pais = 'México'
      click_link I18n.t('helpers.submit.create', :model => "Direccion")
      fill_in I18n.t('address.domicilio'), with: @domicilio
      select @pais, from: 'address_country'
      fill_in I18n.t('address.estado'), with: @estado
      fill_in I18n.t('address.codigopostal'), with: @cp
      click_button I18n.t('helpers.create')
      # verifies information
      expect(page).to have_content @domicilio
      expect(page).to have_content @estado
      expect(page).to have_content @cp
    end

    it "is able to create Derechohabiente" do
      @seguro = ['IMSS', 'ISSSTE', 'Sedena','Beneficencia', 'Sector Salud Estatal', 'Semar', 'Privado', 'SSGDF', 'SSA', 'Otros', 'ISSEMYM', 'Seguro Popular'].sample
      @seguroid = Faker::IDNumber.valid
      # puts "seguroid: #{@seguroid.inspect}"
      click_link I18n.t('helpers.submit.create', :model => "Derechohabiente")
      select @seguro, from: 'derechohabiente_seguro'
      fill_in I18n.t('derechohabiente.afiliacion'), with: @seguroid
      click_button I18n.t('helpers.create')
      # verifies information
      expect(page).to have_content @seguro
      expect(page).to have_content @seguroid
    end

    it "is able to create Tratamientos" do
      @trat = Tratamiento::TIPOS.sample
      click_link I18n.t('helpers.submit.create', :model => "Tratamiento")
      select @trat, from: 'tratamiento_tipo'
      click_button I18n.t('helpers.create')
      # verifies information
      expect(page).to have_content @trat
    end

    pending "is able to edit additional information"
    # edits Refclinica
    # sees updated information in user expedient
  end 

end
