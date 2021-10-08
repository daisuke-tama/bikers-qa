// マイバイクの新規登録・編集時の画像のプレビュー機能
$(document).on('turbolinks:load', function () {
  $(function () {
    function buildHTML(image) {
      var html =
        `
        <div class="prev-content">
          <img src="${image}", alt="preview" class="prev-image my-bike-picture">
        </div>
        `
      return html;
    }

    $(document).on('change', '.hidden_file_my_bike_picture', function () {
      var file = this.files[0];
      var reader = new FileReader();
      reader.readAsDataURL(file);
      reader.onload = function () {
        var image = this.result;
        if ($('.prev-content').length == 0) {
          var html = buildHTML(image)
          $('.prev-contents').prepend(html);
          $('.photo-icon').hide();
        } else {
          $('.prev-content .prev-image').attr({ src: image });
        }
      }
    });
  });
});
