(function($) {
    $.widget("nmk.xntable", {

        options: {
            value: null
        },

        _create: function() {
            this.element.append(this.createToolbar() + this.createTable());
            this.bindEvent();
            return this;
        },

        bindEvent: function() {
            this.onAdd();
            this.onRemove();
            this.onLeft();
            this.onRight();
            this.onUp();
            this.onDown();
            this.onTdClick();
            this.onTdDblClick();
        },

        createToolbar: function() {
            return "<div class='btn-toolbar' role='toolbar' aria-label='预算工具栏'>"
                + "<div class='btn-group' role='group' aria-label=''>"
                + "<button id='add-btn' type='button' class='btn btn-default' title='在选定行下增加预算'>+</button>" 
                + "<button id='remove-btn' type='button' class='btn btn-default' title='删除选定行'>-</button>"
                + "<button id='left-btn' type='button' class='btn btn-default' title='升级'>←</button>"
                + "<button id='right-btn' type='button' class='btn btn-default' title='降级'>→</button>"
                + "<button id='up-btn' type='button' class='btn btn-default' title='上移'>↑</button>"
                + "<button id='down-btn' type='button' class='btn btn-default' title='下移'>↓</button>"
                + "</div>"
                + "</div>";
        },

        createTable: function() {
            return "<table class='xn-table'>"
                + "<thead>"
                + "<th width='10%'>序号</th>"
                + "<th width='30%'>科目</th>"
                + "<th width='20%'>预算</th>"
                + "<th width='20%'>已使用</th>"
                + "<th width='20%'>余额</th>"
                + "</thead>"
                + "<tbody>"
                + "</tbody>"
                + "</table>";
        },

        value: function(value) {
            if (value == undefined) {
                return this.getValue();
            }
            else {
                this.options.value = value;
                this.render();
            }
        },

        render: function() {
            $("tbody", this.element).empty();
            if (this.options.value.length > 0) {
                for (var i = 0; i < this.options.value.length; i++) {
                    var v = this.options.value[i];
                    $("table>tbody", this.element).append("<tr"
                        + (v.isChild ? " class='child'" : "") + ">"
                        + "<td>" + (i + 1) + "</td>"
                        + "<td" + (v.isChild ? " class='indent'" : "") + ">" + v.name + "</td>"
                        + "<td>" + v.budget + "</td>"
                        + "<td>" + v.spent + "</td>"
                        + "<td>" + (v.budget - v.spent) + "</td>"
                        + "</tr>"
                    );
                }
                this.onChange(this);
            }
        },

        getValue: function() {
            var result = [];
            var count = 0;
            $("tbody>tr", this.element).each(function() {
                var item = {
                    position: $("td:nth-child(1)", this).html(),
                    name: $("td:nth-child(2)", this).html(),
                    budget: $("td:nth-child(3)", this).html(),
                    spent: $("td:nth-child(4)", this).html(),
                    isChild: $(this).hasClass("child")
                };
                result.push(item);
            });
            return result;
        },

        onAdd: function() {
            var self = $(this);
            $("#add-btn", this.element).click($.proxy(function() {
                $("table>tbody", self.element).append("<tr>"
                    + "<td></td>"
                    + "<td>&lt;新增科目&gt;</td>"
                    + "<td>0</td>"
                    + "<td>0</td>"
                    + "<td>0</td>"
                    + "</tr>"
                );
                this.reindex();
            }, this));
        },

        reindex: function() {
            var idx = 1;
            $("tbody>tr", this.element).each(function() {
                $("td:first", this).text(idx + "");
                idx++;
            });
        },

        onRemove: function() {
            var self = $(this);
            $("#remove-btn", this.element).click($.proxy(function() {
                var tr = $("table>tbody>tr.active", self.element);
                if (tr.length) {
                    if (confirm("确定要删除选中预算吗？")) {
                        tr.remove();
                        var idx = 1;
                        $("tbody>tr", self.element).each(function() {
                            $("td:first", this).text(idx + "");
                            idx++;
                        });
                        this.reindex();
                    }
                }
            }, this));
        },

        onLeft: function() {
            var self = $(this);
            $("#left-btn", this.element).click($.proxy(function() {
                var tr = $("tbody>tr.active", self.element);
                if (tr.length) {
                    var row = tr.parent().children().index(tr);
                    if (tr.hasClass("child")) {
                        tr.removeClass("child");
                        $("td:nth-child(2)", tr).removeClass("indent");
                        this.onChange(self[0]);
                    }
                }
            }, this));
        },

        onRight: function() {
            var self = $(this);
            $("#right-btn", this.element).click($.proxy(function() {
                var tr = $("tbody>tr.active", self.element);
                if (tr.length) {
                    var row = tr.parent().children().index(tr);
                    if (row > 0 && !tr.hasClass("child")) {
                        tr.addClass("child");
                        $("td:nth-child(2)", tr).addClass("indent");
                        this.onChange(self[0]);
                    }
                }
            }, this));
        },

        onUp: function() {
           var self = $(this);
            $("#up-btn", this.element).click($.proxy(function() {
                var selrow = $("tr.active", self.element);
                if (selrow.length) {
                    if (selrow.hasClass("child")) {
                        if (selrow.prev().hasClass("child")) {
                            selrow.insertBefore(selrow.prev());
                            this.onChange(self[0]);
                            this.reindex();
                        }
                    }
                    else {
                        var row = selrow.parent().children().index(selrow);
                        if (row > 0) {
                            for (var i = row - 1; i > -1; i--) {
                                var r = $(selrow.parent().children().get(i));
                                if (!r.hasClass("child")) {
                                    selrow.insertBefore(r);
                                    this.onChange(self[0]);
                                    this.reindex();
                                    break;
                                }
                            }
                        }
                    }
                }
            }, this));
        },

        onDown: function() {
           var self = $(this);
            $("#down-btn", this.element).click($.proxy(function() {
                var selrow = $("tr.active", self.element);
                if (selrow.length) {
                    if (selrow.hasClass("child")) {
                        if (selrow.next().hasClass("child")) {
                            selrow.insertAfter(selrow.next());
                            this.onChange(self[0]);
                            this.reindex();
                        }
                    }
                    else {
                        var row = selrow.parent().children().index(selrow);
                        if (row < selrow.parent().children().length - 1) {
                            for (var i = row + 1; i < selrow.parent().children().length; i++) {
                                var r = $(selrow.parent().children().get(i));
                                if (!r.hasClass("child")) {
                                    selrow.insertAfter(r);
                                    this.onChange(self[0]);
                                    this.reindex();
                                    break;
                                }
                            }
                        }
                    }
                }
            }, this));
        },
 
        onTdClick: function() {
            var self = $(this);
            $(this.element).on("click", "tbody>tr", $.proxy(function(e) {
                e.stopPropagation();
                var tbody = $(e.target).closest("tbody");
                var input = $(".xn-inline-input", tbody);
                if (input.length) {
                    var td = input.closest("td");
                    td.html(input.val());
                    this.onChange(self[0]);
                }
                var tbody = $(e.target).closest("tbody");
                $("tr", tbody).removeClass("active");
                $(e.target).closest("tr").addClass("active");
            }, this));
        },

        onTdDblClick: function() {
            var self = $(this);
            $(this.element).on("dblclick", "tbody td", $.proxy(function(e) {
                var col = $(e.target).parent().children().index($(e.target));
                var ele = $(e.target);
                var value = $(e.target).html();
                if (col > 0 && col < 4) {
                    $(ele).html("<input type='"
                        + (col == 1 ? "text" : "number")
                        + "' class='form-control xn-inline-input' value='" 
                        + value + "'/>");
                    $("input", ele).select().focus();
                    $("input", ele).keyup(function(e) {
                        if (e.keyCode == 13) {
                            $(ele).html($(".xn-inline-input", ele).val());
                            this.onChange(self[0]);
                        }
                    });
                }
                $(document).click($.proxy(function() {
                    $(ele).html($(".xn-inline-input", ele).val());
                    this.onChange(self[0]);
                }, this));
            }, this));
        },

        onChange: function(self) {
            var parent = null;
            var budget = 0;
            var spent = 0;
            $("tbody>tr", self.element).each(function() {
                if ($(this).hasClass("child")) {
                    var b = parseInt($("td:nth-child(3)", this).html(), "10");
                    var s = parseInt($("td:nth-child(4)", this).html(), "10");
                    budget += b;
                    spent += s;
                    $("td:nth-child(5)", this).html(b - s);
                }
                else {
                    if (parent != null && budget > 0) {
                        $("td:nth-child(3)", parent).html(budget);
                        $("td:nth-child(4)", parent).html(spent);
                        $("td:nth-child(5)", parent).html(budget - spent);
                    }
                    else {
                        var b = parseInt($("td:nth-child(3)", this).html(), "10");
                        var s = parseInt($("td:nth-child(4)", this).html(), "10");
                        $("td:nth-child(3)", this).html(b);
                        $("td:nth-child(4)", this).html(s);
                        $("td:nth-child(5)", this).html(b - s);
                    }
                    parent = this;
                    budget = 0;
                    spent = 0;
                }
                if (parent != null && budget > 0) {
                    $("td:nth-child(3)", parent).html(budget);
                    $("td:nth-child(4)", parent).html(spent);
                    $("td:nth-child(5)", parent).html(budget - spent);
                }
            });
        }

    });
}(jQuery));