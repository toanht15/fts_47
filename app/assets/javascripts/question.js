$(document).on("click", ".add_answer", function() {
  var association = $(this).attr("name");
  var regexp = new RegExp("new_" + association, "g");
  var new_id = new Date().getTime();
  $(this).parent().before(window[association + "_form"].replace(regexp, new_id));
  return false;
});

$(document).on("click", ".remove", function() {
  $(this).closest(".field").remove();
  return false;
});

function addForm() {
  var association = "answers";
  var regexp = new RegExp("new_" + association, "g");
  var new_id = new Date().getTime();
  $(".add_answer").parent().before(window[association + "_form"].replace(regexp, new_id));
  $(".correct-choose").hide();
  $(".remove-choose").hide();
}

function changeType() {
  var options = $(".field");
  options.remove();
}

var prev;
$(document).on("focus", ".question-type", function() {
  prev = this.value;
});

$(document).on("change", ".question-type", function() {
  if($(this).val() == "single_choice") {
    $(".add_answer").show();
    var allCheckboxs = $(".correct");
    allCheckboxs.each(function(index, cb) {
      $(cb).attr("checked", false);
    })
    if(prev == "text"){
      changeType();
    }
  } else if ($(this).val() == "multiple_choices") {
    $(".add_answer").show();
    if(prev == "text"){
      changeType();
    }
  } else if($(this).val() == "text") {
    $(".add_answer").hide();
    changeType();
    addForm();
    var allCheckboxs = $(".correct");
    allCheckboxs.each(function(index, cb) {
      $(cb).attr("checked", true);
    })
  }
  prev = $(this).val();
});
