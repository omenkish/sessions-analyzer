require "json"

class EventsTransformer
  attr_accessor :events

  def initialize(data)
    @events = parse_data(data)[:events]
  end

  def group_by_visitor_id
    transformed_data = {}

    sort_by_timestamp.each do |event|
      if transformed_data[event[:visitorId]]
        transformed_data[event[:visitorId]] << event
      else
        transformed_data[event[:visitorId]] = [event]
      end
    end

    transformed_data
  end

  private

  def parse_data(data)
    JSON.parse(data, symbolize_names: true)
  end

  def sort_by_timestamp
    events.sort_by {|event| event[:timestamp]}
  end
end
