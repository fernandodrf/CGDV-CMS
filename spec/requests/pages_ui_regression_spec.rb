require "rails_helper"

RSpec.describe "Pages UI regressions", type: :request do
  let!(:volunteer) do
    FactoryBot.create(:volunteer, cgdvcode: 950102, name: "Pages UI Volunteer")
  end

  let!(:user) do
    FactoryBot.create(
      :user,
      :admin,
      volunteer_id: volunteer.id,
      email: "pages-ui@example.test",
      password: "secret123"
    )
  end

  it "shows a bootstrap login call-to-action on the public home page" do
    get root_path

    expect(response).to have_http_status(:ok)
    expect(response.body).to include('class="card border-0 shadow-sm home-hero-card"')
    expect(response.body).to include(new_user_session_path)
    expect(response.body).to include('class="btn btn-primary"')
  end

  it "shows a login call-to-action on the public times page" do
    get times_path

    expect(response).to have_http_status(:ok)
    expect(response.body).to include('class="card border-0 shadow-sm times-page-card"')
    expect(response.body).to include(new_user_session_path)
    expect(response.body).not_to include(vol_times_path)
    expect(response.body).not_to include(timereports_path)
  end

  it "shows time module links for signed-in admins on the times page" do
    post user_session_path, params: {
      user: { email: user.email, password: "secret123" }
    }
    follow_redirect!

    get times_path

    expect(response).to have_http_status(:ok)
    expect(response.body).to include(vol_times_path)
    expect(response.body).to include(timereports_path)
    expect(response.body).to include("times-page-link")
  end
end
