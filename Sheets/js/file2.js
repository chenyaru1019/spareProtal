(function($) {
    $.widget("nmk.xnfile", {
        options: {
            basePath: "",
            files: [],
            curfile: "",
            multiple: true,
            state: "wait",
            id: "file2"
        },

        _getOptions: function(e) {
            if ($(e).data("options") == undefined) {
                $(e).data("options", {
                    basePath: "",
                    files: [],
                    curfile: "",
                    multiple: true,
                    state: "wait",
                    id: "file2"
                });
            }
            return $(e).data("options");
        },

        _create: function() {
            var id = this.element.attr("id");
            var options = this._getOptions(this.element);

            if (id != undefined)
                options.id = id;
            if (options.files.length > 0) {
                options.state = "wait";
            }
            else {
                options.state = "done";
            }
            this.element.append(
                  "<div class=\"file2-done\"><div class='template' style='margin:4px'><a></a><input id=\"del-btn\" style=\"display:inline;margin-left:8px\" value=\"删除\" class=\"btn btn-default\" type=\"button\"></input></div></div>"
                + "<div   class=\"file2-file\">"
                      + "<label><input id=\"filesort1\" type=\"radio\" value=\"normal\" checked/>普通文件 </label>" 
                      + "<label><input id=\"filesort2\" type=\"radio\" value=\"big\" />大文件(100M以上) </label>"
                    + "<div id=\"fileTabContent\">"
                        + "<div style=\"display:block\" id=\"tabnormalfile\">"
                        + "<form id=\"normalform\" action=\"/Portal/Sheets/xnfile/XnfileHandler.ashx?Command=UploadFile\" enctype=\"multipart/form-data\" method=\"post\" target=\"file2_iframe" + options.id + "\">"
                        + "<input id=\"btnuploadfile\" name=\"file\" type=\"file\" />"
                        + "<input type='hidden' name='base-path' id='base-path' />"
                        + "</form>"
                        + "</div>"
                        + "<div style=\"display:none\" id=\"tabbigfile\">"
                        + "<form id=\"bigform\">"
                        + "<select id=\"bigfilelist\">"
                        + "</select>"
                        + "<input id=\"uploadbigfileBtn\" type=\"button\" value=\"选取\" />"
                        + "</form>"
                        + "</div>"
                    + "</div>"
                + "</div>"
                + "<div class=\"file2-tips\">上传中</div>"

                + "<iframe name=\"file2_iframe" + options.id + "\" style=\"display:none\">"
                + "</iframe>"
                
            );
            this._update();
            this._getBigFiles();
            this.element.on("change", "input[type=file]", $.proxy(this._onFileChanged, this));
            this.element.on("click", "#uploadbigfileBtn", $.proxy(this._onBigFileChanged, this));
            this.element.on("click", "#filesort1", $.proxy(this._onTabShow1, this));
            this.element.on("click", "#filesort2", $.proxy(this._onTabShow2, this));
        },

        _onTabShow1: function(e) {
            this._onTabShow(1);            
        },

        _onTabShow2: function(e) {            
            this._onTabShow(2);            
        },

        _onTabShow: function(sort) {
            if(sort == 1) {
                $("#filesort1", this.element).attr("checked","checked");
                $("#filesort2", this.element).removeAttr("checked");
                $("#tabnormalfile", this.element).css('display','block');
                $("#tabbigfile", this.element).css('display','none');
            } else {
                $("#filesort1", this.element).removeAttr("checked");
                $("#filesort2", this.element).attr("checked","checked");
                $("#tabnormalfile", this.element).css('display','none');
                $("#tabbigfile", this.element).css('display','block');
                
            }

        },

        _onBigFileChanged: function() {
            var filename = $("#bigfilelist", this.element).val();
            var options = this._getOptions(this.element);
            if (filename != "") {
                options.files.push(filename);
                var clone = $("div.file2-done>div.template", this.element).clone().removeClass("template");
                $("a", clone)
                    .attr("href",
                    "/Portal/Sheets/xnfile/XnfileHandler.ashx?"
                    + "Command=DownloadFile&file="
                    + filename)
                    .text(filename);
                $("#del-btn", clone).click(function () {
                    var parent = $(this).closest("div");
                    var filename = $("a", parent).text();
                    for (var i = 0; i < options.files.length; i++) {
                        if (options.files[i] == filename) {
                            options.files.splice(i, 1);
                            break;
                        }
                    }
                    parent.remove();
                });
                $("div.file2-done", this.element).append(clone);
            }
        },

        _onFileChanged: function() {
            var filename = $("input[type=file]", this.element).val().split("\\").pop();
            var options = this._getOptions(this.element);
            if (filename != "") {
                options.files.push(filename);
                options.curfile = filename;
                $("#normalform #base-path", this.element).val(options.basePath);
                $("#normalform", this.element).submit();
                options.state = "upload";
                this._update();
                setTimeout($.proxy(this._checkState, this), 1000);
            }
        },

        _checkState: function() {
            var _this = this;
            var options = this._getOptions(this.element);
            $.getJSON("/Portal/Sheets/xnfile/XnfileHandler.ashx",
                {
                    Command: "IsFileExists",
                    basePath: options.basePath,
                    file: options.curfile
                },
                function(data) {
                    if (data.found === "true") {
                        if (!options.multiple) {
                            $("div.file2-done>div.data", _this.element).remove(); 
                            options.files = [options.curfile];
                        }
                        options.state = "done";
                        _this._update();
                    }
                    else {
                        setTimeout($.proxy(_this._checkState, _this), 1000);
                    }
                });
        },

        _getBigFiles: function() {
            var _this = this;
            $.getJSON(
                "/Portal/Sheets/xnfile/XnfileHandler.ashx?Command=GetBigFileList", 
                function(data) {
                    if (data.length > 0) {
                        for (var i = 0; i < data.length; i++) {
                            $("#bigfilelist", _this.element).append("<option value='" + data[i].url + "'>"+data[i].fn+"("+data[i].size+")"+"</option>"); 
                        }
                    }
                    else {
                        setTimeout($.proxy(_this._getBigFiles, _this), 1000);
                    }
            });
        },

        _update: function() {
            var options = this._getOptions(this.element);
            $("div.file2-done>div.data", this.element).remove();
            if (options.files.length > 0) {
                for (var i = 0; i < options.files.length; i++) {
                    var clone = $("div.file2-done>div.template", this.element)
                        .clone().removeClass("template").addClass("data");
                    $("a", clone)
                        .attr("href", 
                        "/Portal/Sheets/xnfile/XnfileHandler.ashx?"
                        + "Command=DownloadFile&file=" 
                        + options.basePath + "/" + options.files[i])
                        .text(options.files[i]);
                    $("#del-btn", clone).click(function() {
                        var parent = $(this).closest("div");
                        var filename = $("a", parent).text();
                        for (var i = 0; i < options.files.length; i++) {
                            if (options.files[i] == filename) {
                                options.files.splice(i, 1);
                                break;
                            }
                        }
                        parent.remove();
                    });
                    $("div.file2-done", this.element).append(clone);
                }
            }

            if (options.state == "upload") {
                $("div.file2-file", this.element).hide();
                $("div.file2-upload", this.element).show();
                $("div.file2-done", this.element).show();
                $("div.file2-tips", this.element).show();
            }
            else {
                $("div.file2-upload", this.element).hide();
                $("div.file2-done", this.element).show();
                $("div.file2-file", this.element).show();
                $("div.file2-tips", this.element).hide();
            }
        },        

        getFullPath: function(basePath, files) {
            var result = [];
            if (files.length > 0) {
                for (var i = 0; i < files.length; i++) {
                    result.push(basePath + "\\" + files[i]);
                }
            }
            return result;
        },

        trimBasePath: function(files) {
            if (files.length == 0)
                return files;
            var result = [];
            for (var i = 0; i < files.length; i++) {
                result.push(files[i].split("\\").pop());
            }
            return result;
        },

        value: function(value) {
            var options = this._getOptions(this.element);
            if (value === undefined) {
                if (options.multiple) {
                    return this.getFullPath(options.basePath, options.files);
                }
                else {
                    if (options.files.length == 0) {
                        return "";
                    }
                    else {
                        return this.getFullPath(options.basePath, options.files)[0];
                    }
                }
            }
            else {
                if (options.multiple) {
                    options.files = this.trimBasePath(value);
                }
                else {
                    options.files = [value.split("\\").pop()];
                }
                this._update();
            }
        },

        _setOption: function(key, value) {
            var options = this._getOptions(this.element);
            if (key === "multiple") {
                options.multiple = value;
            }
            else if (key == "basePath") {
                options.basePath = value;
            }
            this._super(key, value);
        }
    });
}(jQuery));

