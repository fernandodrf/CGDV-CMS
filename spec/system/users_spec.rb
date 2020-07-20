require 'rails_helper'

RSpec.feature "Users", :users => true, type: :system do
  # Lazy loading of upper model
  let (:volunteer) { FactoryBot.create(:volunteer, :vol) }

  let(:user) { FactoryBot.create(:user, :normal, volunteer_id: volunteer.id) }
  let(:valid_attributes) { FactoryBot.attributes_for(:user) }
  let(:second_user) { FactoryBot.create(:user, :normal, volunteer_id: volunteer.id) }
  let(:user_admin) { FactoryBot.create(:user, :admin, volunteer_id: volunteer.id) }

  it "users are able to see the landing page" do
    visit root_path
    expect(page).to have_content I18n.t('session.login')
  end

  describe "sign in process", :signin => true do
    before do
      go_to_page(I18n.t('session.login'))
    end
    context "valid user" do
      scenario "signs in succesfully" do
        expect(page).to have_content I18n.t('devise.sessions.new.sign_in')
        manual_sign_in(user.email,user.password)
        aggregate_failures do
          expect(page).to have_content I18n.t('home.title')
          expect(page).to have_content I18n.t('devise.sessions.signed_in')
          expect(page).to have_content I18n.t('session.logout')
        end
      end
      scenario "invalid email/password no sign in" do
        manual_sign_in(user.email,second_user.password)
        aggregate_failures do
          expect(page).to have_content I18n.t('devise.sessions.new.sign_in')
          expect(page).to have_content I18n.t('devise.failure.invalid', :authentication_keys => "Correo electrónico")
        end
      end
    end
    context "guest/unregistered user" do
      scenario "is unable to sign in, gets ambiguous error message" do
        manual_sign_in(Faker::Internet.email,Faker::Internet.password(min_length: 6, max_length: 20))
        aggregate_failures do
          expect(page).to have_content I18n.t('devise.sessions.new.sign_in')
          expect(page).to have_content I18n.t('devise.failure.not_found_in_database', :authentication_keys => "Correo electrónico")
        end
      end
    end
  end

  describe "create new user process" do
    scenario "guest user should not be able to find link for sign-up (create new user)" do
      go_to_page(I18n.t('session.login'))
      expect(page).not_to have_content I18n.t('devise.registrations.new.sign_up')
    end
    scenario "admin user is able to create new user succesfully", :createuser => true do
      @vol1 = FactoryBot.create(:volunteer, :vol)
      @vol2 = FactoryBot.create(:volunteer, :vol)
      @vol3 = FactoryBot.create(:volunteer, :vol)
      @pass = Faker::Internet.password(min_length: 6, max_length: 20)
      sign_in user_admin
      visit new_user_path
      # expect(page).to have_content I18n.t('user.new')
      expect(page).to have_content("Crear User")
      fill_in I18n.t('user.name'), with: Faker::Name.name
      fill_in I18n.t('user.email'), with: Faker::Internet.email
      fill_in I18n.t('user.password'), with: @pass
      # fill_in I18n.t('activerecord.attributes.user.password'), with: @pass
      fill_in I18n.t('user.confirmation'), with: @pass
      # fill_in I18n.t('activerecord.attributes.user.password_confirmation'), with: @pass
      select @vol1.cgdvcode , from: 'user_volunteer_id'
      click_button 'Sign up' #I18n.t('helpers.create')
      expect(page).to have_content I18n.t('flash.success.create', :model => User.to_s)
      expect(page).to have_content I18n.t('home.title')
    end
    
    scenario "admin is able to delete users", :deleteuser => true, js: true do
      @vol1 = FactoryBot.create(:volunteer, :vol)
      @vol2 = FactoryBot.create(:volunteer, :vol)
      @user1 = FactoryBot.create(:user, :normal, volunteer_id: @vol1.id)
      @admin = FactoryBot.create(:user, :admin, volunteer_id: @vol2.id)
      # puts "user count: #{@user1.inspect}"
      # puts "user count: #{@admin.inspect}"
      mysign_in(@admin.email,@admin.password)
      visit users_path
      # DEBUG screenshot
      # take_screenshot
      expect(page).to have_content I18n.t('helpers.delete.msg', count: 2)
      click_link I18n.t('helpers.delete.msg'), href: "/users/#{@user1.id}" 
      # take_screenshot
      expect(page).to have_content I18n.t('flash.success.destroy', :model => User.to_s)
      expect(page).to have_content I18n.t('helpers.delete.msg', count: 1)
    end

    # FIXME: Unable to run javascript tests
    xscenario "admin users sees delete message before deleting user", :deleteuser => true, js: true do
      @vol1 = FactoryBot.create(:volunteer, :vol)
      @vol2 = FactoryBot.create(:volunteer, :vol)
      @user = FactoryBot.create(:user, :normal, volunteer_id: @vol1.id)
      @admin = FactoryBot.create(:user, :admin, volunteer_id: @vol2.id)
      sign_in @admin
      # mysign_in(@admin.email,@admin.password)
      visit users_path
      take_screenshot
      click_link I18n.t('helpers.delete.msg'), match: :first
      take_screenshot
      expect(page.driver.browser.switch_to.alert.text).to eq(I18n.t('helpers.delete.conf'))
      take_screenshot
      page.driver.browser.switch_to.alert.accept
      expect(page).to have_content I18n.t('flash.success.destroy', :model => User.to_s)
    end
  end

  it "is able to track users sign-in count", :trackable => true do
    visit root_path
    initial_count = user.sign_in_count
    sign_in user
    visit root_path
    sign_out user
    # puts "user count: #{initial_count}"
    final_count = user.sign_in_count
    # puts "user count: #{final_count}"
    expect(final_count - initial_count).to eq(1)
  end

  #FIXME: Has to be corrected, to many errors
  it "performs password recovery (creates a new password)", :passrec => true do
    visit new_user_session_path
    expect(page).to have_content I18n.t('devise.passwords.new.forgot_your_password')
    click_link I18n.t('devise.passwords.new.forgot_your_password')
    expect(page).to have_button I18n.t('devise.passwords.new.send_me_reset_password_instructions')
    fill_in I18n.t('activerecord.attributes.user.email'), with: user.email
    click_button I18n.t('devise.passwords.new.send_me_reset_password_instructions')
    expect(page).to have_text I18n.t('devise.passwords.send_instructions')
    # Find email sent to the given recipient and set the current_email variable
    # try capybara-email
    # https://github.com/DavyJonesLocker/capybara-email
    open_email(user.email)
    expect(current_email.subject).to eq I18n.t('devise.mailer.reset_password_instructions.subject')
    current_email.click_link I18n.t('devise.mailer.reset_password_instructions.action')
    fill_in 'user_password', with: valid_attributes[:password] # I18n.t('devise.passwords.edit.new_password')
    fill_in 'user_password_confirmation', with: valid_attributes[:password] # I18n.t('devise.passwords.edit.confirm_new_password')
    click_button I18n.t('devise.passwords.edit.change_my_password')
    expect(page).to have_text I18n.t('devise.passwords.updated')
    expect(page).to have_current_path "/"
    # TODO: to test this set "config.send_password_change_notification = true" in initilizers/devise.rb
    # open_email(user.email)
    # expect(current_email.subject).to eq I18n.t('devise.mailer.password_change.subject')
    # expect(current_email.body). to have_text I18n.t('devise.mailer.password_change.message')
  end

  describe "normal user", :normaluser => true do
    before do
      sign_in user
      visit root_path
    end
    it "should not see the Users option in the navbar but only his/her name and logout link" do
      expect(page).not_to have_content I18n.t('header.users')
      expect(page).to have_content "#{I18n.t('user.name')}: #{user.name}"
    end

    # FIXME: DRY Code!
    it "if user has no roles it should not see nor be able to use any function" do
      expect(page).to have_content "#{I18n.t('user.name')}: #{user.name}"
      expect(page).not_to have_content I18n.t('header.users')
      expect(page).not_to have_content I18n.t('header.patient')
      expect(page).not_to have_content I18n.t('header.settings')
      expect(page).not_to have_content I18n.t('header.note')
      expect(page).not_to have_content I18n.t('header.contact')
      expect(page).not_to have_content I18n.t('header.provider')
      expect(page).not_to have_content I18n.t('header.volunteer')
      expect(page).not_to have_content I18n.t('header.timereport')
      expect(page).not_to have_content I18n.t('header.donor')
      expect(page).not_to have_content I18n.t('header.actrep')
      expect(page).not_to have_content I18n.t('header.donation')
      visit users_path
      expect(page).to have_content I18n.t('session.flash.denied')
      visit patients_path
      expect(page).to have_content I18n.t('session.flash.denied')
      visit notes_path
      expect(page).to have_content I18n.t('session.flash.denied')
      visit providers_path
      expect(page).to have_content I18n.t('session.flash.denied')
      visit contacts_path
      expect(page).to have_content I18n.t('session.flash.denied')
      visit volunteers_path
      expect(page).to have_content I18n.t('session.flash.denied')
      # times has no restricted
      # visit times_path
      # screenshot_and_save_page
      # expect(page).to have_content I18n.t('session.flash.denied')
      visit activity_reports_path
      expect(page).to have_content I18n.t('session.flash.denied')
      visit donors_path
      expect(page).to have_content I18n.t('session.flash.denied')
      visit donations_path
      expect(page).to have_content I18n.t('session.flash.denied')
    end

    describe "role servicio social" do
      # FIXME: Find a better way to add roles in fixtures
      before do
        user.add_role!('ss')
        # puts "User: #{user.inspect}"
      end
      it "sees the appropiate links and can access them" do
        visit root_path
        expect(page).to have_content "#{I18n.t('user.name')}: #{user.name}"
        expect(page).to have_content I18n.t('header.actrep')
        # FIXME: Crear factory de activity report para que Ransack no truene
        # visit activity_reports_path
        # FIXME: Corregir errores con Ransack, Kaminar y generar i18n
        # expect(page).to have_content('Reportes de Actividades')
      end
      xit "can access the correspoding links" do
        # FIXME: Crear factory de activity report para que Ransack no truene
        # visit activity_reports_path
        # FIXME: Corregir errores con Ransack, Kaminar y generar i18n
        # expect(page).to have_content('Reportes de Actividades')
      end
    end

    describe "role oficina" do
      # FIXME: Find a better way to add roles in fixtures
      before do
        user.add_role!('oficina')
      end
      it "sees the appropiate links and can access them" do
        visit root_path
        expect(page).to have_content "#{I18n.t('user.name')}: #{user.name}"
        expect(page).to have_content I18n.t('header.patient')
        expect(page).to have_content I18n.t('header.note')
        expect(page).to have_content I18n.t('header.provider')
        expect(page).to have_content I18n.t('header.contact')
        expect(page).to have_content I18n.t('header.actrep')
        expect(page).to have_content I18n.t('header.donation')
        visit patients_path
        expect(page).to have_content I18n.t('patient.index')
        visit notes_path
        expect(page).to have_content I18n.t('note.index')
        visit providers_path
        expect(page).to have_content I18n.t('provider.index')
        visit contacts_path
        expect(page).to have_content I18n.t('contact.index')
        # FIXME: Crear factory de activity report para que Ransack no truene
        # visit activity_reports_path
        # FIXME: Generar i18n
        # expect(page).to have_content('Reportes de Actividades')
        visit donations_path
        expect(page).to have_content I18n.t('donation2.index')
      end
    end

    describe "role timereport" do
      # FIXME: Find a better way to add roles in fixtures
      before do
        user.add_role!('timereport')
      end
      it "sees the appropiate links and can access them" do
        visit root_path
        expect(page).to have_content "#{I18n.t('user.name')}: #{user.name}"
        expect(page).to have_content I18n.t('header.timereport')
        visit times_path
        expect(page).to have_content I18n.t('timereport.title')
      end
      xit "visit sub-links and interact with them" do
        # visit vol_times_path
        # visit timereports_path
      end
    end

    describe "role managetimereport" do
      # FIXME: Find a better way to add roles in fixtures
      before do
        user.add_role!('managetimereport')
      end
      it "sees the appropiate links and can access them" do
        visit root_path
        expect(page).to have_content "#{I18n.t('user.name')}: #{user.name}"
        expect(page).to have_content I18n.t('header.timereport')
        visit times_path
        expect(page).to have_content I18n.t('timereport.title')
      end
      xit "manage time reports" do
        # visit vol_times_path
        # visit timereports_path
      end
    end

    describe "role managedonor" do
      # FIXME: Find a better way to add roles in fixtures
      before do
        user.add_role!('managedonor')
      end
      it "sees the appropiate links and can access them" do
        visit root_path
        expect(page).to have_content I18n.t('header.donor')
        visit donors_path
        expect(page).to have_content I18n.t('donation.index')
      
      end
      xit "manage time reports" do
        # visit vol_times_path
        # visit timereports_path
      end
    end   

    describe "role managecontact" do
      # FIXME: Find a better way to add roles in fixtures
      before do
        user.add_role!('managecontact')
      end
      it "sees the appropiate links and can access them" do
        visit root_path
        expect(page).to have_content I18n.t('header.contact')
        visit contacts_path
        expect(page).to have_content I18n.t('contact.index')
      end
      xit "manage time reports" do
        # visit vol_times_path
        # visit timereports_path
      end
    end 

    #FIXME: No existe manera de que cambien su contraseña!
    it "should be able to change its own password and sign_in again", current: true do
      user.add_role!('ss')
      puts "User: #{user.inspect}"
      @pass = Faker::Internet.password(min_length: 6, max_length: 20)
      sign_in user
      visit root_path
      expect(page).to have_content "#{I18n.t('user.name')}: #{user.name}"
      save_page
      click_link 'Opciones' # "#{I18n.t('user.name')}: #{user.name}"
      # expect(page).to have_content I18n.t('user.name')
      # click_link I18n.t('helpers.edit')
      # expect(page).to have_content I18n.t('user.edit')
      fill_in I18n.t('activerecord.attributes.user.password'), with: @pass
      fill_in I18n.t('activerecord.attributes.user.password_confirmation'), with: @pass
      click_button I18n.t('helpers.edit')
      expect(page).to have_content I18n.t('devise.failure.unauthenticated')
      expect(page).to have_content I18n.t('devise.sessions.new.sign_in')
      manual_sign_in(user.email,@pass)
      expect(page).to have_content I18n.t('devise.sessions.signed_in')
      expect(page).to have_content I18n.t('user.name')
    end
  end
end