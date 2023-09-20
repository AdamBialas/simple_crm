// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.
global.$ = require('jquery')

import Rails from "@rails/ujs"
import Turbolinks from "turbolinks"
import * as ActiveStorage from "@rails/activestorage"
import "channels"
import "@fortawesome/fontawesome-free/css/all"
import 'bootstrap-table/dist/bootstrap-table'
import 'bootstrap-table/dist/extensions/cookie/bootstrap-table-cookie'
import 'bootstrap-table/dist/extensions/page-jump-to/bootstrap-table-page-jump-to'
import 'bootstrap'

import 'select2'
import 'select2/dist/css/select2.css'
import 'select2-bootstrap-theme/dist/select2-bootstrap.css'
import 'flatpickr/dist/flatpickr.css'
import 'flatpickr/dist/plugins/confirmDate/confirmDate.css'
import 'flatpickr'
import flatpickr from "flatpickr"

import'flatpickr/dist/plugins/confirmDate/confirmDate'
import confirmDatePlugin from 'flatpickr/dist/plugins/confirmDate/confirmDate'

Rails.start()
Turbolinks.start()
ActiveStorage.start()

window.jQuery = $;
window.$ = $;
import toastr from 'toastr'
window.toastr = toastr
import Swal from "sweetalert2/dist/sweetalert2.js"
import "sweetalert2/src/sweetalert2"
window.Swal = Swal

window.addEventListener('DOMContentLoaded', () => {
    $('.content-search').select2();
    $('.table-regular').bootstrapTable();
  });


$(document).ready(function () {
    
    $('.table-regular').bootstrapTable();
    
    $('.send-form-after-change').change(function () {
        $(this).parents('form').submit();
    });  

    $('.form-remove-empty-get-params').submit(function() {
              $(this).find('input, select').each(function() {
                  var input = $(this);
                  if( !input.val() )
                      input.attr('name', '');
              });
          });
});


  