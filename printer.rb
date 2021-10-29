require_relative './lib/events_transformer'
require_relative './lib/sessions_analyzer'
require_relative './lib/file_reader'

events_data = FileReader.new('sessions_data.json').read
events = EventsTransformer.new(events_data)

sessions = SessionsAnalyzer.new(events)

puts sessions.print