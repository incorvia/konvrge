// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs
//= require_tree .

// Flash Fade
$(function() {
   $('#flash').delay(500).fadeIn('normal', function() {
      $(this).delay(2500).fadeOut();
   });
});

// Open external links in new tab
$(document).ready(function() {
  $("a").click(function() {
    link_host = this.href.split("/")[2];
    document_host = document.location.href.split("/")[2];

    if (link_host != document_host) {
      window.open(this.href);
      return false;
    }
  });
});

// Auto Link URL's
$(document).ready(function() {
  $(".answer-content").autolink();
});

jQuery.fn.autolink = function () {
  return this.each( function(){
    var re = /\b(((\S+)?)(@|mailto\:|(news|(ht|f)tp(s?))\:\/\/)\S+)\b/g;
    $(this).html( $(this).html().replace(re, '<a href="$1">$1</a> ') );
  });
}