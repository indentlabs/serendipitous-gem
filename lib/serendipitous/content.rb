# Temp Content class stand-in for notebook gem
class Content
  attr_reader :data

  def initialize fields={}
    defaults = {
      title: 'Alice',
      type: 'Character',
      description: 'Protagonist',
      some_blank_field: ''
    }
    @data = defaults.merge(fields)
  end

  # TODO: find jesus
  def method_missing method
   # TODO: Does this let you data[method][some_list][some_value]
   data[method]
  end

end
