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
      var $currentModelTags       = [];
      var $messageWrapper         = $('#typeahead-tag-container #message-wrapper');
      var $existingTagWrappers    = $('.existing-tag');

      var displayTagMessage = function(message) {
        $messageWrapper.hide().html(message).fadeIn(300);
        setTimeout(function() {
          $messageWrapper.fadeOut(300);
        }, 4000);
      }

      var getAllPersistedTags = function(url, callback) {
        $.ajax({
          url: url,
          dataType: 'json',
          success: function(persistedTags) {
            callback(persistedTags);
          }
        });
      };

      var tagIsNotAdded = function(tagName) {
        return $currentModelTags.indexOf(tagName) < 0;
      };

      var appendNewTagInput = function(tagName) {
        var inputName = $taggable + "[tags_attributes][][name]";
        var newTagNameInput = createNewTag(inputName, tagName);
        $newTagsInputWrapper.append(newTagNameInput);
      };

      var appendTagSuggestionInput = function(tagId) {
        var inputName = $taggable + "[tag_ids][]";
        var tagSuggestionInput = createNewTag(inputName, tagId);
        $newTagsInputWrapper.append(tagSuggestionInput);
      };

      var newTagCounter = 1;
      var createNewTag  = function(inputName, tagAttributeValue) {
        var newTagInput = document.createElement("input");

        newTagInput.type   = "hidden";
        newTagInput.id     = $taggable + "_tag_" + newTagCounter;
        newTagInput.name   = inputName;
        newTagInput.value  = tagAttributeValue;

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

      getAllPersistedTags($tagsURL, function(tagsSuggestion) {

        var appendTag = function(tagName) {
          if(tagIsNotAdded(tagName)) {
            var tagIndex = findIndex(tagName);
            var tag = tagsSuggestion[tagIndex];

            $tagsWrapper.append("<div class='label label-info'>" + tagName + "</div>");
            if(tagIndex === undefined) {
              appendNewTagInput(tagName);
            } else {
              appendTagSuggestionInput(tag.id);
              removeFromSuggestionTags(tagIndex);
            }

            $currentModelTags.push(tagName);

          } else {
            displayTagMessage("Tag already exists!");
          }
          $typeaheadInput.val("");
        };

        var findIndex = function(tagName) {
          var result;
          $.each(tagsSuggestion, function(i, tag) {
            if(tagName == tag.name) {
              result = i;
              return false;
            }
          });
          return result;
        };

        var removeFromSuggestionTags = function(tagIndex) {
          tagsSuggestion.splice(tagIndex, 1);
        };

        var appendExistingTags = (function() {
          $.each($existingTagWrappers, function(i, data) {
            appendTag(data.innerText);
            data.remove();
          });
        })();


        // --------------- Typeahead Codes --------------- //
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

        $typeaheadInput.typeahead({
            hint: true,
            highlight: true,
            minLength: 1
          },
          {
            name: 'tags',
            displayKey: 'name',
            source: substringMatcher(tagsSuggestion)
          }
        );

        $typeaheadInput.on('blur', function() {
          this.value = "";
        }).on('typeahead:selected', function(e, tag) {

          appendTag(tag.name);

        }).on('keypress', function(e, data) {
          if(e.which == 13) {
            var tagName = $.trim($typeaheadInput.val().toLowerCase());
            if(tagName === '') {
              displayTagMessage("Please input a tag name!");
              return;
            }
            appendTag(tagName);
          }
        });

      });

    }

  });

})(window.jQuery, window, document);
