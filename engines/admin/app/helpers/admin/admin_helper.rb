module Admin
  module AdminHelper

    def enable_ckeditor(text_editor_id)
      editorConfig = %Q{
        CKEDITOR.replace('#{text_editor_id}', {
          uiColor: '#FFFFFF'
        });
      }

      javascript_tag(editorConfig)
    end

  end
end
