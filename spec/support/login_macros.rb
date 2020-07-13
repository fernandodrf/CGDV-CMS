module LoginMacros
	# FIXME: Work-around for test to pass with Devise < 4.1.1
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
    fill_in 'user_email', with: email
    fill_in 'user_password', with: pass
    click_button I18n.t('devise.sessions.new.sign_in')
  end

  def mysign_in(email,pass)
    go_to_page(I18n.t('session.login'))
    fill_in 'user_email', with: email
    fill_in 'user_password', with: pass
    click_button I18n.t('devise.sessions.new.sign_in')
  end

  def mysign_out
    click_link(I18n.t('session.logout'), match: :first)
  end
end