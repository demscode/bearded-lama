
// Require jQuery
// Methods called from validators and element events.

function jsValidateEditEmail(source, args) {
    var emailRegex = /^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/
    var isValid = args.Value.match(emailRegex);

    args.IsValid = flagInputError(source.id, args.Value, isValid);
}

function jsValidateEditUserDescription(source, args) {
    var maxChars = 200;
    var isValid = args.Value.trim().length <= maxChars;

    args.IsValid = flagInputError(source.id, args.Value, isValid);
}

function flagInputError(elementId, elementValue, validityExpression) {
    var isValid = false;

    if (elementValue.trim() == "") {
        isValid = true; // empty input
    } else {
        isValid = validityExpression;
    }

    if (isValid) {
        $("#" + elementId).prev(".form-control").parent().parent().removeClass("has-error");
    } else {
        $("#" + elementId).prev(".form-control").parent().parent().addClass("has-error");
    }

    return isValid;
}

function jsValidateAttachmentSize(source, args) {
    args.IsValid = false;
    var maxSize = 200000;

    var size = ($('#' + source.controltovalidate).get())[0].files[0].size;
    args.IsValid = size <= maxSize;
}
