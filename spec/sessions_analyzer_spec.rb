require 'json'

require_relative '../lib/events_transformer'
require_relative '../lib/sessions_analyzer'
require_relative '../lib/file_reader'

describe SessionsAnalyzer do
  events_data = FileReader.new('sessions_data.json').read
  events = EventsTransformer.new(events_data)

  subject { described_class.new(events) }

  expected_output = JSON.pretty_generate({
    "sessionsByUser": {
        "f877b96c-9969-4abc-bbe2-54b17d030f8b": [
            {
                "duration": 41294,
                "pages": [
                    "/pages/a-sad-story",
                    "/pages/a-big-talk"
                ],
                "startTime": 1512709024000
            },
            {
                "duration": 0,
                "pages": [
                    "/pages/a-sad-story"
                ],
                "startTime": 1512711000000
            }
        ],
        "d1177368-2310-11e8-9e2a-9b860a0d9039": [
            {
                "duration": 195000,
                "pages": [
                    "/pages/a-big-river",
                    "/pages/a-big-river",
                    "/pages/a-small-dog"
                ],
                "startTime": 1512754436000
            }
        ]
    }
  })

  it "should print sessions by visior Id" do
    expect(subject.print).to eq(expected_output)
  end
end