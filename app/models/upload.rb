class Upload < ApplicationRecord
	has_many :active_storage_attachments
	has_one_attached :logo

end
