require 'rails_helper'

RSpec.describe "Activity reports", :activity_reports => true, type: :system do
  let(:volunteer) { FactoryBot.create(:volunteer, :vol) }
  let(:user) { FactoryBot.create(:user, :normal, volunteer_id: volunteer.id) }

  it "allows an ss user to create and view an activity report" do
    user.add_role!('ss')
    report_text = "Reporte semanal #{SecureRandom.hex(4)}"

    mysign_in(user.email, user.password)
    visit activity_reports_path

    expect(page).to have_content("Reportes de Actividades")
    expect(page).to have_link("Nuevo Reporte de Actividades")

    click_link "Nuevo Reporte de Actividades"
    fill_in 'activity_report_reporte', with: report_text
    click_button I18n.t('helpers.create')

    expect(page).to have_content("Reporte de la Semana")
    expect(page).to have_content(report_text)
    expect(ActivityReport.last.volunteer_id).to eq(user.volunteer_id)

    click_link "Regresar a Reportes de Actividades", match: :first
    expect(page).to have_content("Reportes de Actividades")
  end
end
