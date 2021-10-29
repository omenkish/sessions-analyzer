require 'json'
require_relative "../lib/events_transformer"

describe EventsTransformer do
  data = {
    "events": [
         {
             "url": "/pages/a-big-river",
             "visitorId": "d1177368-2310-11e8-9e2a-9b860a0d9039",
             "timestamp": 1512754583000
         },
         {
             "url": "/pages/a-small-dog",
             "visitorId": "d1177368-2310-11e8-9e2a-9b860a0d9039",
             "timestamp": 1512754631000
         },
        {
            "url": "/pages/a-big-talk",
            "visitorId": "f877b96c-9969-4abc-bbe2-54b17d030f8b",
            "timestamp": 1512709065294
        },
    ]
  }.to_json

  subject { described_class.new(data) }

  it "should have the events array and the keys transformed to symbols" do    
    expect(subject.events.class).to be Array
    expect(subject.events).to eq([
      {:url=>"/pages/a-big-river", :visitorId=>"d1177368-2310-11e8-9e2a-9b860a0d9039", :timestamp=>1512754583000},
      {:url=>"/pages/a-small-dog", :visitorId=>"d1177368-2310-11e8-9e2a-9b860a0d9039", :timestamp=>1512754631000},
      {:url=>"/pages/a-big-talk", :visitorId=>"f877b96c-9969-4abc-bbe2-54b17d030f8b", :timestamp=>1512709065294}
    ])
  end

  it "should group items by keys" do
    expect(subject.group_by_visitor_id).to have_key("d1177368-2310-11e8-9e2a-9b860a0d9039")

    expect(subject.group_by_visitor_id).to have_key("f877b96c-9969-4abc-bbe2-54b17d030f8b")
  end
end