!function($, win, doc) {

  $(doc).ready(function() {

    if( idExists('#typeahead-tag-container') ) {

      var tagsURL = $('#get_all_tag_url').val();
      var typeaheadInput = $('#typeahead-tag-container .typeahead');

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

      getAllTags(tagsURL, function(tags) {

        var appendTag = function(tag) {
          $('#tags').append("<div class='label label-info'>" + tag + "</div>");
          typeaheadInput.val("");
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
          appendTag(data.name);
          console.log(tags);
          tags.splice(tags.indexOf(data), 1);
        });

      });

    }

  });
}(window.jQuery, window, document);
