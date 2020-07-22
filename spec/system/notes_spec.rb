require 'rails_helper'

RSpec.feature "Notes", type: :system do
  # Lazy loading of upper model
  let (:volunteer) { FactoryBot.create(:volunteer, :vol) }

  let(:user) { FactoryBot.create(:user, :normal, volunteer_id: volunteer.id) }
  let(:valid_attributes) { FactoryBot.attributes_for(:user) }
  let(:second_user) { FactoryBot.create(:user, :normal, volunteer_id: volunteer.id) }
  let(:user_admin) { FactoryBot.create(:user, :admin, volunteer_id: volunteer.id) }

  describe 'user is able to CRUD notes', js: true do
    # FIXME: Find a better way to add roles in fixtures
    before do
      user.add_role!('oficina')
      # puts "User: #{user.inspect}"
    end
    it 'creates a new note' do
    	@pat1 = FactoryBot.create(:patient)
			@adeudo = rand(1.0...100.0)
			@acuenta = rand(1.0...100.0)
			@restan = rand(1.0...100.0)
			@subtotal = rand(1.0...100.0)
			@total = rand(1.0...100.0)
			@codigo = rand(1...100)
			@descripcion = Faker::Lorem.sentence(word_count: 3)
			@cuota = rand(1.0...100.0)
			@cantidad = rand(1...100)

    	sign_in user
      visit root_path
      expect(page).to have_content I18n.t('header.note')
      click_link I18n.t('header.note'), match: :first
      expect(page).to have_content I18n.t('note.index')
      click_link I18n.t('helpers.submit.create', :model => "Nueva Nota"), match: :first
      expect(page).to have_content I18n.t('helpers.submit.create', :model => Note.to_s)
      select @pat1.cgdvcode, from: 'note_patient_id'
      fill_in 'note_elements_attributes_0_codigo', with: @codigo
      fill_in 'note_elements_attributes_0_descripcion', with: @descripcion
      fill_in 'note_elements_attributes_0_cuota', with: @cuota
      fill_in 'note_elements_attributes_0_cantidad', with: @cantidad
      check 'note_elements_attributes_1__destroy'
      check 'note_elements_attributes_2__destroy'
      check 'note_elements_attributes_3__destroy'
      check 'note_elements_attributes_4__destroy'
      check 'note_elements_attributes_5__destroy'
      fill_in 'note_subtotal', with: @cuota * @cantidad
      fill_in 'note_adeudo', with: 0
      fill_in 'note_total', with: @cuota * @cantidad
      fill_in 'note_acuenta', with: @cuota * @cantidad
      fill_in 'note_restan', with: 0
      click_button I18n.t('helpers.create')
      expect(page).to have_content I18n.t('flash.success.create', :model => Note.to_s)
    end
  end
end
