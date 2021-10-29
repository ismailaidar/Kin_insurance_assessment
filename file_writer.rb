require './verify_checksum.rb'
require 'date'


Status = { 
  err: "ERR",
  ill: "ILL"
}

class FileWriter

  def initialize(numbers)
    @numberes = numbers
    @verifier = VerifyCheckSum.new(numbers)
  end

  def write_to_file(string)
    File.write("./files/file#{DateTime.now()}", string)
  end

  def build_file
    file_string = ""
    for number in @numberes do
      file_string += "#{number} "
      result = @verifier.verify(number.to_i)
      if result
        file_string += "#{Status[:err]} \n"
      # else
      #   file_string += "#{Status[:ill]} \n"
      end
    end
    write_to_file(file_string)
  end

end