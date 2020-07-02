require 'rails_helper'

RSpec.describe "Patients", :patients => true, type: :feature do
  let(:user) { FactoryBot.create(:user, :normal) }
  let(:valid_attributes) { FactoryBot.attributes_for(:user) }
  let(:second_user) { FactoryBot.create(:user, :normal) }
  let(:user_admin) { FactoryBot.create(:user, :admin) }

  it "user should see the link to Patients in the navbar" do
    sign_in user
    visit root_path
    expect(page).to have_content I18n.t('header.patient')
    click_link I18n.t('header.patient')
    expect(page).to have_content I18n.t('patient.index')
  end

  it "user creates new patient" do  # add => js:true for screenshot
    @cgdvcode = 1000
    @dia = rand(1...30).to_s
    @mes = ['enero', 'febrero', 'marzo','abril', 'mayo', 'junio', 'agosto', 'septiembre', 'octubre', 'noviembre', 'diciembre'].sample # rand(1...12)
    @anio = rand(1950...2019).to_s
    # user sings-in
    sign_in user
    # goes to patients section
    visit patients_path
    # clicks new patient link
    click_link I18n.t('helpers.submit.create', model: "Nuevo Expediente")
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
    # take_screenshot 
    # TODO: verify patient information
  end

  describe "in the index section" do
    before do
      @p1 = FactoryBot.create(:patient, :active)
      @p2 = FactoryBot.create(:patient, :active)
      @p3 = FactoryBot.create(:patient, :active)
      @p4 = FactoryBot.create(:patient, :inactive)
      sign_in user
      visit patients_path
    end
    it "user sees patient expedients" do
      expect(page).to have_content I18n.t('helpers.edit'), count: 4
      expect(page).to have_content I18n.t('helpers.delete.msg'), count: 4
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

  describe "Existing patient file" do
    # user signs-in
    # visits patients section
    # clicks on a patient expedient
    # edits information
    # verifies new information
  end

  describe "Additional information on an existing patient file (sub-models)", :refclinica => true do
    before do
      @pat = FactoryBot.create(:patient, :active)
    # user signs-in
      sign_in user
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
      # save_page
    end 
    
    # edits Refclinica
    # sees updated information in user expedient
  end 
end
