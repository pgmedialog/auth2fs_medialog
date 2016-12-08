class PollsController < ApplicationController
  unloadable

  skip_before_filter :check_if_login_required, :check_password_change

  def index
    @auth2fses = Auth2fs.all
       #auth2fs = Auth2fs.find(params[:login]) 
    #@auth2fs = Auth2fs.where(login: params[:login]).first
	  #1
	#@polls = Auth2fs.all
    #@aaaa = "teststring"
    #Rails.logger.info "Repository for  "
#  #{project.name} was reported to be created by #{request.remote_ip}."
#        Rails.logger.info "info Repository for #{project.name} was reported to be created by #{request.remote_ip}."
  end

  def exist
# render text:
    auth2fs = Auth2fs.where(login: params[:login]).first
    if auth2fs == nil
      catstr = "not exist"	
    else
      catstr = "exist"	
    end  
 
#    catstr = "aaaaa" + "bbb" + auth2fs[:login]
    render text: "#{catstr}"
 #   @id = "teststr"||"abab"||auth2fs.login
  end
  
  
  def sendAuth2fsEmail

# login, password
  
    login = params[:username].to_s
    password = params[:password].to_s
    #Rails.logger.info "password_hash : #{login} #{password}"
    user = User.try_to_login(login, password, false)
  

    if user == nil
      result = "authfail"
      Rails.logger.info "Run Command try_to_login : fail"
      render text: "authfail"
      return true
    else
      Rails.logger.info "Run Command try_to_login : #{user.login}  #{user.mail}"
      result = "true"
      rails_root = Rails.root
      command = "/bin/sh #{rails_root}/plugins/smsauth_medialog/bin/run.sh  SEND_QR  " + params[:username] + " #{user.mail} "
      Rails.logger.info "Run Command : #{command} "
      ret = IO.popen( command )
      # result is true or false
      result = ret.readline
        if result.strip == "true"
          result = user.mail
          # get hash_code
          command = "/bin/sh #{rails_root}/plugins/smsauth_medialog/bin/run.sh GET_SEC  " + params[:username]
          Rails.logger.info "Run Command : #{command} "
          ret = IO.popen( command )
          hash_code = ret.readline.strip
          Rails.logger.info "hash_code  : #{hash_code} "

          auth2fs = Auth2fs.where(login: login).first
#    catstr = "test"
          if auth2fs == nil
            result = "false" 
            result = Auth2fs.create(login: login, hash_code: hash_code)
            Rails.logger.info "auth2fs insert  : #{result}"
          else
            auth2fs = Auth2fs.where(login: params[:login]).update_all(hash_code: hash_code)            
            Rails.logger.info "auth2fs update  : #{result}"
          end           
          Rails.logger.info "auth2fs insert or update result : #{result}"
          result = user.mail 
        end
    end
    render text: "#{result}"
  end



#
  def getHashCode 
# render text:
    auth2fs = Auth2fs.where(login: params[:login]).first
#    catstr = "test"
    if auth2fs == nil
      rails_root = Rails.root
      command = "/bin/sh #{rails_root}/plugins/smsauth_medialog/bin/run.sh GET_SEC  " + params[:login]
      Rails.logger.info "Run Command : #{command} "
      ret = IO.popen( command )
      result = ret.readline.strip
      Rails.logger.info "result : #{result} "
    else
      result = "false" 
    end
    render text: "#{result}"
  end


# insert hash_code  login
  def insertHashCode
# render text:
    hash_code = params[:hash_code]
    login = params[:login]
    result = ""

    auth2fs = Auth2fs.where(login: params[:login]).first
#    catstr = "test"
    if auth2fs == nil

      if hash_code == nil
        rails_root = Rails.root
        command = "/bin/sh #{rails_root}/plugins/smsauth_medialog/bin/run.sh GET_SEC " + params[:login]
        Rails.logger.info "Run Command : #{command} "
        ret = IO.popen( command )
        hash_code = ret.readline.strip
        Rails.logger.info "result : #{hash_code} "
      end

      result = Auth2fs.create(login: login, hash_code: hash_code)
      Rails.logger.info "result : #{result} "
      result = "true"
    else
      result = "false" 
    end
    render text: "#{result}"
  end

# insert hash_code  login1
  def deleteHashCode
# render text:
    login = params[:login]
    auth2fs = Auth2fs.where(login: params[:login]).first
#    catstr = "test"
    if auth2fs != nil
      result = Auth2fs.delete_all(login: login)
      Rails.logger.info "result : #{result} "
      result = "true"
    else
      result = "false" 
    end
    render text: "#{result}"
  end
	  


  def authHashCode 
# render text:
    auth2fs = Auth2fs.where(login: params[:login]).first
#    catstr = "test"
    if auth2fs != nil
      rails_root = Rails.root
#true or false
      command = "/bin/sh #{rails_root}/plugins/smsauth_medialog/bin/run.sh otp.OtpValidator " + params[:login] + " " + params[:auth_key] + " " + auth2fs.hash_code

#need check
      Rails.logger.info "Run Command : #{command} "
      ret = IO.popen( command )
      result = ret.readline.strip
      Rails.logger.info "result : #{result} "
    else
      result = "false" 
    end
    render text: "#{result}"
  end


#  def insert
#	Auth2fs.create(lo	
#  end


  def vote
    auth2fs = Auth2fs.find(params[:id])

    auth2fs.vote(params[:answer])
   if poll.save
    flash[:notice] = 'Vote saved.'
 end
    redirect_to :action => 'index'
  end
end
