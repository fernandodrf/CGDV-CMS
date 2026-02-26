require "rails_helper"

RSpec.describe "Devise authentication flows", type: :request do
  let!(:volunteer) do
    FactoryBot.create(:volunteer, cgdvcode: 950001, name: "Auth Flow Volunteer")
  end

  let!(:user) do
    FactoryBot.create(
      :user,
      :admin,
      volunteer_id: volunteer.id,
      email: "auth-flow@example.test",
      password: "secret123"
    )
  end

  describe "sessions" do
    it "renders the sign-in page" do
      get new_user_session_path

      expect(response).to have_http_status(:ok)
      expect(response.body).to include(I18n.t("devise.sessions.new.sign_in"))
    end

    it "signs in with valid credentials and can access a protected page" do
      post user_session_path, params: {
        user: { email: user.email, password: "secret123" }
      }

      expect(response).to redirect_to(root_path)
      follow_redirect!
      expect(response.body).to include(I18n.t("devise.sessions.signed_in"))

      get patients_path
      expect(response).to have_http_status(:ok)
    end

    it "rejects invalid credentials" do
      post user_session_path, params: {
        user: { email: user.email, password: "wrong-password" }
      }

      expect(response).to have_http_status(:ok)
      expect(response.body).to include(
        I18n.t("devise.failure.invalid", authentication_keys: "Correo electrónico")
      )
    end

    it "signs out an authenticated user" do
      post user_session_path, params: {
        user: { email: user.email, password: "secret123" }
      }
      expect(response).to redirect_to(root_path)

      delete destroy_user_session_path

      expect(response).to redirect_to(root_path)
      follow_redirect!
      expect(response.body).to include(I18n.t("devise.sessions.signed_out"))
    end
  end

  describe "password reset" do
    before do
      ActionMailer::Base.deliveries.clear
    end

    it "renders the forgot password page" do
      get new_user_password_path

      expect(response).to have_http_status(:ok)
      expect(response.body).to include(I18n.t("devise.passwords.new.forgot_your_password"))
    end

    it "sends reset password instructions for an existing email" do
      expect do
        post user_password_path, params: { user: { email: user.email } }
      end.to change(ActionMailer::Base.deliveries, :count).by(1)

      expect(response).to redirect_to(new_user_session_path)
      follow_redirect!
      expect(response.body).to include(I18n.t("devise.passwords.send_instructions"))

      delivered = ActionMailer::Base.deliveries.last
      expect(delivered.to).to include(user.email)
      expect(delivered.subject).to eq(I18n.t("devise.mailer.reset_password_instructions.subject"))
    end
  end
end
