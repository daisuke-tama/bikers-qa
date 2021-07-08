// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

import Rails from "@rails/ujs"
import Turbolinks from "turbolinks"
import * as ActiveStorage from "@rails/activestorage"
import "channels"
import "jquery"
import "bootstrap"
import "../stylesheets/application.scss"
import "../stylesheets/home.scss"
import "../stylesheets/reset.scss"
import "../stylesheets/users.scss"
import "../stylesheets/articles.scss"

Rails.start()
Turbolinks.start()
ActiveStorage.start()

// flashメッセージを秒数指定で消す
$(function(){
  setTimeout("$('.flash').fadeOut('slow')", 2000);
});
