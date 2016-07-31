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
//= require bootstrap-sprockets
//= require jquery.validate.min
//= require_tree .


$(document).ready(function () {
  var modal = $('#myModal');
  var btn = $('#launch-btn');
  var span = $('.close');

  btn.click(function () {
    openModal()
  });

  function openModal() {
    $('#length-field, #width-field, #height-field, #weight-field').val("");
    $("input").prop('disabled', false);
    $('#response, #answer-names').empty();
    $('#calculate').show();
    modal.show();
  }

  function closeModal() {
    modal.hide();
  }

  $('span.close').click(function () {
    closeModal()
  });

  $('#calculate').click(function () {
    $('#calculator-form').validate({
      rules: {
        length: {
          required: true
        },
        width: {
          required: true
        },
        height: {
          required: true
        },
        weight: {
          required: true
        }

      },
      highlight: function (element) {
        $(element).closest('.control-group').removeClass('success').addClass('error');
      },
      success: function (element) {
        element
          .text("Ok").addClass('valid')
          .closest('.control-group').removeClass('error').addClass('success');
      },
      submitHandler: function (form) {
        var length = $('#length-field').val();
        var width = $('#width-field').val();
        var height = $('#height-field').val();
        var weight = $('#weight-field').val();
        var url = "/api/v1/products/measurements/" + length + "/" + width + "/" + height + "/" + weight;
        $.ajax({
          type: "GET",
          url: url,
          enctype: "multipart/form-data",
          contentType: false,
          processData: false,
          success: function (response) {
            $("#response").empty();
            $('label.valid, #calculate').hide();
            $("input").prop('disabled', true);
            $.each(response, function (index, name) {
              console.log("Use this" + " " + name);
              $("#response").fadeIn().append("<p class=\"col-md-3\">Use this" + " " + name + "</p>");
            });
            var product = $('#response').html();
            var answers = $('#answer-names');
            setTimeout(function () {
              closeModal();
              answers.html(product);
              $('html, body').animate({
                scrollTop: answers.offset().top
              }, 2000);
            }, 5000);

          },
          complete: function (r) {
            var response = $("#response");
            if(r.responseText === "There are no matches for these measurments") {
              response.empty();
              response.fadeIn().append("<p class=\"col-md-12\">" + r.responseText + "</p>");
            }
          },
          error: function (msg) {
            console.log(msg);
          }
        });
      }
    });
  });

});




