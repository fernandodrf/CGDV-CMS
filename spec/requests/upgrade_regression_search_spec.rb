require "rails_helper"

RSpec.describe "Upgrade regression: auth and search flows", type: :request do
  include Devise::Test::IntegrationHelpers

  let!(:volunteer) do
    FactoryBot.create(:volunteer, cgdvcode: 900001, name: "Spec Volunteer")
  end

  let!(:admin_user) do
    FactoryBot.create(:user, :admin, volunteer_id: volunteer.id, email: "admin-search@example.test")
  end

  describe "authentication guard" do
    it "redirects guests away from patients index" do
      get patients_path

      expect(response).to redirect_to(root_path)
    end
  end

  describe "ransack-backed indexes" do
    before do
      sign_in admin_user
    end

    it "filters patients by name on the patients index" do
      matching = FactoryBot.create(:patient, cgdvcode: 910001, name: "Paciente Alpha Search")
      FactoryBot.create(:patient, cgdvcode: 910002, name: "Paciente Beta Search")

      get patients_path, params: { q: { name_cont: "Alpha" } }

      expect(response).to have_http_status(:ok)
      expect(response.body).to include(matching.name)
      expect(response.body).not_to include("Paciente Beta Search")
    end

    it "filters notes by patient name on the notes index" do
      alpha_patient = FactoryBot.create(:patient, cgdvcode: 920001, name: "Patient Search Alpha")
      beta_patient = FactoryBot.create(:patient, cgdvcode: 920002, name: "Patient Search Beta")
      alpha_note = FactoryBot.create(:note, patient: alpha_patient, folio: 700001)
      FactoryBot.create(:note, patient: beta_patient, folio: 700002)

      get notes_path, params: { q: { patient_name_cont: "Alpha" } }

      expect(response).to have_http_status(:ok)
      expect(response.body).to include(alpha_note.folio.to_s)
      expect(response.body).not_to include("700002")
    end

    it "filters nested patient notes by folio on the patient notes page" do
      patient = FactoryBot.create(:patient, cgdvcode: 930001, name: "Patient Notes Search")
      kept_note = FactoryBot.create(:note, patient: patient, folio: 710001)
      FactoryBot.create(:note, patient: patient, folio: 710002)

      get notas_patient_path(patient), params: { q: { folio_eq: kept_note.folio } }

      expect(response).to have_http_status(:ok)
      expect(response.body).to include(kept_note.folio.to_s)
      expect(response.body).not_to include("710002")
    end

    it "filters donors by name on the donors index" do
      matching = Donor.create!(
        cgdvcode: 940001,
        persona: 1,
        name: "Donor Search Alpha",
        birth: Date.new(1980, 1, 1)
      )
      Donor.create!(
        cgdvcode: 940002,
        persona: 1,
        name: "Donor Search Beta",
        birth: Date.new(1981, 1, 1)
      )

      get donors_path, params: { q: { name_cont: "Alpha" } }

      expect(response).to have_http_status(:ok)
      expect(response.body).to include(matching.name)
      expect(response.body).not_to include("Donor Search Beta")
    end
  end
end
