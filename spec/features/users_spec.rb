require 'rails_helper'

RSpec.feature "Users", :users => true, type: :feature do

  let(:user) { FactoryBot.create(:user, :normal) }
  let(:valid_attributes) { FactoryBot.attributes_for(:user) }
  let(:second_user) { FactoryBot.create(:user, :normal) }
  let(:user_admin) { FactoryBot.create(:user, :admin) }

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
          expect(page).to have_content I18n.t('devise.failure.invalid',
                                               :authentication_keys => "Email")

          
        end
      end
    end
    context "guest/unregistered user" do
      scenario "is unable to sign in, gets ambiguous error message" do
        manual_sign_in(Faker::Internet.email,Faker::Internet.password)
        aggregate_failures do
          expect(page).to have_content I18n.t('devise.sessions.new.sign_in')
          # FIXME: Can be used again when Devise i18n is installed
          # expect(page).to have_content I18n.t('devise.failure.not_found_in_database',
                                               # :authentication_keys => "Email")
          expect(page).to have_content I18n.t('devise.failure.invalid')
        end
      end
    end
  end

  describe "create new user process", :createuser => true do
    scenario "guest user should not be able to find link for sign-up (create new user)" do
      go_to_page(I18n.t('session.login'))
      expect(page).not_to have_content I18n.t('devise.registrations.new.sign_up')
    end
    scenario "admin user is able to create new user succesfully" do
      @pass = Faker::Internet.password
      # sign_in user_admin
      mysign_in(user_admin.email,user_admin.password)
      visit new_user_path
      # expect(page).to have_content I18n.t('user.new')
      expect(page).to have_content("Crear User")
      fill_in I18n.t('user.name'), with: Faker::Name.name
      fill_in I18n.t('user.email'), with: Faker::Internet.email
      fill_in I18n.t('user.password'), with: @pass
      # fill_in I18n.t('activerecord.attributes.user.password'), with: @pass
      fill_in I18n.t('user.confirmation'), with: @pass
      # fill_in I18n.t('activerecord.attributes.user.password_confirmation'), with: @pass
      click_button 'Sign up' #I18n.t('helpers.create')
      expect(page).to have_content I18n.t('flash.success.create', :model => User.to_s)
      expect(page).to have_content I18n.t('home.title')
    end
    
    scenario "admin is able to delete users", :deleteuser => true do
      @user1 = FactoryBot.create(:user, :normal)
      @admin = FactoryBot.create(:user, :admin)
      # puts "user count: #{@user1.inspect}"
      # puts "user count: #{@admin.inspect}"
      mysign_in(@admin.email,@admin.password)
      visit users_path
      # DEBUG screenshot
      # screenshot_and_save_page
      expect(page).to have_content I18n.t('helpers.delete.msg', count: 2)
      click_link I18n.t('helpers.delete.msg'), href: "/users/#{@user1.id}" 
      # screenshot_and_save_page
      expect(page).to have_content I18n.t('flash.success.destroy', :model => User.to_s)
      expect(page).to have_content I18n.t('helpers.delete.msg', count: 1)
    end

    # FIXME: Unable to run javascript tests
    # Upgrade to capybara 3 and webdrivers
    xscenario "admin users sees delete message before deleting user", js: true do
      @user = FactoryBot.create(:user, :normal)
      @admin = FactoryBot.create(:user, :admin)
      # sign_in @admin
      mysign_in(@admin.email,@admin.password)
      visit users_path
      click_link I18n.t('helpers.delete.msg'), match: :first
      expect(page.driver.browser.switch_to.alert.text).to eq(I18n.t('helpers.delete.conf'))
      page.driver.browser.switch_to.alert.accept
      expect(page).to have_content I18n.t('flash.success.destroy', :model => User.to_s)
    end
  end

  #FIXME: Not working with Devise 1.4
  # Not so important
  xit "is able to track users sign-in count", :trackable => true do
    visit root_path
    initial_count = user.sign_in_count
    # FIXME: Not working on Devise 1.4
    # sign_in user
    # Work-around to make test work
    mysign_in(user.email,user.password)
    visit root_path
    # FIXME: Not working on Devise 1.4
    # sign_out user
    mysign_out
    puts "user count: #{initial_count}"
    final_count = user.sign_in_count
    puts "user count: #{final_count}"
    expect(final_count - initial_count).to eq(1)
  end

  #FIXME: Has to be corrected, to many errors
  #FIXME: Install capybara-email
  xit "performs password recovery (creates a new password)", :passrec => true do
    visit new_user_session_path
    # FIXME: Correct when installing Devise i18n
    # expect(page).to have_content I18n.t('devise.passwords.new.forgot_your_password')
    # click_link I18n.t('devise.passwords.new.forgot_your_password')
    expect(page).to have_content I18n.t('devise.passwords.link')
    click_link I18n.t('devise.passwords.link')
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

    fill_in I18n.t('devise.passwords.edit.new_password'), with: valid_attributes[:password]
    fill_in I18n.t('devise.passwords.edit.confirm_new_password'), with: valid_attributes[:password]
    click_button I18n.t('devise.passwords.edit.confirm_new_password')
    expect(page).to have_text I18n.t('devise.passwords.updated')
    expect(page).to have_current_path "/"
    # TODO: to test this set "config.send_password_change_notification = true" in initilizers/devise.rb
    # open_email(user.email)
    # expect(current_email.subject).to eq I18n.t('devise.mailer.password_change.subject')
    # expect(current_email.body). to have_text I18n.t('devise.mailer.password_change.message')
  end

  describe "normal user", :normaluser => true do
    # FIXME: Work around because Devise helper does not work
    before do
      go_to_page(I18n.t('session.login'))
      mysign_in(user.email,user.password)
      visit root_path
    end
    it "should not see the Users option in the navbar but only his/her name and logout link" do
      # FIXME: Not working on Devise 1.4
      # sign_in user
      # Work-around to make test work
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

    describe "role oficina" do
      # FIXME: Find a better way to add roles in fixtures
      before do
        user.add_role!('oficina')
        # puts "User: #{user.inspect}"
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


    #FIXME: No existe liga para que el usuario vea su perfil y cambie el password
    # si la cuenta no esta ligada a un voluntario
    xit "should be able to change its own password and sign_in again" do
      @pass = Faker::Internet.password
      # FIXME: Not working on Devise 1.4
      # sign_in user
      # Work-around to make test work
      mysign_in(user.email,user.password)
      visit root_path
      expect(page).to have_content "#{I18n.t('user.name')}: #{user.name}"
      click_link "#{I18n.t('user.name')}: #{user.name}"
      expect(page).to have_content I18n.t('user.name')
      click_link I18n.t('helpers.edit')
      expect(page).to have_content I18n.t('user.edit')
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

  #  spec functions
  def go_to_page(name)
    visit root_path
    # FIXME: Use only one link
    click_link(name, match: :first)
  end

  def manual_sign_in(email,pass)
    # FIXME Use I18n
    # fill_in I18n.t('activerecord.attributes.user.email'),   with: email
    # fill_in I18n.t('activerecord.attributes.user.password'),  with: pass
    fill_in "Email", with: email
    fill_in "Password", with: pass
    click_button I18n.t('devise.sessions.new.sign_in')
  end

  # FIXME: Work-around for test to pass with Devise 1.4
  def mysign_in(email,pass)
    go_to_page(I18n.t('session.login'))
    fill_in "Email", with: email
    fill_in "Password", with: pass
    click_button I18n.t('devise.sessions.new.sign_in')
  end

  def mysign_out
    click_link(I18n.t('session.logout'), match: :first)
  end

end