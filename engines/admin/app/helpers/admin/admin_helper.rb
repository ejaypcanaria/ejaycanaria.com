module Admin
  module AdminHelper

    def enable_ckeditor(text_editor_id)
      editorConfig = %Q{
        CKEDITOR.replace('#{text_editor_id}', {
          uiColor: '#FFFFFF',
          toolbarGroups: [
            { name: 'basicstyles' },
            { name: 'paragraph',   groups: [ 'list', 'indent', 'blocks', 'align' ] },
            { name: 'styles' },
            { name: 'colors' },
            { name: 'links' },
            { name: 'insert' },
            { name: 'document', groups: [ 'mode', 'document', 'doctools' ] }
          ]
        });
      }

      javascript_tag(editorConfig)
    end

  end
end
