module RedmineSmsAuth

  class Hooks < Redmine::Hook::ViewListener
    render_on :view_account_login_top, partial: 'hooks/smsauth_medialog/view_login_top'    
    render_on :sms_auth_form_medialog, partial: 'hooks/smsauth_medialog/sms_auth_form_medialog'    
  end

end
