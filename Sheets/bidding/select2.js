(function($) {
    $.widget("nmk.xnselect", {
        options: {
            value: "",
            menu: []
        },

        _create: function() {
            var menuHtml = "<ul class=\"dropdown-menu\">\n";
            if (this.options.menu.length > 0) {
                for (var i = 0; i < this.options.menu.length; i++) {
                    var menu = this.options.menu[i];
                    menuHtml += "<li><a href=\"javascript:void(0)\" data-value=\""
                        + menu.value
                        + "\">" 
                        + menu.text
                        + "</a></li>\n"
                }
            }
            menuHtml += "</ul>";
            this.element
                .empty()
                .addClass("input-group dropdown")
                .append(
                    "<input type=\"text\" class=\"form-control input-text dropdown-togge\" value=\"\">\n"
                    + menuHtml
                    + "<span role=\"button\" class=\"input-group-addon dropdown-toggle\" data-toggle=\"dropdown\" aria-haspopup=\"true\" aria-expanded=\"false\"><span class=\"caret\"></span></span>\n"
                    + "</div>"
                );
            $('.dropdown-menu a', this.element).click(function() {
                $(this).closest('.dropdown').find('input.input-text')
                    .val($(this).text());
            });
            $('.input-text', this.element).val(this.options.value);
            return this;
        },

        value: function(value) {
            if (value === undefined) {
                return this.options.value;
            }
            else {
                this.options.value = value;
                $(".input-text", this.element).val(value);
            }
        }
    });
}(jQuery));
