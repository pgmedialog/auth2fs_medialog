require_dependency 'account_controller'

module AccountControllerPatchAuth2fs

  def self.included(base)
    base.send(:include, InstanceMethods)
    base.class_eval do
      alias_method_chain :password_authentication, :auth2fs
    end
  end

  module InstanceMethods

 #def login_with_auth2fs
      
  #    login_without_auth2fs
      #renter "login_auth2fs"
 #   end

    def password_authentication_with_auth2fs
    #
#    user = User.where(login: params[:username].to_s).first
      Rails.logger.info "Run Command password_authentication_with_auth2fs"
      auth2fs = Auth2fs.where(login: params[:username]).first
#    catstr = "test"
      if auth2fs != nil
        rails_root = Rails.root
        command = "/bin/sh #{rails_root}/plugins/smsauth_medialog/bin/run.sh OTP_VALI " + "  " + params[:auth_key] + " " + auth2fs.hash_code

#need check
        Rails.logger.info "Run Command OtpValidator : #{command} "
        ret = IO.popen( command )
        result = ret.readline.strip
        Rails.logger.info "result otp.OtpValidator : #{result} "
        if result == "true"
          password_authentication_without_auth2fs
        else
          invalid_credentials   
        end
      else
        invalid_credentials 
      end
    end

  end
end    

   


AccountController.send(:include, AccountControllerPatchAuth2fs)