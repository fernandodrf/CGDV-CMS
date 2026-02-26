require "rails_helper"

RSpec.describe "Layout navigation shell", type: :request do
  let!(:volunteer) do
    FactoryBot.create(:volunteer, cgdvcode: 950101, name: "Layout Nav Volunteer")
  end

  let!(:user) do
    FactoryBot.create(
      :user,
      :admin,
      volunteer_id: volunteer.id,
      email: "layout-nav@example.test",
      password: "secret123"
    )
  end

  it "hides secondary top/footer nav bars for signed-out users" do
    get root_path

    expect(response).to have_http_status(:ok)
    expect(response.body).to include('aria-label="Primary navigation"')
    expect(response.body).to include('aria-label="Footer primary links"')
    expect(response.body).not_to include('aria-label="Secondary navigation"')
    expect(response.body).not_to include('aria-label="Footer secondary links"')
  end

  it "renders secondary top/footer nav bars for signed-in users with permissions" do
    post user_session_path, params: {
      user: { email: user.email, password: "secret123" }
    }

    expect(response).to redirect_to(root_path)
    follow_redirect!

    expect(response.body).to include('aria-label="Primary navigation"')
    expect(response.body).to include('aria-label="Secondary navigation"')
    expect(response.body).to include('aria-label="Footer primary links"')
    expect(response.body).to include('aria-label="Footer secondary links"')
  end
end
