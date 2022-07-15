class ClientMailer < ApplicationMailer

    def registration_update_email (registration_count)
        
        registrar_emails = User.joins(:role_users, :roles).where("role_name =?", "Registrar").pluck(:email).uniq
        
        registrar_emails.each do |email|
            mail(to: email, subject: "You have #{registration_count} new clients awaiting registration!")
        end
      end
end
