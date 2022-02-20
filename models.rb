ActiveRecord::Base.establish_connection

class User < ActiveRecord::Base
    has_secure_password
    
    validates :name,
     uniqueness: true
    
end

class Task <  ActiveRecord::Base
    
end

class UserTask <  ActiveRecord::Base
    
end