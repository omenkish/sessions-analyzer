require_relative "../lib/file_reader"

describe FileReader do 
  subject { described_class.new("sessions_data.json") }

  it "should take the input file and read it as string" do
    expect(subject.read.class).to be String
  end
end