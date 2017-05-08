namespace :email do
  desc 'Emails status update requests to lead team members'

  task status_update_request: :environment do
    return unless (Time.current.monday? || Time.current.thursday?)

    user = User.find_by(email: 'bryan.finlayson@metova.com')

    user.contacts.lead_team.each do |developer|
      developer.send_status_update_request
    end
  end
end
