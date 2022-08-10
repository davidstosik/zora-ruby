# frozen_string_literal: true

module Zora
  module SaveFileHelper
    def save_file(name)
      @save_files ||= {}
      @save_files[name] ||= SaveFile.new(save_file_path(name))
    end

    def save_file_path(name)
      "test/saves/#{name}.srm"
    end
  end
end
