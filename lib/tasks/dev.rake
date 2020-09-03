if Rails.env.development? || Rails.env.test?
  require "factory_bot"
  require "faker"

  namespace :dev do
    desc "Sample data for local development environment"
    task populate: "db:setup" do
      puts "Create Admin User"

      desc "Crear usuario Admin"
      @vol  = FactoryBot.create(:volunteer, :vol, name: 'ADMIN Tester')
      @user = FactoryBot.create(:user, :admin, name: 'ADMIN Tester', email: 'test@test.com', password: 'test123.', volunteer_id: @vol.id)

      # puts "Vol: #{@vol.inspect}"
      # puts "User: #{@vol.inspect}"

      puts "Crear Voluntarios"
      5.times do
        @vol  = FactoryBot.create(:volunteer, :vol)
        @user = FactoryBot.create(:user, :normal, volunteer_id: @vol.id)
        # puts "Vol: #{@vol.inspect}"
      end

      puts "Crer Pacientes"
      10.times do
        @p = FactoryBot.create(:patient, :active)
        # puts "Vol: #{@p.inspect}"
      end
      3.times do
        @p = FactoryBot.create(:patient, :inactive)
        # puts "Vol: #{@p.inspect}"
      end

    end
  end
end
