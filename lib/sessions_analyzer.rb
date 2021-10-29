
class SessionsAnalyzer
  attr_reader :events

  def initialize(events)
    @events = events
  end

  def print
    JSON.pretty_generate({sessionsByUser: analyze})
  end

  private

  def analyze
    grouped_events = events.group_by_visitor_id

    grouped_events.transform_values do |event|
      grouped_sessions = event.chunk_while do |prev, current|
        current[:timestamp] - prev[:timestamp] < 600000
      end
  
      format_data(grouped_sessions)
    end
  end

  def format_data(grouped_sessions)
    grouped_sessions.map do |group|
      { 
        duration: group.last[:timestamp] - group.first[:timestamp],
        pages: group.map {|data| data[:url] },
        startTime: group.first[:timestamp]
      }
    end
  end
end
