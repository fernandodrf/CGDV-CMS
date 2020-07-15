require 'rails_helper'

RSpec.feature "Volunteers", type: :feature do
  let(:user) { FactoryBot.create(:user, :admin) }
  # let(:valid_attributes) { FactoryBot.attributes_for(:user) }

  describe "users with admin or oficina role" do
    before do
      user.add_role!('oficina')
    end

    it "should see the link to Volunteer in the navbar and be able to click it" do
      # sign_in user
      # FIXME: Correct when Devise is updated to 4.1.1
      mysign_in(user.email,user.password)
      visit root_path
      expect(page).to have_content I18n.t('header.volunteer')
      click_link I18n.t('header.volunteer'), match: :first
      expect(page).to have_content I18n.t('volunteer.index')
    end
    it "should be able to creates new volunteer" do
      @cgdvcode = 1000
      @dia = rand(1...30).to_s
      @mes = ['enero', 'febrero', 'marzo','abril', 'mayo', 'junio', 'agosto', 'septiembre', 'octubre', 'noviembre', 'diciembre'].sample # rand(1...12)
      @anio = rand(1950...2019).to_s
      @name = Faker::Name.name
      # user sings-in
      # sign_in user
      # FIXME: Correct when Devise is updated to 4.1.1
      mysign_in(user.email,user.password)
      # goes to volunteers section
      visit volunteers_path
      # clicks new volunteer link
      click_link I18n.t('helpers.submit.create', model: "Nuevo Voluntario")
      # fills in volunteer information
      select 'Servicio Social', from: 'volunteer_status'
      fill_in 'volunteer_name', with: @name
      fill_in 'volunteer_cgdvcode', with: @cgdvcode
      select Volunteer::BLOODTYPES.sample , from: 'volunteer_blood'
      select @dia , from: 'volunteer_birth_3i'
      select @mes , from: 'volunteer_birth_2i'
      select @anio , from: 'volunteer_birth_1i'
      select ['F', 'M'].sample , from: 'volunteer_sex'
      # submits form
      click_button I18n.t('helpers.create')
      # sees new volunteer
      expect(page).to have_content I18n.t('flash.success.create', :model => Volunteer.to_s)
      expect(page).to have_content @cgdvcode
      expect(page).to have_content @name
      # screenshot_and_save_page
    end
  end


end
