namespace :email do
  desc 'Emails status update requests to lead team members'

  task status_update_request: :environment do
    return unless (Time.current.monday? || Time.current.thursday?)
    require 'sendinblue'
    m = Sendinblue::Mailin.new("https://api.sendinblue.com/v2.0", ENV['SENDINBLUE_API_KEY'])

    user = User.find_by(email: 'bryan.finlayson@metova.com')

    user.contacts.lead_team.each do |developer|
      next if developer.has_submitted_weekly_status_update?

      lead_email = developer.user.email
      developer_email = developer.email

      data = { "to" => { developer_email => developer.full_name },
        "from" => [lead_email],
        "replyto" => [lead_email],
        "subject" => "Weekly Developer Status Update",
        "text" => "Hi, #{developer.first_name}. Please give me a short update on what you've done this week and how you're progressing on your goals no later than noon Friday. Thanks so much! #{Rails.application.routes.url_helpers.new_retrospective_url(host: 'brinsk.herokuapp.com', auth_token: developer.auth_token)}",
        "headers" => {"Content-Type"=> "text/html;charset=iso-8859-1"}
      }

      result = m.send_email(data)
      puts result
      sleep 1
    end
  end
end
