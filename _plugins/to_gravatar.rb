require 'digest/md5'

module Jekyll
  class RenderGravatar < Liquid::Tag

    def initialize(tag_name, text, tokens)
      super
      # Get the key-val attributes in the string as a hashed map.
      @attributes = text.scan(::Liquid::TagAttributes).to_h
    end

    def render(context)
      hash = Digest::MD5.hexdigest(@attributes['email'].downcase.strip)
      size = @attributes['size']
      return "//gravatar.com/avatar/#{hash}?s=#{size}"
    end
  end
end

Liquid::Template.register_tag('to_gravatar', Jekyll::RenderGravatar)
