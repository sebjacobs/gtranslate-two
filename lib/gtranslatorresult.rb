class GTranslatorResult
  
  attr_reader :translation, :original, :target, :source
  
  private #------
  
  def initialize(original, target, params, source=nil)
    @original = original
    @target = target
    @translation = CGI.unescapeHTML(params['translatedText'])
    @source = source || params['detectedSourceLanguage']
  end
  
end