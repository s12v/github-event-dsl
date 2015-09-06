module GitHub::Template

  @path = ''
  
  # @param [String] template
  # @return [String]
  def self.load(template)
    File.read File.join(@path, "#{template}.erb")
  end

  # @param [String] path
  def self.path=(path)
    @path = path
  end
  
end
