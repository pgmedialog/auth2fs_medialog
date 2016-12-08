# Plugin's routes
# See: http://guides.rubyonrails.org/routing.html
get 'polls', :to => 'polls#index'

#?login=jatu
get '2fs/exist', :to => 'polls#exist'
#?login=jatu
get '2fs/getHashCode', :to => 'polls#getHashCode'
#?login=jatu&hash_code=aaaaa
get '2fs/insertHashCode', :to => 'polls#insertHashCode'
#?login=jatu
get '2fs/deleteHashCode', :to => 'polls#deleteHashCode'
#?login=jatu&hash_code=aaaaa
get '2fs/authHashCode', :to => 'polls#authHashCode'
#?login=jatu&password=......:
post '2fs/sendAuth2fsEmail', :to => 'polls#sendAuth2fsEmail'
get '2fs/sendAuth2fsEmail', :to => 'polls#sendAuth2fsEmail'


