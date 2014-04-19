(function($, win, doc) {

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
      var $messageWrapper         = $('#typeahead-tag-container #message-wrapper');
      var $existingTagWrappers    = $('.existing-tag');

      var displayTagMessage = function(message) {
        $messageWrapper.hide().html(message).fadeIn(300);
        setTimeout(function() {
          $messageWrapper.fadeOut(300);
        }, 4000);
      }

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

      var tagIsNotAdded = function(tagName) {
        return $currentTags.indexOf(tagName) < 0;
      };

      var appendTagCheckbox = function(tag) {
        var tagCheckbox = createTagCheckbox($taggable, tag);
        $tagsInputWrapper.append(tagCheckbox);
      };

      var appendNewTagInput = function(tagName) {

        var newTag = createNewTag($taggable, tagName);
        $newTagsInputWrapper.append(newTag);

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

        var tagData = { name: tagName };

        newTagInput.type   = "hidden";
        newTagInput.id     = model + "_tag_" + newTagCounter;
        newTagInput.name   = model + "[tags_attributes][][name]";
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
        $('#blog_title').focus();
        return false;
      });

      getAllTags($tagsURL, function(tags) {

        var appendTag = function(tagName, newTag) {
          if(tagIsNotAdded(tagName)) {
            var tagIndex = findIndex(tagName);
            var tag = tags[tagIndex];

            $tagsWrapper.append("<div class='label label-info'>" + tagName + "</div>");

            if(newTag === true) {
              appendNewTagInput(tagName);
            } else {
              appendTagCheckbox(tag);
            }

            $currentTags.push(tagName);
            removeTag(tag);
          } else {
            displayTagMessage("Tag already exists!");
          }
          $typeaheadInput.val("");
        };

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
          //if(tagIndex != undefined) {
            tags.splice(tags.indexOf(tag), 1);
          //}
        };

        var appendExistingTags = (function() {
          $.each($existingTagWrappers, function(i, data) {
            appendTag(data.innerText);
            data.remove();
          });
        })();

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

          appendTag(data.name, false);

        }).on('keypress', function(e, data) {
          if(e.which == 13) {
            var tagName = $.trim($typeaheadInput.val().toLowerCase());
            if(tagName === '') {
              displayTagMessage("Please input a tag name!");
              return;
            }
            appendTag(tagName, true);
          }
        });

      });

    }

  });

})(window.jQuery, window, document);
