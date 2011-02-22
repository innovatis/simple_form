module SimpleForm
  module Inputs
    class DmsFileInput < Base

      def input
        @builder.hidden_field(attribute_name, input_html_options)
      end

      protected

      def components_list
        super + [:file_upload]
      end 

      def file_upload
        genid = (rand 2**32).to_s(16)
        "<div class='file_upload' id='#{genid}'></div>".html_safe
      end 
      
    end
  end
end

