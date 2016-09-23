// Generated by BUCKLESCRIPT VERSION 1.0.3 , PLEASE EDIT WITH CARE
'use strict';

var Caml_obj   = require("bs-platform/lib/js/caml_obj");
var Pervasives = require("bs-platform/lib/js/pervasives");
var $$Array    = require("bs-platform/lib/js/array");
var $$String   = require("bs-platform/lib/js/string");

function todoTemplate(todos) {
  var f = function (todo) {
    return "<li data-id='" + (todo[/* id */1] + ("'>\n\t\t\t\t<div class='view'>\n\t\t\t\t\t<input class='toggle' type='checkbox' " + ((
                  todo[/* completed */2] ? "checked" : ""
                ) + (">\n\t\t\t\t\t<label>" + (todo[/* title */0] + "</label>\n\t\t\t\t\t<button class='destroy'></button>\n\t\t\t\t</div>\n\t\t\t\t<input class='edit' value='as'>\n\t\t\t</li>")))));
  };
  return $$String.concat("", $$Array.to_list($$Array.map(f, todos)));
}

function footerTemplate(activeTodoCount, activeTodoWord, _, filter) {
  var sel_active = function (n) {
    if (Caml_obj.caml_equal(filter, n)) {
      return "class='selected'";
    }
    else {
      return "";
    }
  };
  var ac = Pervasives.string_of_int(activeTodoCount);
  return "<span id='todo-count'><strong>" + (ac + ("</strong> " + (activeTodoWord + (" left</span>\n\t\t\t<ul id='filters'>\n\t\t\t\t<li>\n\t\t\t\t\t<a " + (sel_active(/* All */0) + (" href='#/all'>All</a>\n\t\t\t\t</li>\n\t\t\t\t<li>\n\t\t\t\t\t<a " + (sel_active(/* Active */1) + (" href='#/active'>Active</a>\n\t\t\t\t</li>\n\t\t\t\t<li>\n\t\t\t\t\t<a " + (sel_active(/* Completed */2) + " href='#/completed'>Completed</a>\n\t\t\t\t</li>\n\t\t\t</ul><button id='clear-completed'>Clear completed</button>")))))))));
}

exports.todoTemplate   = todoTemplate;
exports.footerTemplate = footerTemplate;
/* No side effect */
