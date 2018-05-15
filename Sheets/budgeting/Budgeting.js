$.MvcSheet.Loaded = function(sheetInfo) {
    (function() {

        function init() {
            $("li[data-action=Save]").hide();
            $("li[data-action=Submit]").hide();
            $("li[data-action=ViewInstance]").hide();
            $("#budgeting-table").xntable();

            $.getJSON(
                "Budgeting.ashx",
                {
                    Command: "LoadYears"
                },
                function(data) {
                    for (var i = 0; i < data.length; i++) {
                        $("#year-select").append("<option value='"
                            + data[i] + "' "
                            + (i == data.length - 1 ? "selected" : "")
                            + ">" + data[i]
                            + "</option>" 
                        );
                    }
                    onYearChanged();
                }
            );
            $("#year-select").change(onYearChanged);

            $("#load-prev-btn").click(onLoadFromLastYear);
            $("#save-btn").click(onSave);
            $("#confirm-btn").click(function() {
                $.getJSON(
                    "Budgeting.ashx",
                    {
                        Command: "Confirm",
                        year: $("#year-select").val()
                    },
                    function(data) {
                        if (data.success) {
                            alert("已确认。");
                        }
                        else {
                            alert("确认失败。");
                        }
                    }
                );
            });
            $("#confirm-cancel-btn").click(function() {
                $.getJSON(
                    "Budgeting.ashx",
                    {
                        Command: "CancelConfirm",
                        year: $("#year-select").val()
                    },
                    function(data) {
                        if (data.success) {
                            alert("已取消确认。");
                        }
                        else {
                            alert("取消确认失败。");
                        }
                    }
                );
            });
         }

        function onYearChanged() {
            $.getJSON(
                "Budgeting.ashx",
                {
                    Command: "Load",
                    year: $("#year-select").val()
                },
                function(data) {
                    $("#budgeting-table").xntable("value", data);
                }
            )
        }

        function onSave() {
            $.getJSON(
                "Budgeting.ashx",
                {
                    Command: "IsConfirmed",
                    year: $("#year-select").val()
                },
                function(data) {
                    if (!data.confirmed) {
                        $.getJSON(
                            "Budgeting.ashx",
                            {
                                Command: "Save",
                                year: $("#year-select").val(),
                                data: JSON.stringify($("#budgeting-table").xntable("value"))
                            },
                            function(data) {
                                if (data.success) {
                                    alert("已保存。");
                                }
                                else {
                                    alert("保存失败。");
                                }
                            }
                        )
                    }
                    else {
                        alert("预算已确认，不可修改。");
                    }
                }
            )
        }

        function onLoadFromLastYear() {
            var lastYear = $("#year-select").val() - 1;
            $.getJSON(
                "Budgeting.ashx",
                {
                    Command: "Load",
                    year: lastYear 
                },
                function(data) {
                    $("#budgeting-table").xntable("value", data);
                }
            );
        }

        init();

    })();
}
