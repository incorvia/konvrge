task :set_scores => :environment do
  Event.process_votes
end