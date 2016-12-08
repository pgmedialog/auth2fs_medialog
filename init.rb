Redmine::Plugin.register :smsauth_medialog do
  name 'Smsauth Medialog plugin'
  author 'Hwang Myoung ho, Choi Dae gang, Ru Hak Jong'
  description 'This is a plugin for Redmine'
  version '0.0.1'
  url 'http://partner.medialog.co.kr/projects/fintech_coherencg?jump=welcome'
  author_url 'http://partner.medialog.co.kr'
# addmenu

#:top_menu - the top left menu
#:account_menu - the top right menu with sign in/sign out links
#:application_menu - the main menu displayed when the user is not inside a project
#:project_menu - the main menu displayed when the user is inside a project
#:admin_menu - the menu displayed on the Administration page (can only insert after Settings, before Plugins)

#:param - the parameter key that is used for the project id (default is :id)
#:if - a Proc that is called before rendering the item, the item is displayed only if it returns true
#:caption - the menu caption that can be:
#a localized string Symbol
#a String
#a Proc that can take the project as argument
#:before, :after - specify where the menu item should be inserted (eg. :after => :activity)
#:first, :last - if set to true, the item will stay at the beginning/end of the menu (eg. :last => true)
#:html - a hash of html options that are passed to link_to when rendering the menu item


# menu :admin_menu, :smsauth_medialog, { :controller => 'polls', :action => 'index' }, :catpion => 'opt인증키 초기화'	
  #menu :top_menu, :smsauth_medialog, { :controller => 'polls', :action => 'index' }, :catpion => 'smsAuth'	
#  menu :application_menu, :smsauth_medialog, { :controller => 'polls', :action => 'index' }, :catpion => 'smsAuth'	
#  menu :top_menu, 'itemName', { :controller => 'polls', :action => 'index' }, :catpion => 'smsAuth'	

  ActionDispatch::Callbacks.to_prepare do
  #require 'sms_auth'
    require_dependency 'smsauth_medialog/hooks'
    require_dependency 'tasks/account_controller_patch_auth2fs'
  #require_dependency 'user_patch'
  end

end
