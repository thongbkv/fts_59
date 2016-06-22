// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require bootstrap
//= require turbolinks
//= require_tree .

function remove_fields(link) {
  $(link).prev('input[type=hidden]').val('1')
  var parent = $(link).parents('.fields')
  $(link).closest('.fields').hide();
  parent.hide()
  parent.find('input:radio').prev().val(false)
}

function add_fields(link, association, content) {
  var new_id = new Date().getTime();
  var regexp = new RegExp('new_' + association, 'g')
  $(link).parent().before(content.replace(regexp, new_id))
}

var checkbox
checkbox = function () {
  $('body').on('DOMNodeInserted', function () {
    set_value_checkbox();
  });

  $('form').on('click', '.remove_fields', function(event){
    $(this).prev('input[type=hidden]').val(true);
    $(this).parent().parent().parent().hide();
    event.preventDefault();
  });
}

function set_value_checkbox () {
  $('.is_correct').click(function () {
    if ($('#question_type').val() == 'single') {
      $('.is_correct').not(this).attr('checked', false);
    }
  })
  $('#question_type').on('change', function() {
    $(".is_correct").attr('checked', false);
  });
}

function get_lessons () {
  var lesson_id = $('#lesson_subject_id').val();
  $.ajax({
    url: '/admin/subjects/' + lesson_id,
    type: 'GET'
  })
}

function set_state_question () {
  $('#approve').on('click', function(){
    $('#question_state').val("approve");
  });
  $('#unapprove').on('click', function(){
    $('#question_state').val("unapprove");
  });
  $('.state_question').on('click', function(){
    $('#question_state').val("approve");
  });
}

$(document).ready(checkbox);
$(document).on('page:load', checkbox);
$(document).on('page:load', set_value_checkbox);
$(document).on('page:load', set_state_question);

$(document).ready(function(){
  set_value_checkbox();
  get_lessons();
  set_state_question();
  $('#lesson_subject_id').on('change', function() {
    get_lessons();
  });
  $('#finish_mark').on('click', function(){
    $('.status_question').val("checked")
  });
});

