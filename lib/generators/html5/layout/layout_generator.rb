require "generators/html5/generator_helpers"

module Html5
  module Generators
    class LayoutGenerator < ::Rails::Generators::NamedBase
      include Html5::Generators::GeneratorHelpers

      source_root File.expand_path('../templates', __FILE__)

      argument :name, :type => :string,
                      :required => false,
                      :default => "application"

      class_option :all_partials, :type => :boolean,
                                  :default => false,
                                  :desc => "Generate all partials for this layout"

      class_option :minimal_partials, :type => :boolean,
                                      :default => false,
                                      :desc => "Generate minimal partials for this layout"

      class_option :template_engine

      def generate_layout
        if file_path == "application" && options[:template_engine].to_s != "erb"
          remove_file File.join("app/views/layouts/application.html.erb")
        end
        template filename_with_extensions("application"), File.join("app/views/layouts", class_path, filename_with_extensions(file_name))
      end

      def generate_partials
        if options.all_partials?
          invoke "html5:partial", [], { :all => true, :path => file_path,
                                                      :template_engine => options[:template_engine] }
        end

        if options.minimal_partials?
          invoke "html5:partial", [], { :minimal => true, :path => file_path,
                                                          :template_engine => options[:template_engine] }
        end
      end
    end
  end
end
