module FasterTSV
  def self.foreach filename, opts = {}, &block
    options = {
      :col_sep => "\t",
      :ignore_header_lines => 0,
    }.merge opts

    raise(ArgumentError, "Block needed") unless block_given?
    
    f = File.new(filename, "r")
    options[:ignore_header_lines].times { f.gets }

    while line = f.gets
      line.chomp!
      row = line.split(options[:col_sep])

      if block_given?
        yield row
      else
        row
      end
    end
  end
end
