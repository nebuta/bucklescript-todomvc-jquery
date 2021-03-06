// Generated by BUCKLESCRIPT VERSION 1.0.3 , PLEASE EDIT WITH CARE
'use strict';

var Curry      = require("bs-platform/lib/js/curry");
var Caml_array = require("bs-platform/lib/js/caml_array");
var $$Array    = require("bs-platform/lib/js/array");

function array_append(e, arr) {
  arr[arr.length] = e;
  return /* () */0;
}

function array_filter(pred, arr) {
  var ret = /* array */[];
  var f = function (x) {
    if (Curry._1(pred, x)) {
      return array_append(x, ret);
    }
    else {
      return 0;
    }
  };
  $$Array.iter(f, arr);
  return ret;
}

function array_splice(i, arr) {
  var a1 = $$Array.sub(arr, 0, i);
  var a2 = $$Array.sub(arr, i + 1 | 0, (arr.length - i | 0) - 1 | 0);
  return $$Array.append(a1, a2);
}

function array_range(n) {
  var arr = Caml_array.caml_make_vect(n, 0);
  for(var i = 0 ,i_finish = n - 1 | 0; i <= i_finish; ++i){
    arr[i] = i;
  }
  return arr;
}

function findi(a, pred) {
  try {
    var a$1 = a;
    var pred$1 = pred;
    var _n = 0;
    while(true) {
      var n = _n;
      if (Curry._1(pred$1, a$1[n])) {
        return /* Some */[n];
      }
      else {
        _n = n + 1 | 0;
        continue ;
        
      }
    };
  }
  catch (exn){
    return /* None */0;
  }
}

exports.array_append = array_append;
exports.array_filter = array_filter;
exports.array_splice = array_splice;
exports.array_range  = array_range;
exports.findi        = findi;
/* No side effect */
