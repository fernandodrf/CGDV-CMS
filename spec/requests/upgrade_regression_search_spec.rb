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

    it "filters contacts by company on the contacts index" do
      matching = Contact.create!(
        name: "Contact Search Alpha",
        company: "Acme Search Co",
        position: "Manager",
        birth: Date.new(1990, 1, 1)
      )
      Contact.create!(
        name: "Contact Search Beta",
        company: "Other Company",
        position: "Assistant",
        birth: Date.new(1991, 1, 1)
      )

      get contacts_path, params: { q: { company_eq: "Acme Search Co" } }

      expect(response).to have_http_status(:ok)
      expect(response.body).to include(matching.company)
      expect(response.body).not_to include("Other Company")
    end

    it "filters providers by proveedor on the providers index" do
      matching = Provider.create!(
        proveedor: "Proveedor Search Alpha",
        name: "Provider Person Alpha",
        cgdvcode: 950001
      )
      Provider.create!(
        proveedor: "Proveedor Search Beta",
        name: "Provider Person Beta",
        cgdvcode: 950002
      )

      get providers_path, params: { q: { proveedor_cont: "Alpha" } }

      expect(response).to have_http_status(:ok)
      expect(response.body).to include(matching.proveedor)
      expect(response.body).not_to include("Proveedor Search Beta")
    end

    it "filters activity reports by volunteer code on the activity reports index" do
      matching = FactoryBot.create(:activity_report, volunteer: volunteer, reporte: "Alpha weekly log")
      other_volunteer = FactoryBot.create(:volunteer, cgdvcode: 960002, name: "Activity Search Other")
      FactoryBot.create(:activity_report, volunteer: other_volunteer, reporte: "Beta weekly log")

      get activity_reports_path, params: { q: { volunteer_cgdvcode_eq: volunteer.cgdvcode } }

      expect(response).to have_http_status(:ok)
      expect(response.body).to include(matching.reporte)
      expect(response.body).not_to include("Beta weekly log")
    end

    it "filters timereports by event on the timereports index" do
      Timereport.create!(
        volunteer: volunteer,
        day: Date.current,
        begin: "09:00",
        end: "11:00",
        evento: "Evento Alpha Search"
      )
      other_volunteer = FactoryBot.create(:volunteer, cgdvcode: 960004, name: "Time Search Other")
      Timereport.create!(
        volunteer: other_volunteer,
        day: Date.current,
        begin: "10:00",
        end: "12:00",
        evento: "Evento Beta Search"
      )

      get timereports_path, params: { q: { evento_cont: "Alpha" } }

      expect(response).to have_http_status(:ok)
      expect(response.body).to include("Evento Alpha Search")
      expect(response.body).not_to include("Evento Beta Search")
    end

    it "filters pending time entries by event on the vol_times index" do
      VolTime.create!(volunteer: volunteer, evento: "Pendiente Alpha Search", horas: 4)
      other_volunteer = FactoryBot.create(:volunteer, cgdvcode: 960006, name: "Pending Time Other")
      VolTime.create!(volunteer: other_volunteer, evento: "Pendiente Beta Search", horas: 2)

      get vol_times_path, params: { q: { evento_cont: "Alpha" } }

      expect(response).to have_http_status(:ok)
      expect(response.body).to include("Pendiente Alpha Search")
      expect(response.body).not_to include("Pendiente Beta Search")
    end
  end

  describe "resource form pages" do
    before do
      sign_in admin_user
    end

    it "renders the new donor form" do
      get new_donor_path

      expect(response).to have_http_status(:ok)
      expect(response.body).to include("donor_persona")
      expect(response.body).to include("donor_cgdvcode")
      expect(response.body).to include("donor_name")
    end

    it "renders the new contact form" do
      get new_contact_path

      expect(response).to have_http_status(:ok)
      expect(response.body).to include("contact_name")
      expect(response.body).to include("contact_company")
      expect(response.body).to include("contact_position")
    end

    it "renders the new provider form" do
      get new_provider_path

      expect(response).to have_http_status(:ok)
      expect(response.body).to include("provider_proveedor")
      expect(response.body).to include("provider_name")
      expect(response.body).to include("provider_cgdvcode")
    end

    it "renders the new activity report form" do
      get new_activity_report_path

      expect(response).to have_http_status(:ok)
      expect(response.body).to include("activity_report_reporte")
    end

    it "renders the new timereport form" do
      get new_timereport_path

      expect(response).to have_http_status(:ok)
      expect(response.body).to include("timereport_evento")
      expect(response.body).to include("timereport_volunteer_id")
      expect(response.body).to include("timereport_day_1i")
    end

    it "renders the new pending-time form" do
      get new_vol_time_path

      expect(response).to have_http_status(:ok)
      expect(response.body).to include("vol_time_evento")
      expect(response.body).to include("vol_time_horas")
      expect(response.body).to include("vol_time_volunteer_id")
    end
  end
end
