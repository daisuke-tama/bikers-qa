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
import "@fortawesome/fontawesome-free/js/all"
import "../stylesheets/application.scss"
import "../stylesheets/home.scss"
import "../stylesheets/reset.scss"
import "../stylesheets/users.scss"
import "../stylesheets/articles.scss"
import "../stylesheets/rooms.scss"
import "../stylesheets/questions.scss"
import "../stylesheets/notifications.scss"
import "../stylesheets/actiontext.scss"
import "../stylesheets/my_bikes.scss"
import "tagsinput"
import "flash-timeout"
import "profile-image-prev"
import "my-bike-picture-prev"

// Uncomment to copy all static images under ../images to the output folder and reference
// them with the image_pack_tag helper in views (e.g <%= image_pack_tag 'rails.png' %>)
// or the `imagePath` JavaScript helper below.
// webpackerを使用してjavascript/images配下を読むために記述
const images = require.context('../images/', true)
// const imagePath = (name) => images(name, true)

Rails.start()
Turbolinks.start()
ActiveStorage.start()

require("trix")
require("@rails/actiontext")
