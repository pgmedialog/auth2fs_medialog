class SmsAuthController < ApplicationController
  unloadable



  #def send(params, b)
  def send(a, b)
#    @parameter = Parameters.all
#    //sms .send 한후 인증 번호를 회신한다.
    username = params[:username]
    password = params[:password]
    pw_to_encrypt = params[:pwToEncrypt]
   
  #전화번호를 불러온다.
    user = User.where(login: username).first

   # attr = User.try_to_login(username, password, false)
  #난수발 생
     rand = SmsAuth.generate_sms_password
  #system call
      
   # poll = Poll.find(params[:username])
 ########   Rails.logger.info "getparams for #{username} #{pw_to_encrypt} #{user.login} "
 #   Rails.logger.info "getparams for #{user.mobile} #{rand} "
    system "touch /tmp/abxx"


#poll
#    poll = params[:abab]
#    Rails.logger.info "Repository for #{poll}"
#    Rails.logger.info "Repository for "
#    poll = Poll.find(params[:id])
#       logger.error "Repository for #{project.name} was reported to be created by #{request.remote_ip}."	
#	logger.info "info Repository for #{project.name} was reported to be created by #{request.remote_ip}."	
  end


  def is_exist

#    test = params[:login]
#    system("touch /tmp/axax"+test);
#    Rails.logger.info("test")
# Auth2fs.create(lo 
#
#   auth2fs = Auth2fs.find(params[:login]) 
#   login_id = params[:login]
#   user = Auth2fs.where(login: "jatu").first
    @test222 = "ababab"
#   Rails.logger.info " #{user.login}"
#   reutrn auth2fs.login
#     " #{auth2fs.login} "
#	"ab #{user.login}"
  end


end





