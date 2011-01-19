require File.join(File.dirname(__FILE__), 'gtranslatorresult')
require File.join(File.dirname(__FILE__), 'glanguage')
require 'rubygems'
require 'open-uri'
require 'json'

class GTranslator
  
  @@key = nil
  
  def self.key; @@key; end
  def self.key=(key); @@key = key; end
  
  def self.detect_language(query); translate(query, 'en').source; end
  
  def self.translate(query, target, source=nil)
    options = { :q => query, :target => target, :key => @@key } 
    options[:source] = source if source
    params = URI.escape(options.collect{|k,v| "#{k}=#{v}"}.join('&'))
    url = "https://www.googleapis.com/language/translate/v2?#{params}"
    result = JSON.parse(open(url).read)['data']['translations'].collect do |params|
      GTranslatorResult.new(query, target, params, source)
    end
    return result.size == 1 ? result.first : result
  end

end