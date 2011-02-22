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

        scope = "#{object.class.name.underscore}[#{attribute_name}_attributes]"
        lis = object.send(attribute_name).map do |obj|
          <<-HTML.html_safe
            <li>
              <input name="#{scope}[#{object.id}][_destroy]" type="hidden" value="false" />
              <input name="#{scope}[#{object.id}][asset_path]" type="hidden" value="#{obj.asset_path}" />
              #{obj.asset_path}
            </li>
          HTML
        end.join("\n").html_safe

        "<div class='file_upload' id='#{genid}'><ul class='asset_list'>#{lis}</ul></div>".html_safe
      end 
      
    end
  end
end

