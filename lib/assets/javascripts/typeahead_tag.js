!function($, win, doc) {

  $(doc).ready(function() {

    if( idExists('#typeahead-tag-container') ) {

      var $taggable               = $('#taggable').val();
      var $tagsURL                = $('#get_all_tag_url').val();
      var $typeaheadInput         = $('#typeahead-tag-container .typeahead');
      var $addTagText             = $('#add-tag-text');
      var $addTagInputWrapper     = $('#add-tag-input-wrapper');
      var $doneText               = $('#done-text');
      var $tagsWrapper            = $('#tags-wrapper');
      var $tagsInputWrapper       = $('#tags-input-wrapper');
      var $newTagsInputWrapper    = $('#new-tags-input-wrapper');
      var $currentTags            = [];

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

      var appendTag = function(tagName) {
        if(tagIsNotAdded(tagName)) {
          $tagsWrapper.append("<div class='label label-info'>" + tagName + "</div>");
          $currentTags.push(tagName);
        }
        $typeaheadInput.value = "";
      };

      var tagIsNotAdded = function(tagName) {
        return $currentTags.indexOf(tagName) < 0;
      };

      var appendTagCheckbox = function(tag) {
        if(tagIsNotAdded(tag.name)) {
          var tagCheckbox = createTagCheckbox($taggable, tag);
          $tagsInputWrapper.append(tagCheckbox);
        }
      };

      var appendNewTagInput = function(tagName) {
        if(tagIsNotAdded(tagName)) {
          var newTag = createNewTag($taggable, tagName);
          $newTagsInputWrapper.append(newTag);
        }
      };


      var checkboxCounter   = 1;
      var createTagCheckbox = function(model, tag) {
        var tagCheckbox = document.createElement("input");

        tagCheckbox.type    = "checkbox";
        tagCheckbox.id      = model + "_tags_id_" + checkboxCounter;
        tagCheckbox.name    = model + "[tag_ids][]";
        tagCheckbox.value   = tag.id;
        tagCheckbox.checked = "checked";

        checkboxCounter++;

        return tagCheckbox;
      };

      var newTagCounter = 1;
      var createNewTag  = function(model, tagName) {
        var newTagInput = document.createElement("input");

        newTagInput.type   = "hidden";
        newTagInput.id     = model + "_tag_" + newTagCounter;
        newTagInput.name   = model + "[tags][]";
        newTagInput.value  = tagName;

        newTagCounter++;

        return newTagInput;
      };

      $addTagText.on('click', function() {
        $addTagInputWrapper.removeClass('hidden');
        $typeaheadInput.focus();
        $addTagText.hide();
        return false;
      });

      $doneText.on('click',function() {
        $addTagInputWrapper.addClass('hidden');
        $addTagText.show();

        return false;
      });

      getAllTags($tagsURL, function(tags) {

        var findIndex = function(tagName) {
          var result;
          $.each(tags, function(i, tag) {
            if(tagName == tag.name) {
              result = i;
              return false;
            }
          });
          return result;
        };

        var removeTag = function(tag) {
          tags.splice(tags.indexOf(tag), 1);
        };

        $typeaheadInput.typeahead({
            hint: true,
            highlight: true,
            minLength: 1
          },
          {
            name: 'tags',
            displayKey: 'name',
            source: substringMatcher(tags)
          }
        );

        $typeaheadInput.on('blur', function() {
          this.value = "";
        }).on('typeahead:selected', function(e, data) {

          appendTag(data.name);
          appendTagCheckbox(data);
          removeTag(data);
          $typeaheadInput.val("");

        }).on('keypress', function(e, data) {

          if(e.which == 13) {
            var tagName = $typeaheadInput.val();
            var tagIndex = findIndex(tagName);

            appendNewTagInput(tagName);

            appendTag(tagName);
            removeTag(tags[tagIndex]);
          }
        });

      });

    }

  });
}(window.jQuery, window, document);
