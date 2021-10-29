
class FileReader
  attr_reader :filename

  def initialize(filename)
    @filename = filename
  end

  def read
    File.read(File.dirname(File.dirname(__FILE__)) + '/input/' + filename)
  end
end
