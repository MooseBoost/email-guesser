require 'open-uri'
require 'json'

class Predictor
  
  def initialize(json_file)
    @dataset = JSON.parse(File.read(json_file))
  end
  
  
  def guess(full_name, company_name)

    @company = company_name
    @name = full_name.downcase.split
  
    template = @dataset.values.detect do |address|
      address.include? @company
    end
    
    if template == nil
      ex_adds = ["a.b@c", "a.bb@c", "aa.b@c", "aa.bb@c"]
    else
      ex_adds = [template]
    end
    
    email_guess = ex_adds.collect do |address|
      user = address.slice(0...(address.index('@')))
      components = user.split('.')
      
      components[0].length == 1 ? first = @name.first[0] : first = @name.first
      components[1].length == 1 ? last = @name.last[0] : last = @name.last
      
      "#{first}.#{last}@#{@company}"
    end
      
    email_guess
  end
end

	