class Photo < ApplicationRecord
   mount_uploader :avatar, AvatarUploader
<<<<<<< HEAD
=======
  
>>>>>>> avatar
   belongs_to :product, optional: true
end
