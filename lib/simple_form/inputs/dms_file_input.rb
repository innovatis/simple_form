module SimpleForm
  module Inputs
    class DmsFileInput < Base

      def input
        @builder.hidden_field(attribute_name, input_html_options)
      end

      protected

      def input_html_options
        bucket = object.class.file_fields[attribute_name]
        if bucket.kind_of?(Hash) 
          if Rails.env.production? 
            bucket = bucket[:production]
          else 
            bucket = bucket[:development]
          end 
        end 
        
        raise "bucket identifier not found" if bucket.blank?
        super.merge('data-bucket' => bucket)
      end 
      
      def input_html_classes
        if object.class.reflect_on_association(attribute_name).try(:macro) == :has_many
          super + [:multiple]
        else 
          super
        end 
      end 
      
      def is_has_many?
        object.class.reflect_on_association(attribute_name).try(:macro) == :has_many
      end 
      
      def components_list
        super + [:file_upload]
      end 

      AVB = ActionView::Base.new(["#{Rails.root}/app/views"])
      
      def file_upload
        genid = (rand 2**32).to_s(16)
        if object.class.reflect_on_association(attribute_name).try(:macro) == :has_many
          ul = AVB.render(:partial => (@options[:asset_list_partial] || '/inherited_resources/asset_list'), 
            :locals => {:object => object, :attribute_name => attribute_name})
   
          "<div class='file_upload' id='#{genid}'>#{ul}</div>".html_safe
        else 
          "<div class='file_upload' id='#{genid}'></div>".html_safe
        end 
      end 
      
    end
  end
end

