(function ($) {
    $.widget("nmk.xnfile", {
        options: {
            id: "xnfile",
            multiple: true
        },

        _create: function () {
            var id = this.element.attr("id");
            if (id != undefined)
                this.options.id = id;
            $(this).data("tasks", []);
            this.element.append(
                "<div class=\"file2-file\">"
                + "<div class='files'></div>"
                + "<form action=\"/Portal/Sheets/bidding/InviteBidsHandler.ashx?Command=UploadFile\" enctype=\"multipart/form-data\" method=\"post\" target=\"file2_iframe"
                + this.options.id
                + "\">"
                + "<input name=\"file\" type=\"file\" />"
                + "</form>"
                + "<iframe name=\"file2_iframe"
                + this.options.id
                + "\" style=\"display:none\"></iframe></div>"
            );
            this._render();
            this.element.on("change", "input[type=file]", $.proxy(this._onFileChanged, this));
        },

        _setOption: function (key, value) {
            if (key === "multiple") {
                this.options.multiple = value;
            }
            this._super(key, value);
        },

        _setOptions: function (options) {
            this._super(options);
        },

        _render: function () {
            var _this = this;
            var tasks = $(this).data("tasks");
            if (tasks.length > 0) {
                var html = "";
                for (var i = 0; i < tasks.length; i++) {
                    var task = tasks[i];
                    if (task.state == "upload") {
                        html += "<div class='file' data-index='" + i + "'>"
                            + task.filename
                            + "...上传中</div>";
                    }
                    else {
                        html += "<div class='file' data-index='" + i + "'>"
                            + "<a href='/Portal/Sheets/bidding/InviteBidsHandler.ashx?Command=DownloadFile&file="
                            + task.filename
                            + "'>" + task.filename + "</a>"
                            + "&nbsp;&nbsp;<a href='javascript:void(0)' class='delete-file'><span class='glyphicon glyphicon-remove'></span></a>"
                            + "</div>";
                    }
                }
                $(".files", this.element).html(html);
                this.element.off("click", ".delete-file");
                this.element.on("click", ".delete-file", function () {
                    var idx = parseInt($(this).closest("div").attr("data-index"));
                    tasks.splice(idx, 1);
                    $(this).closest("div").remove();
                });
            }
        },

        _onFileChanged: function () {
            var filename = $("input[type=file]", this.element).val().split("\\").pop();
            if (filename != "") {
                if (!this.options.multiple) {
                    this.options.tasks = [];
                }
                var tasks = $(this).data("tasks");
                tasks.push({
                    filename: filename,
                    state: "upload"
                });
                $("form", this.element).submit();
                $("[name=file]", this.element).prop("disabled", true);
                this._render();
                setTimeout($.proxy(this._checkState, this), 1000);
            }
            
        },

        _getUploadFilename: function () {
            var tasks = $(this).data("tasks");
            for (var i = 0; i < tasks.length; i++) {
                var task = tasks[i];
                if (task.state == "upload")
                    return task.filename;
            }
            return null;
        },

        _checkState: function () {
            var _this = this;
            $.getJSON("/Portal/Sheets/bidding/InviteBidsHandler.ashx?Command="
                + "IsFileExists&file="
                + this._getUploadFilename(), function (data) {
                    if (data.found === "true") {
                        var tasks = $(_this).data("tasks");
                        for (var i = 0; i < tasks.length; i++)
                            tasks[i].state = "done";
                        _this._render();
                        $("[name=file]", _this.element).prop("disabled", false);
                    }
                    else {
                        setTimeout($.proxy(_this._checkState, _this), 1000);
                    }
                });
        },

        value: function (value) {
            var tasks = $(this).data("tasks");
            if (value === undefined) {
                if (this.options.multiple) {
                    var result = [];
                    if (tasks.length > 0) {
                        for (var i = 0; i < tasks.length; i++) {
                            result.push(tasks[i].filename);
                        }
                    }
                    return result;
                }
                else {
                    if (tasks.length == 0) {
                        return "";
                    }
                    else {
                        return tasks[0].filename;
                    }
                }
            }
            else {
                if (Array.isArray(value)) {
                    for (var i = 0; i < value.length; i++) {
                        tasks.push({
                            filename: value[i],
                            state: "done"
                        });
                    }
                }
                else {
                    tasks.push({
                        filename: value,
                        state: "done"
                    });
                }
                this._render();
            }
        }

    });
}(jQuery));
