!function($, win, doc) {

  $(doc).ready(function() {

    if( idExists('#typeahead-tag-container') ) {

      var tagsURL             = $('#get_all_tag_url').val();
      var typeaheadInput      = $('#typeahead-tag-container .typeahead');
      var addTagText          = $('#add-tag-text');
      var addTagInput         = $('#add-tag-input');
      var doneText            = $('#done-text');
      var checkboxCounter     = 1;


      typeaheadInput.on('blur', function() {
        this.val("");
      });

      addTagText.on('click', function() {
        addTagInput.removeClass('hidden');
        addTagText.hide();
        return false;
      });

      doneText.on('click',function() {
        addTagInput.addClass('hidden');
        addTagText.show();

        return false;
      });

      var getAllTags = function(url, callback) {
        $.ajax({
          url: url,
          dataType: 'json',
          success: function(data) {
            callback(data);
          }
        });
      };

      var substringMatcher = function(tags) {
        return function findMatches(q, cb) {
          var matches, substringRegex;

          matches = [];

          substringRegex = new RegExp(q, 'i');

          $.each(tags, function(i, tag) {
            if(substringRegex.test(tag.name)) {
              matches.push(tag);
            }
          });

          cb(matches);
        };
      };

      var createTagCheckbox = function(model, tag) {
        var tagCheckbox = document.createElement("input");

        tagCheckbox.type    = "checkbox";
        tagCheckbox.id      = model + "_tags_id_" + checkboxCounter;
        tagCheckbox.name    = model + "[tag_ids][]";
        tagCheckbox.value   = tag.id;
        tagCheckbox.checked = "checked";

        checkboxCounter++;

        return tagCheckbox;
      }

      getAllTags(tagsURL, function(tags) {

        var appendTag = function(tag) {
          $('#tags').append("<div class='label label-info'>" + tag.name + "</div>");
          var tagCheckbox = createTagCheckbox("blog", tag);
          $('#tags-input').append(tagCheckbox);
        };

        typeaheadInput.typeahead({
            hint: true,
            highlight: true,
            minLength: 1
          },
          {
            name: 'tags',
            displayKey: 'name',
            source: substringMatcher(tags)
          }
        ).on("typeahead:selected", function(e, data) {
          appendTag(data);
          tags.splice(tags.indexOf(data), 1);
          typeaheadInput.val("");
        });
      });

    }

  });
}(window.jQuery, window, document);
